  --------------- SQL ---------------
  CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_rep(
    p_administrador INTEGER,
    p_id_usuario    INTEGER,
    p_tabla         VARCHAR,
    p_transaccion   VARCHAR
  )
    RETURNS SETOF RECORD AS
  $body$
  /**************************************************************************
   SISTEMA:		Seguimiento de Proyectos reportes
   FUNCION: 		sp.ft_def_proyecto_rep
   DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto'
   en formato de reporte
   AUTOR: 		 (yac)
   FECHA:	        16-03-2017 9:56:10
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

    v_nombre_funcion = 'sp.ft_def_proyecto_sel';
    v_parametros = pxp.f_get_record(p_tabla);
    /*********************************
   #TRANSACCION:  'SP_DEFPROREP_SEL'
   #DESCRIPCION:	Consulta que devuelve los datos resumen para el reporte general
   #AUTOR:		yac
   #FECHA:		16-03-2017 08:56:10
  ***********************************/

    IF (p_transaccion = 'SP_DEFPROREP_SEL')
    THEN

      BEGIN
        return QUERY SELECT
                             deprac.id_def_proyecto_actividad,
                             deprac.id_def_proyecto,
                             deprac.id_actividad,
                             deprac.descripcion,
                             tact.actividad,
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
                           where deprac.id_def_proyecto = v_parametros.id_def_proyecto
                           GROUP BY deprac.id_def_proyecto_actividad, tact.actividad, tact.id_actividad_padre,
                             usu1.cuenta, usu2.cuenta, tact.id_actividad_padre
                           ORDER BY deprac.fecha_reg asc;

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