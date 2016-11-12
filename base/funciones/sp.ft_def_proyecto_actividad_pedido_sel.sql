/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_pedido_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sp.tdef_proyecto_actividad_pedido'
 AUTOR: 		 (admin)
 FECHA:	        12-11-2016 12:56:05
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

	v_nombre_funcion = 'sp.ft_def_proyecto_actividad_pedido_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SP_DEPRACPE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		yac	
 	#FECHA:		06-03-2017 12:56:05
	***********************************/

	if(p_transaccion='SP_DEPRACPE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						depracpe.id_def_proyecto_actividad_pedido,
						depracpe.id_def_proyecto_actividad,
						depracpe.id_pedido,
						depracpe.estado_reg,
						depracpe.id_usuario_ai,
						depracpe.id_usuario_reg,
						depracpe.usuario_ai,
						depracpe.fecha_reg,
						depracpe.id_usuario_mod,
						depracpe.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        vped.pedido,
                        vped.nrosap
						from sp.tdef_proyecto_actividad_pedido depracpe
						inner join segu.tusuario usu1 on usu1.id_usuario = depracpe.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = depracpe.id_usuario_mod
                        inner join sp.vcsa_proyecto_pedido vped on vped.idpedido=depracpe.id_pedido
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SP_DEPRACPE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		12-11-2016 12:56:05
	***********************************/

	elsif(p_transaccion='SP_DEPRACPE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_def_proyecto_actividad_pedido)
					    from sp.tdef_proyecto_actividad_pedido depracpe
					    inner join segu.tusuario usu1 on usu1.id_usuario = depracpe.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = depracpe.id_usuario_mod
                        inner join sp.vcsa_proyecto_pedido vped on vped.idpedido=depracpe.id_pedido

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