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

      v_consulta:='SELECT
                tpa.id_def_proyecto_actividad,
                tpa.id_def_proyecto,
                v_id_actividad                AS id_actividad,
                tpa.descripcion,
                v_actividad                   AS actividad,
                v_fechaordenproceder          AS min_fecha_orden,
                v_fecha_entrega_contrato_prev AS max_fecha_entrega,
                (DATE (v_fecha_entrega_contrato_prev)-DATE (v_fechaordenproceder))::integer as plazo,
                v_monto::numeric as monto_suma,
                v_id_tipo                     AS tipo_actividad,
                v_ancestors::varchar                   AS ancestors,
                v_nivel                       AS nivel
              FROM sp.f_obtener_arbol_actividades(' || v_parametros.id_def_proyecto || ') aa
                JOIN sp.tdef_proyecto_actividad tpa
                  ON aa.v_id_def_proyecto_actividad = tpa.id_def_proyecto_actividad
              ORDER BY aa.v_id_tipo, aa.v_ancestors';


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
#AUTOR:		YAC
#FECHA:		27-03-2017 06:41:48
***********************************/

  ELSIF (p_transaccion = 'SP_PROSEG_SEL')
    THEN

      BEGIN
        --se esta trabajando queda pendiente.....
        --Sentencia de la consulta
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
        ) ON COMMIT DROP;
        INSERT INTO temp_actividad_datos (SELECT *
                                          FROM
                                              sp.f_obtener_arbol_actividades_seguimiento(v_parametros.id_def_proyecto));


        v_consulta:='SELECT
          tad.id_def_proyecto_actividad,
          id_def_proyecto,
          id_actividad,
          actividad,
            CASE WHEN id_actividad_padre is not NULL and tad.nivel>2 THEN
        coalesce(tpsa.porcentaje_avance,0)::numeric
        when id_actividad_padre is not NULL and tad.nivel>1 and (tad.id_tipo = 4 or tad.id_tipo = 1) then
         coalesce(tpsa.porcentaje_avance,0)::numeric
        end  as porcentaje,
        coalesce(id_def_proyecto_seguimiento_actividad,0)::integer as id_def_proyecto_seguimiento_actividad,
          nivel,
          round(interno,2) as interno,
        tad.id_tipo as tipo
        from sp.tdef_proyecto_seguimiento_actividad tpsa
          join sp.tdef_proyecto_seguimiento tps on tpsa.id_def_proyecto_seguimiento = tps.id_def_proyecto_seguimiento and tps.id_def_proyecto_seguimiento=(select id_def_proyecto_seguimiento from sp.tdef_proyecto_seguimiento ORDER BY fecha DESC LIMIT 1)
          RIGHT JOIN temp_actividad_datos tad ON tpsa.id_def_proyecto_actividad=tad.id_def_proyecto_actividad
        WHERE ';
        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;
        v_consulta:=v_consulta || ' ORDER BY tipo,id_def_proyecto_actividad ';

        --RAISE NOTICE '%',v_consulta;
        --RAISE EXCEPTION 'error de provocado de yac';
        --Devuelve la respuesta
        RETURN v_consulta;

      END;
      /*********************************
#TRANSACCION:  'SP_PROSEGE_SEL'
#DESCRIPCION:	Consulta de datos para devolver actividades y sub activi8dades de una definicion de proyecto cuando se lo edita
#AUTOR:		YAC
#FECHA:	13-03-2017 06:41:48
***********************************/

  ELSIF (p_transaccion = 'SP_PROSEGE_SEL')
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
        ) ON COMMIT DROP;
        INSERT INTO temp_actividad_datos (SELECT *
                                          FROM
                                              sp.f_obtener_arbol_actividades_seguimiento(v_parametros.id_def_proyecto));

        --Sentencia de la consulta
        v_consulta:=' SELECT
          tad.id_def_proyecto_actividad,
          id_def_proyecto,
          id_actividad,
          actividad,
            CASE WHEN id_actividad_padre is not NULL and tad.nivel>2 THEN
          tpsa.porcentaje_avance::numeric
        when id_actividad_padre is not NULL and tad.nivel>1 and (tad.id_tipo = 4 or tad.id_tipo = 1 or tad.id_tipo = 3 ) then --AGREGANDO A LA CONSTRUCCION MAS
         tpsa.porcentaje_avance::numeric
        end  as porcentaje,
        coalesce(tpsa.id_def_proyecto_seguimiento_actividad,0)::integer as id_def_proyecto_seguimiento_actividad,
          nivel,
          round(interno,2) as interno,
        tad.id_tipo as tipo
        from sp.tdef_proyecto_seguimiento_actividad tpsa
          join sp.tdef_proyecto_seguimiento tps on tpsa.id_def_proyecto_seguimiento = tps.id_def_proyecto_seguimiento
          RIGHT JOIN temp_actividad_datos tad ON tpsa.id_def_proyecto_actividad=tad.id_def_proyecto_actividad
        WHERE ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;
        v_consulta:=v_consulta || ' ORDER BY tpsa.id_def_proyecto_seguimiento_actividad';


        RAISE NOTICE '% ', v_parametros.id_def_proyecto;
        --RAISE EXCEPTION ' prueba de datos';
        --Devuelve la respuesta
        RETURN v_consulta;

      END;

      /*********************************
 #TRANSACCION:  'SP_PROSEGAT_SEL'
 #DESCRIPCION:	Consulta para obtener las actividades del seguimiento total
 #AUTOR:		JUAN
 #FECHA:	27-03-2017 06:41:48
 ***********************************/

  ELSIF (p_transaccion = 'SP_PROSEGAT_SEL')
    THEN

      BEGIN
        --Sentencia de la consulta
        v_consulta:='select
oaa.v_id_def_proyecto_actividad,
oaa.v_id_actividad,
oaa.v_actividad,
--es.estado,
COALESCE(es.estado,'' '') as estado,
t.id_tipo,
t.tipo,
psae.id_proy_seguimiento_actividad_estado,
pst.id_def_proyecto_seguimiento_total,
oaa.v_nivel,
 --COALESCE(es.id_estado_seguimiento,0) as id_estado_seguimiento
--es.id_estado_seguimiento
NULL::integer as id_estado_seguimiento
from sp.tdef_proyecto_seguimiento_total pst join sp.tproy_seguimiento_actividad_estado psae
on pst.id_def_proyecto_seguimiento_total=psae.id_def_proyecto_seguimiento_total
join sp.testado_seguimiento es on es.id_estado_seguimiento = psae.id_estado_seguimiento
RIGHT join sp.f_obtener_arbol_actividades(' || v_parametros.id_def_proyecto || ') oaa on oaa.v_id_def_proyecto_actividad = psae.id_proyecto_actividad
join sp.ttipo t on t.id_tipo=oaa.v_id_tipo
        WHERE ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;
        v_consulta:=v_consulta || '
        ORDER BY oaa.v_ancestors ASC ';

        RAISE NOTICE '%', v_consulta;
        -- RAISE EXCEPTION 'eero juancinho';
        --RAISE EXCEPTION ' prueba de guardado';
        --Devuelve la respuesta
        RETURN v_consulta;

      END;

      /*********************************
#TRANSACCION:  'SP_PROSEGAT_EDIT_SEL'
#DESCRIPCION:	Consulta para obtener las actividades del seguimiento total
#AUTOR:		JUAN
#FECHA:	27-03-2017 06:41:48
***********************************/

  ELSIF (p_transaccion = 'SP_PROSEGAT_EDIT_SEL')
    THEN

      BEGIN
        --Sentencia de la consulta
        v_consulta:='select
oaa.v_id_def_proyecto_actividad,
oaa.v_id_actividad,
oaa.v_actividad,
es.estado,
t.id_tipo,
t.tipo,
psae.id_proy_seguimiento_actividad_estado,
pst.id_def_proyecto_seguimiento_total,
oaa.v_nivel,
es.id_estado_seguimiento
from sp.tdef_proyecto_seguimiento_total pst join sp.tproy_seguimiento_actividad_estado psae
on pst.id_def_proyecto_seguimiento_total=psae.id_def_proyecto_seguimiento_total and pst.id_def_proyecto_seguimiento_total= '
                    || v_parametros.id_def_proyecto_seguimiento_total || '
join sp.testado_seguimiento es on es.id_estado_seguimiento = psae.id_estado_seguimiento
RIGHT join sp.f_obtener_arbol_actividades(' || v_parametros.id_def_proyecto || ') oaa on oaa.v_id_def_proyecto_actividad = psae.id_proyecto_actividad
join sp.ttipo t on t.id_tipo=oaa.v_id_tipo
        WHERE ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;
        v_consulta:=v_consulta || '
        ORDER BY oaa.v_ancestors ASC ';

        RAISE NOTICE '%', v_consulta;
        --RAISE EXCEPTION ' prueba de guardado';
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
      RAISE EXCEPTION ' % ', v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;