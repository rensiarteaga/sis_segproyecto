CREATE OR REPLACE FUNCTION sp.f_calcular_porcentaje_suministro(v_invitacion BIT, v_adjudicacion BIT, v_documento BIT,
                                                               v_llegada    BIT)
  RETURNS NUMERIC AS
$body$
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
  resultado NUMERIC := 0;
  v_nombre_funcion         TEXT;
  v_resp                   VARCHAR;
BEGIN

  v_nombre_funcion := 'sp.f_calcular_porcentaje_suministro';

  IF (v_invitacion)
  THEN
    resultado := resultado + 0.25;
  END IF;
  IF (v_adjudicacion)
  THEN
    resultado := resultado + 0.25;
  END IF;
  IF (v_documento)
  THEN
    resultado := resultado + 0.25;
  END IF;
  IF (v_llegada)
  THEN
    resultado := resultado + 0.25;
  END IF;
  RETURN resultado;
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
