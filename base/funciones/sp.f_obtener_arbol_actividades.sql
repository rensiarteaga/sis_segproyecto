--DROP FUNCTION sp.f_obtener_ponderacion_actividad_padre(integer,integer);
DROP FUNCTION IF EXISTS sp.f_obtener_arbol_actividades( INTEGER );
CREATE OR REPLACE FUNCTION sp.f_obtener_arbol_actividades(IN  v_id_def_proyecto             INTEGER,
                                                          OUT v_id_actividad                INTEGER,
                                                          OUT v_id_actividad_padre          INTEGER,
                                                          OUT v_actividad                   VARCHAR,
                                                          OUT v_monto                       NUMERIC,
                                                          OUT v_fechaordenproceder          DATE,
                                                          OUT v_fecha_entrega_contrato_prev DATE,
                                                          OUT v_ancestors                   VARCHAR,
                                                          OUT v_nivel                       INTEGER,
                                                          OUT v_id_def_proyecto_actividad   INTEGER,
                                                          OUT v_id_tipo                     INTEGER)
  RETURNS SETOF RECORD AS
$$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.f_obtener_arbol_actividades
 DESCRIPCION:   Funcion que dibuja el arbol de actividades padre,hijo,nieto
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
  r                        RECORD;
  fila                     INTEGER;
  v_suma_multiplicando_aux NUMERIC := 0;
  v_suma_monto_aux         NUMERIC := 0;
  v_ponderado              NUMERIC := 0;
  v_nombre_funcion         TEXT;
  v_resp                   VARCHAR;

BEGIN
  v_nombre_funcion := 'sp.f_obtener_arbol_actividades';
  FOR r IN (WITH RECURSIVE tt_actividad_pedido AS (
      SELECT
        a.id_actividad,
        a.id_actividad_padre,
        a.actividad,
        SUM(pap.monto)                             AS monto,
        MIN(date(vpp.fechaordenproceder))          AS fechaordenproceder,
        MAX(DATE(vpp.fecha_entrega_contrato_prev)) AS fecha_entrega_contrato_prev,
        pa.id_def_proyecto_actividad,
        a.id_tipo
      FROM sp.tdef_proyecto_actividad pa
        JOIN sp.tactividad a ON a.id_actividad = pa.id_actividad
        LEFT JOIN sp.tdef_proyecto_actividad_pedido pap ON pap.id_def_proyecto_actividad = pa.id_def_proyecto_actividad
        LEFT JOIN sp.vcsa_proyecto_pedido vpp ON vpp.id_pedido = pap.id_pedido
      WHERE pa.id_def_proyecto = v_id_def_proyecto
      GROUP BY a.id_actividad, a.id_actividad_padre, a.actividad, pa.id_def_proyecto_actividad, a.id_tipo
  )
    , tree AS (
      SELECT
        id_actividad,
        id_actividad_padre,
        actividad,
        monto,
        fechaordenproceder,
        fecha_entrega_contrato_prev,
        id_actividad :: TEXT AS ancestors,
        1                    AS nivel,
        id_def_proyecto_actividad,
        id_tipo
      FROM tt_actividad_pedido
      WHERE id_actividad_padre IS NULL
      UNION ALL
      SELECT
        ta.id_actividad,
        ta.id_actividad_padre,
        ta.actividad,
        ta.monto,
        ta.fechaordenproceder,
        ta.fecha_entrega_contrato_prev,
        (tree.ancestors || '->' || ta.id_actividad :: TEXT) AS ancestors,
        tree.nivel + 1                                      AS nivel,
        ta.id_def_proyecto_actividad,
        ta.id_tipo
      FROM tt_actividad_pedido ta,
        tree
      WHERE ta.id_actividad_padre = tree.id_actividad
    ) SELECT *
      FROM tree t1)
  LOOP
    v_id_actividad = r.id_actividad;
    v_id_actividad_padre = r.id_actividad_padre;
    v_actividad = r.actividad;
    v_monto = r.monto;
    v_fechaordenproceder = r.fechaordenproceder;
    v_fecha_entrega_contrato_prev = r.fecha_entrega_contrato_prev;
    v_ancestors = r.ancestors;
    v_nivel = r.nivel;
    v_id_def_proyecto_actividad = r.id_def_proyecto_actividad;
    v_id_tipo = r.id_tipo;

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