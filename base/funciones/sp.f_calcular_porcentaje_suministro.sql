CREATE OR REPLACE FUNCTION sp.f_calcular_porcentaje_suministro(v_invitacion BIT, v_adjudicacion BIT, v_documento BIT,
                                                               v_llegada    BIT)
  RETURNS NUMERIC AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.f_calcular_porcentaje_suministro
 DESCRIPCION:   Funcion que calcular el valor del calificacion de los suminsitros
 AUTOR: 		 YAC
 FECHA:	        30-03-2017 17:56:10
 COMENTARIOS: La funcion servira para calcular la calificacion de las actividades suministro
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE
  resultado NUMERIC := 0;
  cantidadParametros NUMERIC := 4;
  v_nombre_funcion         TEXT;
  v_resp                   VARCHAR;
BEGIN

  v_nombre_funcion := 'sp.f_calcular_porcentaje_suministro';

  IF (v_invitacion)
  THEN
    resultado := resultado + (1/cantidadParametros);
  END IF;
  IF (v_adjudicacion)
  THEN
    resultado := resultado + (1/cantidadParametros);
  END IF;
  IF (v_documento)
  THEN
    resultado := resultado + (1/cantidadParametros);
  END IF;
  IF (v_llegada)
  THEN
    resultado := resultado + (1/cantidadParametros);
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

