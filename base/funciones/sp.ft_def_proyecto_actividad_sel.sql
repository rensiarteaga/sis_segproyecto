--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_actividad_sel(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto_actividad'
 AUTOR: 		 (admin)
 FECHA:	        10-11-2016 06:41:48
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

  v_nombre_funcion = 'sp.ft_def_proyecto_actividad_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_DEPRAC_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		10-11-2016 06:41:48
  ***********************************/

  IF (p_transaccion = 'SP_DEPRAC_SEL')
  THEN

    BEGIN
      --Sentencia de la consulta
      v_consulta:='WITH RECURSIVE tree AS (
  SELECT id_actividad,actividad,id_actividad_padre, id_actividad::TEXT AS ancestors
  FROM sp.tactividad WHERE id_actividad_padre IS NULL

  UNION ALL

  SELECT ta.id_actividad,ta.actividad,ta.id_actividad_padre,(tree.ancestors || ''->'' || ta.id_actividad::TEXT) as ancestors
  FROM sp.tactividad ta, tree
  WHERE ta.id_actividad_padre= tree.id_actividad
) select
    deprac.id_def_proyecto_actividad,
    deprac.id_def_proyecto,
    deprac.id_actividad,
    deprac.estado_reg,
    deprac.descripcion,
    deprac.usuario_ai,
    deprac.fecha_reg,
    deprac.id_usuario_reg,
    deprac.id_usuario_ai,
    deprac.fecha_mod,
    deprac.id_usuario_mod,
    tact.actividad,
    usu1.cuenta as usr_reg,
    usu2.cuenta as usr_mod,
    CASE WHEN (tact.id_actividad_padre IS NOT NULL ) THEN
      min(vpp.fechaordenproceder)::varchar
    else
     (SELECT min(vcpp.fechaordenproceder)::varchar from ((select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad_padre=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto) union all (select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto)) ped JOIN  sp.vcsa_proyecto_pedido vcpp on ped.id_pedido=vcpp.id_pedido)
    END AS min_fecha_orden,
    CASE WHEN (tact.id_actividad_padre IS NOT NULL ) THEN
      max(vpp.fecha_entrega_contrato_prev)::varchar
    ELSE
      (SELECT max(vcpp.fecha_entrega_contrato_prev)::varchar from ((select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad_padre=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto) union all (select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto)) ped JOIN  sp.vcsa_proyecto_pedido vcpp on ped.id_pedido=vcpp.id_pedido)
    END AS max_fecha_entrega,
    CASE WHEN (tact.id_actividad_padre IS NOT NULL ) THEN
      (DATE (max(vpp.fecha_entrega_contrato_prev)::date) - DATE (min(vpp.fechaordenproceder)::date))::integer
    ELSE
      (SELECT (date (max(vcpp.fecha_entrega_contrato_prev)) - DATE (min(vcpp.fechaordenproceder)))::integer from ((select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad_padre=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto) union all (select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto)) ped JOIN  sp.vcsa_proyecto_pedido vcpp on ped.id_pedido=vcpp.id_pedido)
    END AS plazo,
    CASE WHEN (tact.id_actividad_padre IS NOT NULL ) THEN
      sum(vpp.monto_total)
    else (SELECT sum(vcpp.monto_total) from ((select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad_padre=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto) union all (select DISTINCT tdpap.id_pedido from sp.tdef_proyecto_actividad tdpa join sp.tactividad ta on tdpa.id_actividad = ta.id_actividad and ta.id_actividad=deprac.id_actividad join sp.tdef_proyecto_actividad_pedido tdpap on tdpa.id_def_proyecto_actividad = tdpap.id_def_proyecto_actividad
    where tdpa.id_def_proyecto=deprac.id_def_proyecto)) ped JOIN  sp.vcsa_proyecto_pedido vcpp on ped.id_pedido=vcpp.id_pedido)
    END as monto_suma
    from sp.tdef_proyecto_actividad deprac
    inner join segu.tusuario usu1 on usu1.id_usuario = deprac.id_usuario_reg
    left join segu.tusuario usu2 on usu2.id_usuario = deprac.id_usuario_mod
    join tree tact on tact.id_actividad = deprac.id_actividad
    LEFT JOIN sp.tdef_proyecto_actividad_pedido dpap ON deprac.id_def_proyecto_actividad = dpap.id_def_proyecto_actividad
    LEFT JOIN sp.vcsa_proyecto_pedido vpp ON vpp.id_pedido = dpap.id_pedido

             where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=v_consulta ||
                  ' GROUP BY deprac.id_def_proyecto_actividad,tact.actividad,tact.id_actividad_padre,usu1.cuenta,usu2.cuenta,tact.ancestors ';

      v_consulta:=
      v_consulta || ' order by tact.ancestors ASC, ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion ||
      ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      RAISE NOTICE '%', v_consulta;
      --Devuelve la respuesta
      RETURN v_consulta;

    END;

    /*********************************
     #TRANSACCION:  'SP_DEPRAC_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		10-11-2016 06:41:48
    ***********************************/

  ELSIF (p_transaccion = 'SP_DEPRAC_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(id_def_proyecto_actividad)
					    from sp.tdef_proyecto_actividad deprac
					    inner join segu.tusuario usu1 on usu1.id_usuario = deprac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = deprac.id_usuario_mod
  	        join sp.tactividad tact on tact.id_actividad = deprac.id_actividad
            where ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;

        --Devuelve la respuesta
        RETURN v_consulta;

      END;

      /*********************************
#TRANSACCION:  'SP_PROSEG_SEL'
#DESCRIPCION:	Consulta de datos para devolver actividades y sub activi8dades de una definicion de proyecto
#AUTOR:		JUAN
#FECHA:		09-03-2017 06:41:48
***********************************/

  ELSIF (p_transaccion = 'SP_PROSEG_SEL')
    THEN

      BEGIN
        --Sentencia de la consulta
        v_consulta:='WITH RECURSIVE tree AS (
          SELECT id_actividad,actividad,id_actividad_padre, id_actividad::TEXT AS ancestors
          FROM sp.tactividad WHERE id_actividad_padre IS NULL
          UNION ALL
          SELECT ta.id_actividad,ta.actividad,ta.id_actividad_padre,(tree.ancestors || ''->'' || ta.id_actividad::TEXT) as ancestors
          FROM sp.tactividad ta, tree
          WHERE ta.id_actividad_padre= tree.id_actividad
          )select
            deprac.id_def_proyecto_actividad,
            deprac.id_def_proyecto,
            deprac.id_actividad,
            tact.actividad,
            case when (tact.id_actividad_padre is not null) then
              0::numeric
            END as porcentaje,
                    case when (tact.id_actividad_padre is not null) then
                      ''hijo''::varchar
                    else ''padre''::varchar end as tipo_actividad
            from sp.tdef_proyecto_actividad deprac
            join tree tact on tact.id_actividad = deprac.id_actividad
          where ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;
        v_consulta:=v_consulta || ' ORDER BY tact.ancestors ASC ';

        RAISE NOTICE '%', v_consulta;
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;