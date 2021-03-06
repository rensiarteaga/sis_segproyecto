--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_suministro_sel(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_suministro_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tsuministro'
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

  v_consulta       VARCHAR;
  v_parametros     RECORD;
  v_nombre_funcion TEXT;
  v_resp           VARCHAR;

BEGIN

  v_nombre_funcion = 'sp.ft_suministro_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_SUM_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		12-11-2016 14:03:32
  ***********************************/

  IF (p_transaccion = 'SP_SUM_SEL')
  THEN

    BEGIN
      --Sentencia de la consulta
      v_consulta:=' select
            CASE WHEN s.id_seguimiento_suministro ISNULL THEN 0::INTEGER ELSE s.id_seguimiento_suministro END as id_seguimiento_suministro,
            CASE WHEN s.id_seguimiento_suministro ISNULL THEN false ELSE true END as tipo_guardar,
            s.id_def_proyecto_seguimiento,
            pa.id_def_proyecto_actividad,
            a.actividad,
            CASE WHEN s.documento_emarque ISNULL THEN 0::bit ELSE s.documento_emarque::bit END as documento_emarque,
            CASE WHEN s.invitacion ISNULL THEN 0::bit ELSE s.invitacion::bit END as invitacion,
            CASE WHEN s.adjudicacion ISNULL THEN 0::bit ELSE s.adjudicacion::bit END as adjudicacion,
            CASE WHEN s.llegada_sitio ISNULL THEN 0::bit ELSE s.llegada_sitio::bit END as llegada_sitio,
            CASE WHEN tact.id_actividad_padre ISNULL THEN TRUE::bool ELSE FALSE::bool END as padre
          FROM sp.tdef_proyecto_actividad pa
            JOIN sp.tactividad tact ON tact.id_actividad = pa.id_actividad and tact.id_actividad_padre is not null
            JOIN sp.tsuministro s
              ON s.id_def_proyecto_actividad = pa.id_def_proyecto_actividad and s.id_def_proyecto_seguimiento = ' ||
                  v_parametros.id_def_proyecto_seguimiento || '
            JOIN sp.tactividad a ON a.id_actividad = pa.id_actividad AND a.id_tipo = 2

           where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=
      v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion ||
      ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      RAISE NOTICE '%', v_consulta;
      --RAISE EXCEPTION 'error yac';
      RETURN v_consulta;

    END;

    /*********************************
     #TRANSACCION:  'SP_SUM_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		12-11-2016 14:03:32
    ***********************************/

  ELSIF (p_transaccion = 'SP_SUM_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(a.actividad)
         FROM sp.tdef_proyecto_actividad pa
            JOIN sp.tactividad tact ON tact.id_actividad = pa.id_actividad
            JOIN sp.tsuministro s
              ON s.id_def_proyecto_actividad = pa.id_def_proyecto_actividad and s.id_def_proyecto_seguimiento = 138
            JOIN sp.tactividad a ON a.id_actividad = pa.id_actividad AND a.id_tipo = 2
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