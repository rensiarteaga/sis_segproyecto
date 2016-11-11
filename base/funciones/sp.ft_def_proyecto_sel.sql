--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS'
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla ''sp.tdef_proyecto''
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = ''sp.ft_def_proyecto_sel'';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  ''SP_DEFPROY_SEL''
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		08-02-2017 19:56:10
	***********************************/

	if(p_transaccion=''SP_DEFPROY_SEL'')then

    	begin
    		--Sentencia de la consulta
			v_consulta:=''select
						defproy.id_def_proyecto,
						defproy.fecha_inicio_teorico,
						defproy.descripcion,
						defproy.fecha_fin_teorico,
						defproy.estado_reg,
						defproy.id_proyecto,
						defproy.id_usuario_ai,
						defproy.id_usuario_reg,
						defproy.usuario_ai,
						defproy.fecha_reg,
						defproy.id_usuario_mod,
						defproy.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        vcpp.nombre as desc_proyecto,
						vcpp.codproyecto

						from sp.tdef_proyecto defproy
						inner join segu.tusuario usu1 on usu1.id_usuario = defproy.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = defproy.id_usuario_mod
                        inner join sp.vcsa_proyecto_pedido vcpp on vcpp.id_proyecto=defproy.id_proyecto
				        where  '';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||'' order by '' ||v_parametros.ordenacion|| '' '' || v_parametros.dir_ordenacion || '' limit '' || v_parametros.cantidad || '' offset '' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  ''SP_DEFPROY_CONT''
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		08-02-2017 19:56:10
	***********************************/

	elsif(p_transaccion=''SP_DEFPROY_CONT'')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:=''select count(id_def_proyecto)
					    from sp.tdef_proyecto defproy
					    inner join segu.tusuario usu1 on usu1.id_usuario = defproy.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = defproy.id_usuario_mod
						inner join sp.vcsa_proyecto_pedido vcpp on vcpp.id_proyecto=defproy.id_proyecto

					    where '';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	else

		raise exception ''Transaccion inexistente'';

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