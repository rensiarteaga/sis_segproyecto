CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_seguimiento_sel(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto_seguimiento'
 AUTOR: 		 (admin)
 FECHA:	        24-02-2017 04:16:20
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

  v_consulta       VARCHAR;
  v_parametros     RECORD;
  v_nombre_funcion TEXT;
  v_resp           VARCHAR;

BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_SEPR_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		24-02-2017 04:16:20
  ***********************************/

  IF (p_transaccion = 'SP_SEPR_SEL')
  THEN

    BEGIN
      --Sentencia de la consulta
      v_consulta:='select
						sepr.id_def_proyecto_seguimiento,
						sepr.id_def_proyecto,
						sepr.estado_reg,
						sepr.porcentaje,
						sepr.fecha,
						sepr.descripcion,
						sepr.id_usuario_reg,
						sepr.usuario_ai,
						sepr.fecha_reg,
						sepr.id_usuario_ai,
						sepr.id_usuario_mod,
						sepr.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from sp.tdef_proyecto_seguimiento sepr
						inner join segu.tusuario usu1 on usu1.id_usuario = sepr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sepr.id_usuario_mod
				        where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=
      v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion || ' limit ' ||
      v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      RETURN v_consulta;

    END;

    /*********************************
     #TRANSACCION:  'SP_SEPR_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		24-02-2017 04:16:20
    ***********************************/

  ELSIF (p_transaccion = 'SP_SEPR_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(id_def_proyecto_seguimiento)
					    from sp.tdef_proyecto_seguimiento sepr
					    inner join segu.tusuario usu1 on usu1.id_usuario = sepr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sepr.id_usuario_mod
					    where ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;

        --Devuelve la respuesta
        RETURN v_consulta;

      END;

  ELSE

    RAISE EXCEPTION 'Transaccion inexistente';

  END IF;

  EXCEPTION

  WHEN OTHERS
    THEN
      v_resp = '';
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
      v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
      v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);
      RAISE EXCEPTION '%', v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;