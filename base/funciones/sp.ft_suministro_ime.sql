--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_suministro_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_suministro_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tsuministro'
 AUTOR: 		 (admin)
 FECHA:	        12-11-2016 14:03:32
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
	v_id_seguimiento_suministro	integer;
			    
BEGIN

    v_nombre_funcion = 'sp.ft_suministro_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_SUM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 14:03:32
	***********************************/

	if(p_transaccion='SP_SUM_INS')then
        begin
        	 if (v_parametros.tipo_guardar=false) THEN		

        	--Sentencia de la insercion
        	insert into sp.tsuministro(
			id_def_proyecto,
			id_def_proyecto_actividad,
			documento_emarque,
			estado_reg,
			invitacion,
			adjudicacion,
			llegada_sitio,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_def_proyecto,
			v_parametros.id_def_proyecto_actividad,
			v_parametros.documento_emarque,
			'activo',
			v_parametros.invitacion,
			v_parametros.adjudicacion,
			v_parametros.llegada_sitio,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_seguimiento_suministro into v_id_seguimiento_suministro;
		else
        
        update sp.tsuministro set
			id_def_proyecto = v_parametros.id_def_proyecto,
			id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad,
			documento_emarque = v_parametros.documento_emarque,
			invitacion = v_parametros.invitacion,
			adjudicacion = v_parametros.adjudicacion,
			llegada_sitio = v_parametros.llegada_sitio,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_seguimiento_suministro=v_parametros.id_seguimiento_suministro;
     end if;	
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Seguimiento al suministro almacenado(a) con exito (id_seguimiento_suministro'||v_id_seguimiento_suministro||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_seguimiento_suministro',v_id_seguimiento_suministro::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SP_SUM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 14:03:32
	***********************************/

	elsif(p_transaccion='SP_SUM_MOD')then

		begin
			--Sentencia de la modificacion
			update sp.tsuministro set
			id_def_proyecto = v_parametros.id_def_proyecto,
			id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad,
			documento_emarque = v_parametros.documento_emarque,
			invitacion = v_parametros.invitacion,
			adjudicacion = v_parametros.adjudicacion,
			llegada_sitio = v_parametros.llegada_sitio,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_seguimiento_suministro=v_parametros.id_seguimiento_suministro;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Seguimiento al suministro modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_seguimiento_suministro',v_parametros.id_seguimiento_suministro::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SP_SUM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 14:03:32
	***********************************/

	elsif(p_transaccion='SP_SUM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sp.tsuministro
            where id_seguimiento_suministro=v_parametros.id_seguimiento_suministro;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Seguimiento al suministro eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_seguimiento_suministro',v_parametros.id_seguimiento_suministro::varchar);
              
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