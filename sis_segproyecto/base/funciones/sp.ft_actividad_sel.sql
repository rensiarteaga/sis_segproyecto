--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_actividad_sel(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_actividad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tactividad'
 AUTOR: 		 (admin)
 FECHA:	        31-01-2017 21:38:35
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

  v_nombre_funcion = 'sp.ft_actividad_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_ACTI_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		31-01-2017 21:38:35
  ***********************************/

  IF (p_transaccion = 'SP_ACTI_SEL')
  THEN

    BEGIN
      --Sentencia de la consulta
      v_consulta:='select
						acti.id_actividad,
						acti.id_actividad_padre,
						acti.actividad,
						acti.tipo_actividad,
						acti.estado_reg,
						acti.fecha_reg,
						acti.usuario_ai,
						acti.id_usuario_reg,
						acti.id_usuario_ai,
						acti.fecha_mod,
						t.id_tipo,
						t.tipo,
						acti.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from sp.tactividad acti
						left join segu.tusuario usu1 on usu1.id_usuario = acti.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = acti.id_usuario_mod
            left join sp.ttipo t on t.id_tipo = acti.id_tipo
				        where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta || v_parametros.filtro;
      v_consulta:=
      v_consulta || ' order by ' || v_parametros.ordenacion || ' ' || v_parametros.dir_ordenacion || ' limit ' ||
      v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      RETURN v_consulta;

    END;

    /*********************************
     #TRANSACCION:  'SP_ACTI_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		31-01-2017 21:38:35
    ***********************************/

  ELSIF (p_transaccion = 'SP_ACTI_CONT')
    THEN

      BEGIN
        --Sentencia de la consulta de conteo de registros
        v_consulta:='select count(id_actividad)
					    from sp.tactividad acti
					    inner join segu.tusuario usu1 on usu1.id_usuario = acti.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = acti.id_usuario_mod
					    where ';

        --Definicion de la respuesta
        v_consulta:=v_consulta || v_parametros.filtro;

        --Devuelve la respuesta
        RETURN v_consulta;

      END;

      /*********************************
       #TRANSACCION:  'SP_ACT_ARB_SEL'
       #DESCRIPCION:	Consulta de datos
       #AUTOR:		admin
       #FECHA:		31-01-2017 21:38:35
      ***********************************/

  ELSEIF (p_transaccion = 'SP_ACT_ARB_SEL')
    THEN

      BEGIN
        --Sentencia de la consulta
        v_consulta:='select
                      acti.id_actividad,
                      acti.id_actividad_padre,
                      acti.actividad,
                      case
                         when acti.id_actividad_padre is null then ''raiz''::varchar
                         else ''rama''::varchar
                      end as tipo_nodo,
                       ''false''::varchar as checked,
                      acti.id_tipo,
                      t.tipo
                from sp.tactividad acti join sp.ttipo t on acti.id_tipo=t.id_tipo
				        where  ';

        --Definicion de la respuesta
        IF v_parametros.id_padre != '%'
        THEN
          v_consulta:=v_consulta || ' acti.id_actividad_padre = ' || v_parametros.id_padre;
        ELSE
          v_consulta:=v_consulta || ' acti.id_actividad_padre is null';

        END IF;
        v_consulta:=v_consulta || ' order by acti.id_actividad';
        RAISE NOTICE '%', v_consulta;
        --Devuelve la respuesta
        RETURN v_consulta;

      END;
      /*********************************
          #TRANSACCION:  'SP_ACT_TIP_SEL'
          #DESCRIPCION:	Consulta de datos para obtener los tipos de una actividad
          #AUTOR:		admin
          #FECHA:		27-03-2017 21:38:35
         ***********************************/

  ELSEIF (p_transaccion = 'SP_ACT_TIP_SEL')
    THEN

      BEGIN
        --Sentencia de la consulta
        v_consulta:='select
                    id_tipo,
                    tipo
                    from sp.ttipo';
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