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
 #DESCRIPCION:	Consulta que devuelve los datos resumen para el reporte de ponderacion del proyecto

 #AUTOR:		yac
 #FECHA:		16-03-2017 08:56:10
***********************************/

  IF (p_transaccion = 'SP_DEFPROREP_SEL')
  THEN

    BEGIN
      RETURN QUERY SELECT
                     v_id_actividad          AS id_actividad,
                     v_actividad             AS actividad,
                     v_suma                  AS presupuesto,
                     v_duracion              AS duracion,
                     v_multiplicacion        AS multiplicacion,
                     round(v_ponderacion, 4) AS valor_ponderado,
                     round(v_porcentaje, 2)  AS valor_ponderado_porcentaje
                   FROM sp.f_obtener_ponderacion_actividad(v_parametros.id_def_proyecto)
                   ORDER BY v_id_tipo;

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