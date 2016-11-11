--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS'
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla ''sp.tdef_proyecto''
 AUTOR: 		 (admin)
 FECHA:	        08-02-2017 19:56:10
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
	v_id_def_proyecto	integer;

BEGIN

    v_nombre_funcion = ''sp.ft_def_proyecto_ime'';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  ''SP_DEFPROY_INS''
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin
 	#FECHA:		08-02-2017 19:56:10
	***********************************/

	if(p_transaccion=''SP_DEFPROY_INS'')then

        begin
        	--Sentencia de la insercion
        	insert into sp.tdef_proyecto(
			fecha_inicio_teorico,
			descripcion,
			fecha_fin_teorico,
			estado_reg,
			id_proyecto,
			id_usuario_ai,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.fecha_inicio_teorico,
			v_parametros.descripcion,
			v_parametros.fecha_fin_teorico,
			''activo'',
			v_parametros.id_proyecto,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			null,
			null



			)

            RETURNING id_def_proyecto into v_id_def_proyecto;
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,''mensaje'',''definición proyecto almacenado(a) con exito (id_def_proyecto''||v_id_def_proyecto||'')'');
            v_resp = pxp.f_agrega_clave(v_resp,''id_def_proyecto'',v_id_def_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  ''SP_DEFPROY_MOD''
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin
 	#FECHA:		08-02-2017 19:56:10
	***********************************/

	elsif(p_transaccion=''SP_DEFPROY_MOD'')then

		begin
			--Sentencia de la modificacion
			update sp.tdef_proyecto set
			fecha_inicio_teorico = v_parametros.fecha_inicio_teorico,
			descripcion = v_parametros.descripcion,
			fecha_fin_teorico = v_parametros.fecha_fin_teorico,
			id_proyecto = v_parametros.id_proyecto,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_def_proyecto=v_parametros.id_def_proyecto;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,''mensaje'',''definición proyecto modificado(a)'');
            v_resp = pxp.f_agrega_clave(v_resp,''id_def_proyecto'',v_parametros.id_def_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  ''SP_DEFPROY_ELI''
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin
 	#FECHA:		08-02-2017 19:56:10
	***********************************/

	elsif(p_transaccion=''SP_DEFPROY_ELI'')then

		begin
			--Sentencia de la eliminacion
			delete from sp.tdef_proyecto
            where id_def_proyecto=v_parametros.id_def_proyecto;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,''mensaje'',''definición proyecto eliminado(a)'');
            v_resp = pxp.f_agrega_clave(v_resp,''id_def_proyecto'',v_parametros.id_def_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	else

    	raise exception ''Transaccion inexistente: %'',p_transaccion;

	end if;

EXCEPTION

	WHEN OTHERS THEN
		v_resp='''';
		v_resp = pxp.f_agrega_clave(v_resp,''mensaje'',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,''codigo_error'',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,''procedimientos'',v_nombre_funcion);
		raise exception ''%'',v_resp;

END;
'LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;