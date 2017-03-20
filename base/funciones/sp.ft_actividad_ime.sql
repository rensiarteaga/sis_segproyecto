CREATE OR REPLACE FUNCTION "sp"."ft_actividad_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_actividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tactividad'
 AUTOR: 		 (admin)
 FECHA:	        31-01-2017 21:38:35
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
	v_id_actividad	integer;
			    
BEGIN

    v_nombre_funcion = 'sp.ft_actividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_ACTI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		31-01-2017 21:38:35
	***********************************/

	if(p_transaccion='SP_ACTI_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sp.tactividad(
			id_actividad_padre,
			actividad,
			tipo_actividad,
			estado_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_actividad_padre,
			v_parametros.actividad,
			v_parametros.tipo_actividad,
			'activo',
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_actividad into v_id_actividad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad almacenado(a) con exito (id_actividad'||v_id_actividad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_id_actividad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SP_ACTI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		31-01-2017 21:38:35
	***********************************/

	elsif(p_transaccion='SP_ACTI_MOD')then

		begin
			--Sentencia de la modificacion
			update sp.tactividad set
			id_actividad_padre = v_parametros.id_actividad_padre,
			actividad = v_parametros.actividad,
			tipo_actividad = v_parametros.tipo_actividad,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_actividad=v_parametros.id_actividad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SP_ACTI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		31-01-2017 21:38:35
	***********************************/

	elsif(p_transaccion='SP_ACTI_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sp.tactividad
            where id_actividad=v_parametros.id_actividad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
              
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
ALTER FUNCTION "sp"."ft_actividad_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
