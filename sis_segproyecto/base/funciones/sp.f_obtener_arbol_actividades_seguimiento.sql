--DROP FUNCTION sp.f_obtener_ponderacion_actividad_padre(integer,integer);
DROP FUNCTION IF EXISTS sp.f_obtener_arbol_actividades_seguimiento( INTEGER );
CREATE OR REPLACE FUNCTION sp.f_obtener_arbol_actividades_seguimiento(IN  v_id_def_proyecto           INTEGER,
                                                                      OUT v_id_actividad              INTEGER,
                                                                      OUT v_id_actividad_padre        INTEGER,
                                                                      OUT v_actividad                 VARCHAR,
                                                                      OUT v_nivel                     INTEGER,
                                                                      OUT v_cantidad                  INTEGER,
                                                                      OUT v_interno                   NUMERIC,
                                                                      OUT v_id_def_proyecto_actividad NUMERIC,
                                                                      OUT v_id_tipo                   NUMERIC)
  RETURNS SETOF RECORD AS
$$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.f_obtener_arbol_actividades
 DESCRIPCION:   Funcion que calcula el arbol de actividades
 AUTOR: 		 YAC
 FECHA:	        23-03-2017 08:56:10
 COMENTARIOS: esta funcion nos servira para dibujar el arbol
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/
DECLARE
  r                              RECORD;
  r1                             RECORD;
  v_porcentaje_actividad_padre_c NUMERIC;

  fila                           INTEGER;
  v_suma_multiplicando_aux       NUMERIC := 0;
  v_suma_monto_aux               NUMERIC := 0;
  v_ponderado                    NUMERIC := 0;
  v_nombre_funcion               TEXT;
  v_resp                         VARCHAR;
BEGIN

  -- calculando el pocentaje total
  v_nombre_funcion = 'sp.f_obtener_arbol_actividades_seguimiento';

  DROP TABLE IF EXISTS temp_tabla_ponderacion;

  CREATE TEMPORARY TABLE temp_tabla_ponderacion (
    id_actividad    INTEGER,
    actividad       VARCHAR,
    suma            NUMERIC,
    fechaordenmin   DATE,
    fechaentregamax DATE,
    duracion        INTEGER,
    multiplicacion  NUMERIC,
    ponderacion     NUMERIC,
    porcentaje      NUMERIC,
    nivel           INTEGER,
    id_tipo         INTEGER

  );

  INSERT INTO temp_tabla_ponderacion (SELECT *
                                      FROM sp.f_obtener_ponderacion_actividad(v_id_def_proyecto));
  --select * from temp_tabla_ponderacion;


  DROP TABLE IF EXISTS temp_arb_proyectos_actividades;

  CREATE TEMPORARY TABLE temp_arb_proyectos_actividades (
    id_actividad                INTEGER,
    id_actividad_padre          INTEGER,
    actividad                   VARCHAR(255),
    monto                       NUMERIC,
    fechaordenproceder          DATE,
    fecha_entrega_contrato_prev DATE,
    ancestors                   VARCHAR(255),
    nivel                       INTEGER,
    id_def_proyecto_actividad   INTEGER,
    id_tipo                     INTEGER

  );
  INSERT INTO temp_arb_proyectos_actividades (SELECT *
                                              FROM sp.f_obtener_arbol_actividades(
                                                  v_id_def_proyecto)); --v_id_def_proyecto));

  FOR r1 IN (SELECT
               act.id_actividad,
               act.id_actividad_padre,
               act.actividad,
               act.nivel,
               cant.cantidad,
               CASE WHEN act.nivel = 1
                 THEN ((SELECT porcentaje
                        FROM temp_tabla_ponderacion
                        WHERE id_actividad = act.id_actividad) :: NUMERIC)
               WHEN act.nivel = 2
                 THEN ((SELECT (porcentaje / (cant.cantidad :: NUMERIC))
                        FROM temp_tabla_ponderacion ttp
                        WHERE id_actividad = act.id_actividad_padre)) :: NUMERIC
               WHEN act.nivel = 3
                 THEN (v_porcentaje_actividad_padre_c / cant.cantidad :: NUMERIC) :: NUMERIC
               END AS interno,
               act.id_def_proyecto_actividad,
               act.id_tipo

             FROM (
                    (
                      SELECT
                        t1.id_actividad,
                        t1.id_actividad_padre,
                        t1.actividad,
                        COUNT(t2.*) AS cantidad,
                        t1.nivel,
                        t1.ancestors,
                        t1.id_def_proyecto_actividad,
                        t1.id_tipo
                      FROM temp_arb_proyectos_actividades t1
                        JOIN temp_arb_proyectos_actividades t2
                          ON t2.id_actividad <> t1.id_actividad AND
                             t1.id_actividad = t2.id_actividad_padre
                      WHERE t2.nivel <= 2
                      --AND t1.nivel>=2
                      GROUP BY t1.id_actividad, t1.id_actividad_padre, t1.actividad, t1.nivel, t1.ancestors,
                        t1.id_def_proyecto_actividad, t1.id_tipo
                      ORDER BY t1.id_tipo, t1.ancestors
                    )
                    UNION
                    (
                      SELECT
                        t1.id_actividad,
                        t1.id_actividad_padre,
                        t1.actividad,
                        COUNT(t2.*) AS cantidad,
                        t1.nivel,
                        t1.ancestors,
                        t1.id_def_proyecto_actividad,
                        t1.id_tipo
                      FROM temp_arb_proyectos_actividades t1
                        JOIN temp_arb_proyectos_actividades t2
                          ON t2.id_actividad <> t1.id_actividad AND
                             t1.id_actividad = t2.id_actividad_padre
                      WHERE t2.nivel <= 3
                            AND t1.nivel >= 2
                      GROUP BY t1.id_actividad, t1.id_actividad_padre, t1.actividad, t1.nivel, t1.ancestors,
                        t1.id_def_proyecto_actividad, t1.id_tipo
                      ORDER BY t1.id_tipo, t1.ancestors
                    )
                  ) cant
               RIGHT JOIN
               (
                 SELECT
                   t1.id_actividad,
                   t1.id_actividad_padre,
                   t1.actividad,
                   t1.nivel,
                   t1.id_def_proyecto_actividad,
                   t1.id_tipo
                 FROM temp_arb_proyectos_actividades t1
                 ORDER BY t1.id_tipo, t1.ancestors

               ) act ON act.id_actividad_padre = cant.id_actividad)
  LOOP
    v_id_actividad = r1.id_actividad;
    v_id_actividad_padre = r1.id_actividad_padre;
    v_actividad = r1.actividad;
    v_cantidad = r1.cantidad;
    v_id_def_proyecto_actividad = r1.id_def_proyecto_actividad;
    IF (r1.nivel = 2)
    THEN
      v_porcentaje_actividad_padre_c := (SELECT porcentaje / v_cantidad
                                         FROM temp_tabla_ponderacion
                                         WHERE id_actividad = r1.id_actividad_padre);
    END IF;
    v_nivel = r1.nivel;

    v_interno = round(r1.interno,2);
    IF (r1.nivel = 3)
    THEN
      v_interno = round((v_porcentaje_actividad_padre_c / v_cantidad),2);
    END IF;
    v_id_tipo = r1.id_tipo;

    RETURN NEXT;
  END LOOP;
  EXCEPTION

  WHEN OTHERS
    THEN
      v_resp = '';
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
      v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
      v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);
      RAISE EXCEPTION '%', v_resp;
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;


----creando la tabla del arbol de activbidades

--SELECT * FROM sp.f_obtener_arbol_actividades_seguimiento(40)
