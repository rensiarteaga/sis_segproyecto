CREATE OR REPLACE FUNCTION sp.ft_pedido_sel(p_administrador INTEGER, p_id_usuario INTEGER, p_tabla CHARACTER VARYING,
                                            p_transaccion   CHARACTER VARYING)
  RETURNS CHARACTER VARYING
LANGUAGE plpgsql
AS $$

/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_pedido_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la vista vcsa_proyecto_pedido
 AUTOR: 		 (Juan)
 FECHA:	        06-03-2017 09:38:35
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

BEGIN

  v_nombre_funcion = 'sp.ft_pedido_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_PED_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		juan
   #FECHA:		06-03-2017 09:38:35
  ***********************************/

  IF (p_transaccion = 'SP_PED_SEL')
  THEN

    BEGIN
      --Sentencia de la consulta
      v_consulta:='Select DISTINCT
                        vpd.id_pedido,
                        vpd.nrosap::varchar,
                        vpd.pedido::varchar,
                        vpd.nrocontrato::varchar,
                        vpd.fechaautorizacionpedido::varchar,
                        vpd.fechaordenproceder::varchar,
                        vpd.plazo_entrega_contrato,
                        vpd.plazo_entrega_contrato_unidad::varchar,
                        vpd.fecha_entrega_contrato_prev::varchar,
                        vpd.monto,
                        vpd.monedamonto,
                        plazo,
                        codinvitacion,
                        suministro,
                        case WHEN plazo is NULL then ''<i style="color: red">( Faltan valores ) </i>''::varchar else ''<i style="color: green">( Completo ) </i>''::varchar END as falta_valor
                        FROM  sp.vcsa_proyecto_pedido vpd join sp.tdef_proyecto dp on dp.id_proyecto= vpd.id_proyecto
				        where ';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=
      v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion || ' limit ' ||
      v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      RAISE NOTICE '%', v_consulta;
      --RAISE EXCEPTION 'error yac procovado';
      --Devuelve la respuesta
      RETURN v_consulta;

    END;

    /*********************************
     #TRANSACCION:  'SP_PED_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		juan
     #FECHA:		06-03-2017 09:38:35
    ***********************************/

  ELSIF (p_transaccion = 'SP_PED_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
        v_consulta:='Select
                        count( DISTINCT vpd.id_pedido)
                        FROM  sp.vcsa_proyecto_pedido vpd join sp.tdef_proyecto dp on dp.id_proyecto= vpd.id_proyecto
					    where ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;
         raise NOTICE  'consulta: %',v_consulta;

        --Devuelve la respuesta
        RETURN v_consulta;

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
$$
