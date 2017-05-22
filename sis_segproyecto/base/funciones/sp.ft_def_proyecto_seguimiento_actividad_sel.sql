CREATE OR REPLACE FUNCTION "sp"."ft_def_proyecto_seguimiento_actividad_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_actividad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto_seguimiento_actividad'
 AUTOR: 		 (admin)
 FECHA:	        24-02-2017 05:02:05
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

	v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_actividad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_PRSEAC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		24-02-2017 05:02:05
	***********************************/

	if(p_transaccion='SP_PRSEAC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						prseac.id_def_proyecto_seguimiento_actividad,
						prseac.id_def_proyecto_seguimiento,
						prseac.id_def_proyecto_actividad,
						prseac.estado_reg,
						prseac.porcentaje_avance,
						prseac.usuario_ai,
						prseac.fecha_reg,
						prseac.id_usuario_reg,
						prseac.id_usuario_ai,
						prseac.id_usuario_mod,
						prseac.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from sp.tdef_proyecto_seguimiento_actividad prseac
						inner join segu.tusuario usu1 on usu1.id_usuario = prseac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = prseac.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SP_PRSEAC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		24-02-2017 05:02:05
	***********************************/

	elsif(p_transaccion='SP_PRSEAC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_def_proyecto_seguimiento_actividad)
					    from sp.tdef_proyecto_seguimiento_actividad prseac
					    inner join segu.tusuario usu1 on usu1.id_usuario = prseac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = prseac.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "sp"."ft_def_proyecto_seguimiento_actividad_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
