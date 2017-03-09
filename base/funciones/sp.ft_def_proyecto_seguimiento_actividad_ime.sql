CREATE OR REPLACE FUNCTION "sp"."ft_def_proyecto_seguimiento_actividad_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_actividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_seguimiento_actividad'
 AUTOR: 		 (admin)
 FECHA:	        24-02-2017 05:02:05
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
	v_id_def_proyecto_seguimiento_actividad	integer;
			    
BEGIN

    v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_actividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_PRSEAC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		24-02-2017 05:02:05
	***********************************/

	if(p_transaccion='SP_PRSEAC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sp.tdef_proyecto_seguimiento_actividad(
			id_def_proyecto_seguimiento,
			id_def_proyecto_actividad,
			estado_reg,
			porcentaje_avance,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_def_proyecto_seguimiento,
			v_parametros.id_def_proyecto_actividad,
			'activo',
			v_parametros.porcentaje_avance,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_def_proyecto_seguimiento_actividad into v_id_def_proyecto_seguimiento_actividad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Seguimiento de proyecto actividad almacenado(a) con exito (id_def_proyecto_seguimiento_actividad'||v_id_def_proyecto_seguimiento_actividad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_seguimiento_actividad',v_id_def_proyecto_seguimiento_actividad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SP_PRSEAC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		24-02-2017 05:02:05
	***********************************/

	elsif(p_transaccion='SP_PRSEAC_MOD')then

		begin
			--Sentencia de la modificacion
			update sp.tdef_proyecto_seguimiento_actividad set
			id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento,
			id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad,
			porcentaje_avance = v_parametros.porcentaje_avance,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_def_proyecto_seguimiento_actividad=v_parametros.id_def_proyecto_seguimiento_actividad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Seguimiento de proyecto actividad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_seguimiento_actividad',v_parametros.id_def_proyecto_seguimiento_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SP_PRSEAC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		24-02-2017 05:02:05
	***********************************/

	elsif(p_transaccion='SP_PRSEAC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sp.tdef_proyecto_seguimiento_actividad
            where id_def_proyecto_seguimiento_actividad=v_parametros.id_def_proyecto_seguimiento_actividad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Seguimiento de proyecto actividad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_seguimiento_actividad',v_parametros.id_def_proyecto_seguimiento_actividad::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "sp"."ft_def_proyecto_seguimiento_actividad_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
