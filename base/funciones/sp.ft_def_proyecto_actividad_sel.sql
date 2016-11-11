--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_actividad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS''
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla ''''sp.tdef_proyecto_actividad''''
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = ''''sp.ft_def_proyecto_actividad_sel'''';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  ''''SP_DEPRAC_SEL''''
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		10-11-2016 06:41:48
	***********************************/

	if(p_transaccion=''''SP_DEPRAC_SEL'''')then

    	begin
    		--Sentencia de la consulta
			v_consulta:=''''select
						deprac.id_def_proyecto_actividad,
						deprac.id_def_proyecto,
						deprac.id_actividad,
						deprac.estado_reg,
						deprac.descripcion,
						deprac.usuario_ai,
						deprac.fecha_reg,
						deprac.id_usuario_reg,
						deprac.id_usuario_ai,
						deprac.fecha_mod,
						deprac.id_usuario_mod,
						tact.actividad,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from sp.tdef_proyecto_actividad deprac
						inner join segu.tusuario usu1 on usu1.id_usuario = deprac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = deprac.id_usuario_mod
		        		join sp.tactividad tact on tact.id_actividad = deprac.id_actividad
				        where  '''';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||'''' order by '''' ||v_parametros.ordenacion|| '''' '''' || v_parametros.dir_ordenacion || '''' limit '''' || v_parametros.cantidad || '''' offset '''' || v_parametros.puntero;

raise NOTICE ''''%'''',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  ''''SP_DEPRAC_CONT''''
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		10-11-2016 06:41:48
	***********************************/

	elsif(p_transaccion=''''SP_DEPRAC_CONT'''')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:=''''select count(id_def_proyecto_actividad)
					    from sp.tdef_proyecto_actividad deprac
					    inner join segu.tusuario usu1 on usu1.id_usuario = deprac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = deprac.id_usuario_mod
  	        join sp.tactividad tact on tact.id_actividad = deprac.id_actividad
            where '''';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	else

		raise exception ''''Transaccion inexistente'''';

	end if;

EXCEPTION

	WHEN OTHERS THEN
			v_resp='''''''';
			v_resp = pxp.f_agrega_clave(v_resp,''''mensaje'''',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,''''codigo_error'''',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,''''procedimientos'''',v_nombre_funcion);
			raise exception ''''%'''',v_resp;
END;
''LANGUAGE ''plpgsql''
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;