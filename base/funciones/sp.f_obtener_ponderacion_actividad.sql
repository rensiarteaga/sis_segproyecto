--DROP FUNCTION sp.f_obtener_ponderacion_actividad_padre(integer,integer);
DROP FUNCTION sp.f_obtener_ponderacion_actividad( INTEGER );
CREATE OR REPLACE FUNCTION sp.f_obtener_ponderacion_actividad(IN  v_id_def_proyecto INTEGER, OUT v_id_actividad INTEGER,
                                                              OUT v_actividad       VARCHAR, OUT v_suma NUMERIC,
                                                              OUT v_fechaordenmin   DATE, OUT v_fechaentregamax DATE,
                                                              OUT v_duracion        INTEGER,
                                                              OUT v_multiplicacion  NUMERIC, OUT v_ponderacion NUMERIC,
                                                              OUT v_porcentaje      NUMERIC, OUT v_nivel INTEGER,
                                                              OUT v_id_tipo         INTEGER)
  RETURNS SETOF RECORD AS
$$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos OFICIAL
 FUNCION: 		sp.f_obtener_ponderacion_actividad
 DESCRIPCION:   Funcion que calcula los datos resumen de los padres de acuerdo al id de def_proyecto
 AUTOR: 		 YAC
 FECHA:	        23-03-2017 08:56:10
 COMENTARIOS: esta funcion se la consulta tipo tabla ejm select * from sp.ft_def_proyecto_sel(2)
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/
DECLARE
  r                        RECORD;
  r1                       RECORD;
  fila                     INTEGER;
  v_suma_multiplicando_aux NUMERIC := 0;
  v_suma_monto_aux         NUMERIC := 0;
  v_ponderado              NUMERIC := 0;
  v_nombre_funcion         TEXT;
  v_resp                   VARCHAR;
BEGIN

  v_nombre_funcion = 'sp.f_obtener_ponderacion_actividad';
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
                                              FROM sp.f_obtener_arbol_actividades(v_id_def_proyecto) ORDER BY v_ancestors);


  FOR r IN (
    SELECT
      t1.id_actividad,
      t1.id_actividad_padre,
      t1.actividad,
      (COALESCE(t1.monto, 0) + SUM(COALESCE(t2.monto, 0))) AS suma,

      CASE WHEN MAX(t2.fecha_entrega_contrato_prev) > t1.fecha_entrega_contrato_prev
        THEN t1.fecha_entrega_contrato_prev
      ELSE MAX(t2.fecha_entrega_contrato_prev) END         AS fechamax,
      CASE WHEN MIN(t2.fechaordenproceder) > t1.fechaordenproceder
        THEN t1.fechaordenproceder
      ELSE MIN(t2.fechaordenproceder) END                  AS fechamin,

      (CASE WHEN MAX(t2.fecha_entrega_contrato_prev) > t1.fecha_entrega_contrato_prev
        THEN t1.fecha_entrega_contrato_prev
       ELSE MAX(t2.fecha_entrega_contrato_prev) END -
       CASE WHEN MIN(t2.fechaordenproceder) > t1.fechaordenproceder
         THEN t1.fechaordenproceder
       ELSE MIN(t2.fechaordenproceder) END)                AS duracion,

      ((COALESCE(t1.monto, 0) + SUM(COALESCE(t2.monto, 0))) *
       (CASE WHEN MAX(t2.fecha_entrega_contrato_prev) > t1.fecha_entrega_contrato_prev
         THEN t1.fecha_entrega_contrato_prev
        ELSE MAX(t2.fecha_entrega_contrato_prev) END -
        CASE WHEN MIN(t2.fechaordenproceder) > t1.fechaordenproceder
          THEN t1.fechaordenproceder
        ELSE MIN(t2.fechaordenproceder) END))              AS multiplicacion
    FROM temp_arb_proyectos_actividades t1
      JOIN temp_arb_proyectos_actividades t2
        on t1.id_actividad = t2.id_actividad_padre
    WHERE t1.id_actividad_padre IS NULL
    GROUP BY t1.id_actividad, t1.id_actividad_padre, t1.actividad, t1.monto, t1.fechaordenproceder,
      t1.fecha_entrega_contrato_prev)

  LOOP
    fila :=fila + 1;
    IF ((r.multiplicacion) > 0)
    THEN
      v_suma_multiplicando_aux := (v_suma_multiplicando_aux + r.multiplicacion);
      v_suma_monto_aux := (v_suma_monto_aux + r.suma);

    END IF;
  END LOOP;

  FOR r1 IN (
    SELECT
      t1.nivel,
      t1.id_actividad,
      t1.id_actividad_padre,
      t1.actividad,
      (COALESCE(t1.monto, 0) + SUM(COALESCE(t2.monto, 0))) AS suma,

      CASE WHEN MAX(t2.fecha_entrega_contrato_prev) > t1.fecha_entrega_contrato_prev
        THEN t1.fecha_entrega_contrato_prev
      ELSE MAX(t2.fecha_entrega_contrato_prev) END         AS fechamax,
      CASE WHEN MIN(t2.fechaordenproceder) > t1.fechaordenproceder
        THEN t1.fechaordenproceder
      ELSE MIN(t2.fechaordenproceder) END                  AS fechamin,

      (CASE WHEN MAX(t2.fecha_entrega_contrato_prev) > t1.fecha_entrega_contrato_prev
        THEN t1.fecha_entrega_contrato_prev
       ELSE MAX(t2.fecha_entrega_contrato_prev) END -
       CASE WHEN MIN(t2.fechaordenproceder) > t1.fechaordenproceder
         THEN t1.fechaordenproceder
       ELSE MIN(t2.fechaordenproceder) END)                AS duracion,

      ((COALESCE(t1.monto, 0) + SUM(COALESCE(t2.monto, 0))) *
       (CASE WHEN MAX(t2.fecha_entrega_contrato_prev) > t1.fecha_entrega_contrato_prev
         THEN t1.fecha_entrega_contrato_prev
        ELSE MAX(t2.fecha_entrega_contrato_prev) END -
        CASE WHEN MIN(t2.fechaordenproceder) > t1.fechaordenproceder
          THEN t1.fechaordenproceder
        ELSE MIN(t2.fechaordenproceder) END))              AS multiplicacion,
      t1.id_tipo
    FROM temp_arb_proyectos_actividades t1
      JOIN temp_arb_proyectos_actividades t2
        on t1.id_actividad = t2.id_actividad_padre
    WHERE t1.id_actividad_padre IS NULL
    GROUP BY t1.id_actividad, t1.id_actividad_padre, t1.actividad, t1.monto, t1.fechaordenproceder,
      t1.fecha_entrega_contrato_prev, t1.nivel, t1.id_tipo)

  LOOP
    v_id_actividad = r1.id_actividad;
    v_multiplicacion = r1.multiplicacion;
    v_fechaordenmin = r1.fechamin;
    v_fechaentregamax = r1.fechamax;
    v_multiplicacion = r1.multiplicacion;
    v_duracion = r1.duracion;

    IF r1.id_tipo = 3
    THEN
      v_ponderacion = (r1.multiplicacion / v_suma_multiplicando_aux) - 0.02;
      v_porcentaje = ((r1.multiplicacion / v_suma_multiplicando_aux) - 0.02) * 100;
      --preguntaremos si es cierre y le daremos 2 de puntaje
    ELSEIF r1.id_tipo = 4
      THEN
        v_ponderacion = 0.02;
        v_porcentaje = 0.02 * 100;
    ELSE
      v_ponderacion = (r1.multiplicacion / v_suma_multiplicando_aux);
      v_porcentaje = ((r1.multiplicacion / v_suma_multiplicando_aux)) * 100;
    END IF;
    --preguntaremos si es contruccion y le descontaremos 2 del cierre
    v_suma = r1.suma;
    v_actividad = r1.actividad;
    v_nivel = r1.nivel :: INTEGER;
    v_id_tipo = r1.id_tipo :: INTEGER;
    RETURN NEXT;
  END LOOP;

  -- return suma_multiplicando_aux;

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