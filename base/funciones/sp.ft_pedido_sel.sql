--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_pedido_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'sp.ft_pedido_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SP_PED_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		juan
 	#FECHA:		06-03-2017 09:38:35
	***********************************/

	if(p_transaccion='SP_PED_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='Select DISTINCT
                        vpd.idpedido as id_pedido,
                        vpd.nrosap::varchar,
                        vpd.pedido::varchar,
                        vpd.nrocontrato::varchar,
                        vpd.fechaautorizacionpedido::varchar,
                        vpd.fechaordenproceder::varchar,
                        vpd.plazo_entrega_contrato,
                        vpd.plazo_entrega_contrato_unidad::varchar,
                        vpd.fecha_entrega_contrato_prev::varchar,
                        vpd.monto,
                        vpd.monedamonto
                        FROM  sp.vcsa_proyecto_pedido vpd 
				        
                        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

raise NOTICE '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'SP_PED_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		juan
 	#FECHA:		06-03-2017 09:38:35
	***********************************/

	elsif(p_transaccion='SP_PED_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='Select DISTINCT
                        count(vpd.idpedido)
                        FROM  sp.vcsa_proyecto_pedido vpd 
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'SP_PED_ARB_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		juan
 	#FECHA:		06-03-2017 09:38:35
	***********************************/

	elseif(p_transaccion='SP_PED_ARB_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select DISTINCT
                        vpd.idpedido as id_pedido ,
                        vpd.nrosap,
                        vpd.pedido,
                        vpd.nrocontrato,
                        vpd.fechaautorizacionpedido,
                        vpd.fechaordenproceder,
                        vpd.plazo_entrega_contrato,
                        vpd.plazo_entrega_contrato_unidad,
                        vpd.fecha_entrega_contrato_prev,
                        vpd.monto,
                        vpd.monedamonto,
                        ''false''::varchar as checked
						FROM  sp.vcsa_proyecto_pedido vpd 
				        where  ';

			--Definicion de la respuesta
            v_consulta:=v_consulta||' 0=0 order by vpd.nrosap asc';
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