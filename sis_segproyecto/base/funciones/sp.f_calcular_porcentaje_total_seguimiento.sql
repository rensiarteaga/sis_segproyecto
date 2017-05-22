DROP FUNCTION if EXISTS sp.f_calcular_porcentaje_total_seguimiento(integer,integer);
CREATE OR REPLACE FUNCTION sp.f_calcular_porcentaje_total_seguimiento(v_id_def_proyecto INTEGER,v_id_def_proyecto_seguimiento INTEGER)
  RETURNS NUMERIC AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.f_calcular_porcentaje_total_seguimiento
 DESCRIPCION:   Funcion que calcula el procentaje total de los datos registrados del seguimiento de actividades
 AUTOR: 		 YAC
 FECHA:	        10-04-2017 17:56:10
 COMENTARIOS: para realizar el calculo del porcentaje total se debe de tener el id_def_proyecto y el id_def_proyecto_seguimiento
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE
  r                        RECORD;
  resultado NUMERIC := 0;
  v_nombre_funcion         TEXT;
  v_resp                   VARCHAR;
BEGIN

  v_nombre_funcion := 'sp.f_calcular_porcentaje_total_seguimiento';
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
  );
  INSERT INTO temp_actividad_datos (SELECT *
                                    FROM
                                        sp.f_obtener_arbol_actividades_seguimiento(v_id_def_proyecto));


  FOR r IN ( WITH RECURSIVE tt_actividades_seguimiento_actividad AS (
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
        WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 1 AND (tapa.id_tipo = 4 OR tapa.id_tipo = 1 or tapa.id_tipo=2)
          THEN
            tpsa.porcentaje_avance :: NUMERIC
        END AS porcentaje_avance,

        tad.cantidad,
        interno,
        CASE WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 2
          THEN
            coalesce(tpsa.porcentaje_avance, 0) :: NUMERIC * tad.interno :: NUMERIC
        WHEN tapa.id_actividad_padre IS NOT NULL AND tad.nivel > 1 AND (tad.id_tipo = 4 OR tad.id_tipo = 1 OR tad.id_tipo = 2 OR tad.id_tipo = 3) --AGREGANDO EL ID DE CONSTRUCCION (TEMP)
          THEN
            coalesce(tpsa.porcentaje_avance, 0) :: NUMERIC * tad.interno :: NUMERIC

        ELSE
          0:: NUMERIC--tad.interno :: NUMERIC
        END AS avance
      FROM temp_arb_proyectos_actividades tapa
        LEFT JOIN ((SELECT
                      id_def_proyecto_seguimiento,
                      id_def_proyecto_actividad,
                      porcentaje_avance
                    FROM sp.tdef_proyecto_seguimiento_actividad where id_def_proyecto_seguimiento=v_id_def_proyecto_seguimiento)
                   UNION ALL (SELECT v_id_def_proyecto_seguimiento,id_def_proyecto_actividad,sp.f_calcular_porcentaje_suministro(s.invitacion, s.adjudicacion, s.documento_emarque,
                                                                                                      s.llegada_sitio) AS porcentaje_avance
                              FROM sp.tsuministro s)) tpsa ON tapa.id_def_proyecto_actividad = tpsa.id_def_proyecto_actividad
        JOIN temp_actividad_datos tad ON tapa.id_def_proyecto_actividad = tad.id_def_proyecto_actividad
        LEFT JOIN sp.tsuministro ts ON ts.id_def_proyecto_actividad = tad.id_def_proyecto_actividad

      WHERE tpsa.id_def_proyecto_seguimiento = v_id_def_proyecto_seguimiento
    --ORDER BY tapa.id_tipo, ancestors
  )
  SELECT
    t1.id_actividad,
    t1.id_actividad_padre,
    t1.actividad,
    t1.nivel,
    round(t1.avance, 2)                   AS avance,
    t1.ancestors,
    CASE WHEN t1.nivel = 3 THEN
      round(coalesce(t1.avance,0),2)
    ELSE
      round(sum(coalesce(t2.avance, 0)+
                CASE WHEN t1.nivel=2 AND t1.id_tipo<>3 THEN t1.avance ELSE 0 END ), 2) end AS total_avance
  FROM tt_actividades_seguimiento_actividad t1
    left JOIN tt_actividades_seguimiento_actividad t2
      ON t2.id_actividad <> t1.id_actividad AND t1.id_actividad = t2.id_actividad_padre
  where t1.nivel<=1 and t1.id_tipo<>2 --nocontando al suminsitro = 2
  GROUP BY t1.id_tipo,
    t1.id_actividad,
    t1.id_actividad_padre,
    t1.actividad,
    t1.avance,
    t1.ancestors,t1.nivel )
    LOOP
    resultado := resultado + r.total_avance;
  END LOOP;

  RETURN round(resultado,2);


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

