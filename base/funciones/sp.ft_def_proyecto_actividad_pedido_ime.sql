CREATE OR REPLACE FUNCTION "sp"."ft_def_proyecto_actividad_pedido_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_pedido_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_actividad_pedido'
 AUTOR: 		 (admin)
 FECHA:	        12-11-2016 12:56:05
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
	v_id_def_proyecto_actividad_pedido	integer;
			    
BEGIN

    v_nombre_funcion = 'sp.ft_def_proyecto_actividad_pedido_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_DEPRACPE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 12:56:05
	***********************************/

	if(p_transaccion='SP_DEPRACPE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sp.tdef_proyecto_actividad_pedido(
			id_def_proyecto_actividad,
			id_pedido,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_def_proyecto_actividad,
			v_parametros.id_pedido,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			null,
			null
							
			
			
			)RETURNING id_def_proyecto_actividad_pedido into v_id_def_proyecto_actividad_pedido;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Definición proyecto actividad pedido almacenado(a) con exito (id_def_proyecto_actividad_pedido'||v_id_def_proyecto_actividad_pedido||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad_pedido',v_id_def_proyecto_actividad_pedido::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SP_DEPRACPE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 12:56:05
	***********************************/

	elsif(p_transaccion='SP_DEPRACPE_MOD')then

		begin
			--Sentencia de la modificacion
			update sp.tdef_proyecto_actividad_pedido set
			id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad,
			id_pedido = v_parametros.id_pedido,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_def_proyecto_actividad_pedido=v_parametros.id_def_proyecto_actividad_pedido;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Definición proyecto actividad pedido modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad_pedido',v_parametros.id_def_proyecto_actividad_pedido::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SP_DEPRACPE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 12:56:05
	***********************************/

	elsif(p_transaccion='SP_DEPRACPE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sp.tdef_proyecto_actividad_pedido
            where id_def_proyecto_actividad_pedido=v_parametros.id_def_proyecto_actividad_pedido;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Definición proyecto actividad pedido eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_def_proyecto_actividad_pedido',v_parametros.id_def_proyecto_actividad_pedido::varchar);
              
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
ALTER FUNCTION "sp"."ft_def_proyecto_actividad_pedido_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
