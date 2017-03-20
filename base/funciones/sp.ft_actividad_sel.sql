--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_actividad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
  RETURNS varchar AS
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

  v_consulta    		varchar;
  v_parametros  		record;
  v_nombre_funcion   	text;
  v_resp				varchar;

BEGIN

  v_nombre_funcion = 'sp.ft_actividad_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_ACTI_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		31-01-2017 21:38:35
  ***********************************/

  if(p_transaccion='SP_ACTI_SEL')then

    begin
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
						acti.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from sp.tactividad acti
						left join segu.tusuario usu1 on usu1.id_usuario = acti.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = acti.id_usuario_mod
				        where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;

    end;

    /*********************************
     #TRANSACCION:  'SP_ACTI_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		31-01-2017 21:38:35
    ***********************************/

  elsif(p_transaccion='SP_ACTI_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_actividad)
					    from sp.tactividad acti
					    inner join segu.tusuario usu1 on usu1.id_usuario = acti.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = acti.id_usuario_mod
					    where ';

      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;

    /*********************************
     #TRANSACCION:  'SP_ACT_ARB_SEL'
     #DESCRIPCION:	Consulta de datos
     #AUTOR:		admin
     #FECHA:		31-01-2017 21:38:35
    ***********************************/

  elseif(p_transaccion='SP_ACT_ARB_SEL')then

    begin
      --Sentencia de la consulta
      v_consulta:='select
						acti.id_actividad,
						acti.id_actividad_padre,
						acti.actividad,
						acti.estado_reg,
						acti.fecha_reg,
						acti.usuario_ai,
						acti.id_usuario_reg,
						acti.id_usuario_ai,
						acti.fecha_mod,
						acti.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        case
                          when acti.id_actividad_padre is null then
                             ''raiz''::varchar
                          else
                             ''rama''::varchar
                        end as  tipo_nodo,
                        ''false''::varchar as checked
						from sp.tactividad acti
						inner join segu.tusuario usu1 on usu1.id_usuario = acti.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = acti.id_usuario_mod
				        where  ';

      --Definicion de la respuesta
      if v_parametros.id_padre != '%' then
        v_consulta:=v_consulta||' acti.id_actividad_padre = '||v_parametros.id_padre;
      ELSE
        v_consulta:=v_consulta||' acti.id_actividad_padre is null';

      end if;
      v_consulta:=v_consulta||' order by acti.id_actividad';
      raise NOTICE '%',v_consulta;
      --Devuelve la respuesta
      return v_consulta;

    end;


  else

    raise exception 'Transaccion inexistente';

  end if;

  EXCEPTION

  WHEN OTHERS THEN
    v_resp='';
    v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
    v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
    raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;