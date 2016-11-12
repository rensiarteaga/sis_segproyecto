--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_actividad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_actividad'
 AUTOR: 		 (admin)
 FECHA:	        10-11-2016 06:41:48
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_def_proyecto_actividad	integer;
    va_id_activiada	integer[];
			    
BEGIN

    v_nombre_funcion = 'sp.ft_def_proyecto_actividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_DEPRAC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-11-2016 06:41:48
	***********************************/

	if(p_transaccion='SP_DEPRAC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sp.tdef_proyecto_actividad(
			id_def_proyecto,
			id_actividad,
			estado_reg,
			descripcion,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_def_proyecto,
			v_parametros.id_actividad,
			'activo',
			v_parametros.descripcion,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_def_proyecto_actividad into v_id_def_proyecto_actividad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DefinicionProyectoActividad almacenado(a) con exito (id_def_proyecto_actividad'||v_id_def_proyecto_actividad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad',v_id_def_proyecto_actividad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SP_DEPRAC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-11-2016 06:41:48
	***********************************/

	elsif(p_transaccion='SP_DEPRAC_MOD')then

		begin
			--Sentencia de la modificacion
			update sp.tdef_proyecto_actividad set
			id_def_proyecto = v_parametros.id_def_proyecto,
			id_actividad = v_parametros.id_actividad,
			descripcion = v_parametros.descripcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_def_proyecto_actividad=v_parametros.id_def_proyecto_actividad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DefinicionProyectoActividad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad',v_parametros.id_def_proyecto_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        /*********************************    
 	#TRANSACCION:  'SP_DEPRACS_INS'
 	#DESCRIPCION:	insertar varias actividades
 	#AUTOR:		yac	
 	#FECHA:		03-03-2017 06:41:48
	***********************************/

	elsif(p_transaccion='SP_DEPRACS_INS')then

		begin
        
            va_id_activiada = dstring_to_array(v_parametros.id_actividades, ',');
            
            
            
            
            
			--Sentencia de la modificacion
			update sp.tdef_proyecto_actividad set
			id_def_proyecto = v_parametros.id_def_proyecto,
			id_actividad = v_parametros.id_actividad,
			descripcion = v_parametros.descripcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_def_proyecto_actividad=v_parametros.id_def_proyecto_actividad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DefinicionProyectoActividad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad',v_parametros.id_def_proyecto_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SP_DEPRAC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-11-2016 06:41:48
	***********************************/

	elsif(p_transaccion='SP_DEPRAC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sp.tdef_proyecto_actividad
            where id_def_proyecto_actividad=v_parametros.id_def_proyecto_actividad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DefinicionProyectoActividad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad',v_parametros.id_def_proyecto_actividad::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;