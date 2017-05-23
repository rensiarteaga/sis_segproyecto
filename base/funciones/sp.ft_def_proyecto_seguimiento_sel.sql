CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_seguimiento_sel(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto_seguimiento'
 AUTOR: 		 (admin)
 FECHA:	        24-02-2017 04:16:20
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

  v_consulta                    VARCHAR;
  v_parametros                  RECORD;
  v_nombre_funcion              TEXT;
  v_id_def_proyecto_seguimiento INTEGER;
  v_resp                        VARCHAR;

BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_SEPR_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		24-02-2017 04:16:20
  ***********************************/

  IF (p_transaccion = 'SP_SEPR_SEL')
  THEN
    v_id_def_proyecto_seguimiento := 0;
    v_id_def_proyecto_seguimiento = coalesce ((SELECT id_def_proyecto_seguimiento FROM sp.tdef_proyecto_seguimiento ORDER BY fecha DESC, id_def_proyecto_seguimiento DESC LIMIT 1),0);

    BEGIN
      --Sentencia de la consulta
      v_consulta:='select
						sepr.id_def_proyecto_seguimiento,
						sepr.id_def_proyecto,
						sepr.estado_reg,
						round(sepr.porcentaje,2) as porcentaje,
						sepr.fecha,
						sepr.descripcion,
						sepr.id_usuario_reg,
						sepr.usuario_ai,
						sepr.fecha_reg,
						sepr.id_usuario_ai,
						sepr.id_usuario_mod,
						sepr.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
            CASE WHEN (' ||v_id_def_proyecto_seguimiento||' = sepr.id_def_proyecto_seguimiento)THEN
              TRUE ::bool
            ELSE
              false::bool end as editado
						from sp.tdef_proyecto_seguimiento sepr
						inner join segu.tusuario usu1 on usu1.id_usuario = sepr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sepr.id_usuario_mod
				        where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=
      v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion || ' limit ' ||
      v_parametros.cantidad || ' offset ' || v_parametros.puntero;


      RAISE NOTICE '%', v_consulta;
      --RAISE EXCEPTION 'eerrrooooorr YAC';
      --Devuelve la respuesta
      RETURN v_consulta;

    END;

    /*********************************
     #TRANSACCION:  'SP_SEPR_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		24-02-2017 04:16:20
    ***********************************/

  ELSIF (p_transaccion = 'SP_SEPR_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(id_def_proyecto_seguimiento)
					    from sp.tdef_proyecto_seguimiento sepr
					    inner join segu.tusuario usu1 on usu1.id_usuario = sepr.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sepr.id_usuario_mod
					    where ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;

        --Devuelve la respuesta
        RETURN v_consulta;

      END;


      /*********************************
       #TRANSACCION:  'SP_SEPRTAPON_SEL'
       #DESCRIPCION:	Consulta que devuelve los calculos resumen de las actividades evaluadas
       #AUTOR:		yac
       #FECHA:		31-03-2017 04:16:20
      ***********************************/

  ELSIF (p_transaccion = 'SP_SEPRTAPON_SEL')
    THEN

      BEGIN
        DROP TABLE IF EXISTS temp_actividad_datos;
        CREATE TEMPORARY TABLE temp_actividad_datos (
          id_actividad              INTEGER,
          id_actividad_padre        INTEGER,
          actividad                 VARCHAR(100),
          nivel                     INTEGER,
          cantidad                  INTEGER,
          interno                   NUMERIC,
          id_def_proyecto_actividad INTEGER,
          id_tipo                   INTEGER
        );
        INSERT INTO temp_actividad_datos (SELECT *
                                          FROM
                                              sp.f_obtener_arbol_actividades_seguimiento(v_parametros.id_def_proyecto));

        ----consulta para sacar la tabla resumen
        v_consulta:='WITH RECURSIVE tt_actividades_seguimiento_actividad AS (
            SELECT
              tapa.id_actividad,
              tapa.id_actividad_padre,
              tapa.actividad,
              tapa.ancestors,
              tapa.nivel,
              tapa.id_tipo,
              CASE WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 2
                THEN
                  tpsa.porcentaje_avance :: NUMERIC
              WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 1 AND (tapa.id_tipo = 4 OR tapa.id_tipo = 1 or tapa.id_tipo=2)
                THEN
                  tpsa.porcentaje_avance :: NUMERIC
              END AS porcentaje_avance,

              tad.cantidad,
              interno,
              CASE WHEN tapa.id_actividad_padre IS NOT NULL AND tapa.nivel > 2
                THEN
                  coalesce(tpsa.porcentaje_avance, 0) :: NUMERIC * tad.interno :: NUMERIC
              WHEN tapa.id_actividad_padre IS NOT NULL AND tad.nivel > 1 AND (tad.id_tipo = 4 OR tad.id_tipo = 1 OR tad.id_tipo = 2 OR tad.id_tipo = 3) --AGREGANDO EL ID DE CONSTRUCCION (TEMP)
                THEN
                  coalesce(tpsa.porcentaje_avance, 0) :: NUMERIC * tad.interno :: NUMERIC

              ELSE
                0:: NUMERIC--tad.interno :: NUMERIC
              END AS avance
            FROM temp_arb_proyectos_actividades tapa
              LEFT JOIN ((SELECT
                            id_def_proyecto_seguimiento,
                            id_def_proyecto_actividad,
                            porcentaje_avance
                          FROM sp.tdef_proyecto_seguimiento_actividad where id_def_proyecto_seguimiento=' ||
                    v_parametros.id_def_proyecto_seguimiento || ')
                         UNION ALL (SELECT s.id_def_proyecto_seguimiento,id_def_proyecto_actividad,sp.f_calcular_porcentaje_suministro(s.invitacion, s.adjudicacion, s.documento_emarque,
                                                                                                            s.llegada_sitio) AS porcentaje_avance
                                    FROM sp.tsuministro s where s.id_def_proyecto_seguimiento=' ||
                    v_parametros.id_def_proyecto_seguimiento || ' ORDER BY id_def_proyecto_actividad)) tpsa ON tapa.id_def_proyecto_actividad = tpsa.id_def_proyecto_actividad
              JOIN temp_actividad_datos tad ON tapa.id_def_proyecto_actividad = tad.id_def_proyecto_actividad
              LEFT JOIN sp.tsuministro ts ON ts.id_def_proyecto_actividad = tad.id_def_proyecto_actividad and ts.id_def_proyecto_seguimiento='
                    || v_parametros.id_def_proyecto_seguimiento || '

            WHERE tpsa.id_def_proyecto_seguimiento = ' || v_parametros.id_def_proyecto_seguimiento || '
          --ORDER BY tapa.id_tipo, ancestors
        )
        SELECT
          t1.id_actividad,
          t1.id_actividad_padre,
          t1.actividad,
          t1.nivel,
          round(t1.avance, 2)                   AS avance,
          t1.ancestors,
          CASE WHEN t1.nivel = 3 THEN
            round(coalesce(t1.avance,0),2)
            ELSE
          round(sum(coalesce(t2.avance, 0)+
                    CASE WHEN t1.nivel=2 AND t1.id_tipo<>3 THEN t1.avance ELSE 0 END ), 2) end AS total_avance
        FROM tt_actividades_seguimiento_actividad t1
          left JOIN tt_actividades_seguimiento_actividad t2
            ON t1.id_actividad = t2.id_actividad_padre
        where t1.nivel<=2
        GROUP BY t1.id_tipo,
          t1.id_actividad,
          t1.id_actividad_padre,
          t1.actividad,
          t1.avance,
          t1.ancestors,t1.nivel
        ORDER BY t1.id_tipo, t1.ancestors';

        --Definicion de la respuesta
        -- v_consulta:=v_consulta || v_parametros.filtro;

        RAISE NOTICE '%', v_consulta;
        --RAISE EXCEPTION '%',v_parametros.id_def_proyecto;
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