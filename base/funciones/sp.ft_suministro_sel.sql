--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_suministro_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
  RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_suministro_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tsuministro'
 AUTOR: 		 (admin)
 FECHA:	        12-11-2016 14:03:32
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

  v_nombre_funcion = 'sp.ft_suministro_sel';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_SUM_SEL'
   #DESCRIPCION:	Consulta de datos
   #AUTOR:		admin
   #FECHA:		12-11-2016 14:03:32
  ***********************************/

  if(p_transaccion='SP_SUM_SEL')then

    begin
      --Sentencia de la consulta
      v_consulta:=' select
CASE WHEN s.id_seguimiento_suministro ISNULL THEN 0::INTEGER ELSE s.id_seguimiento_suministro END as id_seguimiento_suministro,
CASE WHEN s.id_seguimiento_suministro ISNULL THEN false ELSE true END as tipo_guardar,
                  p.id_def_proyecto,
                  deprac.id_def_proyecto_actividad,
                  a.actividad,
CASE WHEN s.documento_emarque ISNULL THEN 0::bit ELSE s.documento_emarque END as documento_emarque,
CASE WHEN s.invitacion ISNULL THEN 0::bit ELSE s.invitacion END as invitacion,
CASE WHEN s.adjudicacion ISNULL THEN 0::bit ELSE s.adjudicacion END as adjudicacion,
CASE WHEN s.llegada_sitio ISNULL THEN 0::bit ELSE s.llegada_sitio END as llegada_sitio,
CASE WHEN tact.id_actividad_padre ISNULL THEN TRUE::bool ELSE FALSE::bool END as padre

           from sp.tdef_proyecto_actividad deprac
           join sp.tdef_proyecto p on p.id_def_proyecto=deprac.id_def_proyecto
           join sp.tactividad tact on tact.id_actividad = deprac.id_actividad  and tact.id_actividad_padre is not null
           left join sp.tsuministro s on s.id_def_proyecto_actividad=deprac.id_def_proyecto_actividad
           join sp.tactividad a on a.id_actividad=deprac.id_actividad and a.id_tipo=2
           where  ';

      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
RAISE NOTICE '%',v_consulta;
      --Devuelve la respuesta
      -- RAISE NOTICE '%',v_consulta;
      -- raise exception 'error juan';
      return v_consulta;

    end;

    /*********************************
     #TRANSACCION:  'SP_SUM_CONT'
     #DESCRIPCION:	Conteo de registros
     #AUTOR:		admin
     #FECHA:		12-11-2016 14:03:32
    ***********************************/

  elsif(p_transaccion='SP_SUM_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(a.actividad)
           from sp.tdef_proyecto_actividad deprac
           join sp.tdef_proyecto p on p.id_def_proyecto=deprac.id_def_proyecto
           join sp.tactividad tact on tact.id_actividad = deprac.id_actividad  and tact.id_actividad_padre is not null
           left join sp.tsuministro s on s.id_def_proyecto_actividad=deprac.id_def_proyecto_actividad
           join sp.tactividad a on a.id_actividad=deprac.id_actividad and a.id_tipo=2
		   where ';

      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;

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