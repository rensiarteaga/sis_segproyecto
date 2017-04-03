CREATE OR REPLACE FUNCTION sp.f_obtener_ponderacion(IN  v_id_def_proyecto INTEGER, OUT id_def_proyecto INTEGER,
                                                      OUT actividad         VARCHAR, OUT id_actividad INTEGER,
                                                      OUT multiplicando     NUMERIC, OUT ponderado NUMERIC,
                                                      OUT plazo             INTEGER, OUT monto NUMERIC)
  RETURNS SETOF RECORD AS
$$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_obtener_ponderacion
 DESCRIPCION:   Funcion que calcula los datos resumen de los padres de acuerdo al id de def_proyecto
 AUTOR: 		 YAC
 FECHA:	        21-03-2017 19:56:10
 COMENTARIOS: esta funcion se la consulta tipo tabla ejm select * from sp.ft_def_proyecto_sel(2)
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/
DECLARE
  r                      RECORD;
  r1                     RECORD;
  fila                   INTEGER;
  suma_multiplicando_aux NUMERIC := 0;
BEGIN
  FOR r IN SELECT
             deprac.id_def_proyecto_actividad,
             deprac.id_actividad,
             tact.id_actividad_padre,
             deprac.id_def_proyecto,
             CASE WHEN (tact.id_actividad_padre IS NULL)
               THEN
                 (SELECT (date(max(vcpp.fecha_entrega_contrato_prev)) -
                          DATE(min(vcpp.fechaordenproceder))) :: INTEGER
                  FROM ((SELECT DISTINCT tdpap.id_pedido
                         FROM sp.tdef_proyecto_actividad tdpa
                           JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                    ta.id_actividad_padre = deprac.id_actividad
                           JOIN sp.tdef_proyecto_actividad_pedido tdpap
                             ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                         WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)
                        UNION ALL (SELECT DISTINCT tdpap.id_pedido
                                   FROM sp.tdef_proyecto_actividad tdpa
                                     JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                              ta.id_actividad = deprac.id_actividad
                                     JOIN sp.tdef_proyecto_actividad_pedido tdpap
                                       ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                                   WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)) ped
                    JOIN sp.vcsa_proyecto_pedido vcpp ON ped.id_pedido = vcpp.id_pedido)
             END AS plazo,
             CASE WHEN (tact.id_actividad_padre IS NULL)
               THEN
                 (SELECT sum(vcpp.monto_total)
                  FROM ((SELECT DISTINCT tdpap.id_pedido
                         FROM sp.tdef_proyecto_actividad tdpa
                           JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                    ta.id_actividad_padre = deprac.id_actividad
                           JOIN sp.tdef_proyecto_actividad_pedido tdpap
                             ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                         WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)
                        UNION ALL (SELECT DISTINCT tdpap.id_pedido
                                   FROM sp.tdef_proyecto_actividad tdpa
                                     JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                              ta.id_actividad = deprac.id_actividad
                                     JOIN sp.tdef_proyecto_actividad_pedido tdpap
                                       ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                                   WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)) ped
                    JOIN sp.vcsa_proyecto_pedido vcpp ON ped.id_pedido = vcpp.id_pedido)
             END AS monto_suma
           FROM sp.tdef_proyecto_actividad deprac
             INNER JOIN segu.tusuario usu1 ON usu1.id_usuario = deprac.id_usuario_reg
             LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = deprac.id_usuario_mod
             JOIN sp.tactividad tact
               ON tact.id_actividad = deprac.id_actividad AND tact.id_actividad_padre IS NULL
             LEFT JOIN sp.tdef_proyecto_actividad_pedido dpap
               ON deprac.id_def_proyecto_actividad = dpap.id_def_proyecto_actividad
             LEFT JOIN sp.vcsa_proyecto_pedido vpp ON vpp.id_pedido = dpap.id_pedido
           WHERE deprac.id_def_proyecto = v_id_def_proyecto
           GROUP BY deprac.id_actividad, tact.id_actividad_padre, deprac.id_def_proyecto,
             deprac.id_def_proyecto_actividad
  LOOP
    fila :=fila + 1;
    IF ((r.monto_suma * r.plazo) > 0)
    THEN
      suma_multiplicando_aux := (suma_multiplicando_aux + (r.monto_suma * r.plazo));
    END IF;
  END LOOP;
  RAISE NOTICE '%', suma_multiplicando_aux;
  FOR r1 IN SELECT
              deprac.id_def_proyecto_actividad,
              deprac.id_actividad,
              tact.id_actividad_padre,
              tact.actividad,
              deprac.id_def_proyecto,
              CASE WHEN (tact.id_actividad_padre IS NULL)
                THEN
                  (SELECT (date(max(vcpp.fecha_entrega_contrato_prev)) -
                           DATE(min(vcpp.fechaordenproceder))) :: INTEGER
                   FROM ((SELECT DISTINCT tdpap.id_pedido
                          FROM sp.tdef_proyecto_actividad tdpa
                            JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                     ta.id_actividad_padre = deprac.id_actividad
                            JOIN sp.tdef_proyecto_actividad_pedido tdpap
                              ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                          WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)
                         UNION ALL (SELECT DISTINCT tdpap.id_pedido
                                    FROM sp.tdef_proyecto_actividad tdpa
                                      JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                               ta.id_actividad = deprac.id_actividad
                                      JOIN sp.tdef_proyecto_actividad_pedido tdpap
                                        ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                                    WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)) ped
                     JOIN sp.vcsa_proyecto_pedido vcpp ON ped.id_pedido = vcpp.id_pedido)
              END AS plazo,
              CASE WHEN (tact.id_actividad_padre IS NULL)
                THEN
                  (SELECT sum(vcpp.monto_total)
                   FROM ((SELECT DISTINCT tdpap.id_pedido
                          FROM sp.tdef_proyecto_actividad tdpa
                            JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                     ta.id_actividad_padre = deprac.id_actividad
                            JOIN sp.tdef_proyecto_actividad_pedido tdpap
                              ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                          WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)
                         UNION ALL (SELECT DISTINCT tdpap.id_pedido
                                    FROM sp.tdef_proyecto_actividad tdpa
                                      JOIN sp.tactividad ta ON tdpa.id_actividad = ta.id_actividad AND
                                                               ta.id_actividad = deprac.id_actividad
                                      JOIN sp.tdef_proyecto_actividad_pedido tdpap
                                        ON tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
                                    WHERE tdpa.id_def_proyecto = deprac.id_def_proyecto)) ped
                     JOIN sp.vcsa_proyecto_pedido vcpp ON ped.id_pedido = vcpp.id_pedido)
              END AS monto_suma
            FROM sp.tdef_proyecto_actividad deprac
              INNER JOIN segu.tusuario usu1 ON usu1.id_usuario = deprac.id_usuario_reg
              LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = deprac.id_usuario_mod
              JOIN sp.tactividad tact
                ON tact.id_actividad = deprac.id_actividad AND tact.id_actividad_padre IS NULL
              LEFT JOIN sp.tdef_proyecto_actividad_pedido dpap
                ON deprac.id_def_proyecto_actividad = dpap.id_def_proyecto_actividad
              LEFT JOIN sp.vcsa_proyecto_pedido vpp ON vpp.id_pedido = dpap.id_pedido
            WHERE deprac.id_def_proyecto = v_id_def_proyecto
            GROUP BY deprac.id_actividad, tact.id_actividad_padre, tact.actividad, deprac.id_def_proyecto,
              deprac.id_def_proyecto_actividad
            ORDER BY id_actividad
  LOOP

    id_actividad = r1.id_actividad;
    multiplicando = (r1.monto_suma * r1.plazo);
    plazo = r1.plazo;
    monto = r1.monto_suma;
    actividad = r1.actividad;
    id_def_proyecto = r1.id_def_proyecto;

    ponderado = ((r1.monto_suma * r1.plazo) / suma_multiplicando_aux);

    RETURN NEXT;
  END LOOP;
END;
$$
LANGUAGE 'plpgsql';

SELECT * from sp.ft_obtener_ponderacion(3);
