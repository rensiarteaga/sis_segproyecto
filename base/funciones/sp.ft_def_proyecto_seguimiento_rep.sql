--------------- SQL ---------------
CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_seguimiento_rep(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS SETOF RECORD AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_rep
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto_seguimiento'
 en formato de reporte
 AUTOR: 		 (yac)
 FECHA:	        02-04-2017 8:56:10
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
  --v_registro       RECORD;


BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_rep';
  v_parametros = pxp.f_get_record(p_tabla);
  /*********************************
 #TRANSACCION:  'SP_DEFPROSEGREP_SEL'
 #DESCRIPCION:	Consulta que devuelve los datos resumen para el tabla de ponderacion del seguimiento
 #AUTOR:		yac
 #FECHA:		02-04-2017 08:56:10
***********************************/

  IF (p_transaccion = 'SP_DEFPROSEGREP_SEL')
  THEN

    BEGIN
      DROP TABLE IF EXISTS temp_actividad_datos;
      CREATE TEMPORARY TABLE temp_actividad_datos (
        id_actividad              INTEGER,
        id_actividad_padre        INTEGER,
        actividad                 VARCHAR(100),
        nivel                     INTEGER,
        cantidad                  INTEGER,
        interno                   NUMERIC,
        id_def_proyecto_actividad INTEGER,
        id_tipo                   INTEGER
      ) on COMMIT DROP;
      INSERT INTO temp_actividad_datos (SELECT *
                                        FROM
                                            sp.f_obtener_arbol_actividades_seguimiento(v_parametros.id_def_proyecto));

      RETURN QUERY WITH RECURSIVE tt_actividades_seguimiento_actividad AS (
          SELECT
            tapa.id_actividad,
            tapa.id_actividad_padre,
            tapa.actividad,
            tapa.ancestors,
            tapa.nivel,
            tapa.id_tipo,
            CASE WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 2
              THEN
                tpsa.porcentaje_avance :: NUMERIC
            WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 1 AND
                 (tapa.id_tipo = 4 OR tapa.id_tipo = 1 OR tapa.id_tipo = 2 )
              THEN
                tpsa.porcentaje_avance :: NUMERIC
            END AS porcentaje_avance,

            tad.cantidad,
            interno,
            CASE WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 2
              THEN
                coalesce(tpsa.porcentaje_avance, 0) :: NUMERIC * tad.interno :: NUMERIC
            WHEN tapa.id_actividad_padre IS NOT NULL AND tad.nivel > 1  AND
                 (tad.id_tipo = 4 OR tad.id_tipo = 1 OR tad.id_tipo = 2  OR tad.id_tipo = 3 ) --agregando al tipo construccion
              THEN
                coalesce(tpsa.porcentaje_avance, 0) :: NUMERIC * tad.interno :: NUMERIC

            ELSE
              0 :: NUMERIC --tad.interno :: NUMERIC
            END AS avance
          FROM temp_arb_proyectos_actividades tapa
            LEFT JOIN ((SELECT
                          id_def_proyecto_seguimiento,
                          id_def_proyecto_actividad,
                          porcentaje_avance
                        FROM sp.tdef_proyecto_seguimiento_actividad
                        WHERE id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento)
                       UNION ALL (SELECT
                                    v_parametros.id_def_proyecto_seguimiento,
                                    id_def_proyecto_actividad,
                                    sp.f_calcular_porcentaje_suministro(s.invitacion, s.adjudicacion,
                                                                        s.documento_emarque,
                                                                        s.llegada_sitio) AS porcentaje_avance
                                  FROM sp.tsuministro s)) tpsa
              ON tapa.id_def_proyecto_actividad = tpsa.id_def_proyecto_actividad
            JOIN temp_actividad_datos tad ON tapa.id_def_proyecto_actividad = tad.id_def_proyecto_actividad
            LEFT JOIN sp.tsuministro ts ON ts.id_def_proyecto_actividad = tad.id_def_proyecto_actividad

          WHERE tpsa.id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento
        --ORDER BY tapa.id_tipo, ancestors
      )
      SELECT
        t1.id_actividad,
        t1.id_actividad_padre,
        t1.actividad,
        t1.nivel,
        round(t1.avance, 2)::NUMERIC                   AS avance,
        t1.ancestors::VARCHAR,
        CASE WHEN t1.nivel = 3
          THEN
            round(coalesce(t1.avance, 0), 2)
        ELSE
          round(sum(coalesce(t2.avance, 0) + CASE WHEN t1.nivel=2 AND t1.id_tipo<>3 THEN t1.avance ELSE 0 END ), 2) END AS total_avance
      FROM tt_actividades_seguimiento_actividad t1
        LEFT JOIN tt_actividades_seguimiento_actividad t2
          ON t2.id_actividad <> t1.id_actividad AND t1.id_actividad = t2.id_actividad_padre
      WHERE t1.nivel <= 2
      GROUP BY t1.id_tipo,
        t1.id_actividad,
        t1.id_actividad_padre,
        t1.actividad,
        t1.avance,
        t1.ancestors, t1.nivel
      ORDER BY t1.id_tipo, t1.ancestors;

      --RAISE NOTICE '%', v_registro;
      --Devuelve la respuesta
      RETURN;

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