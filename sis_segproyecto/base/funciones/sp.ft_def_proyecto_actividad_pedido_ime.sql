CREATE OR REPLACE FUNCTION "sp"."ft_def_proyecto_actividad_pedido_ime"(
  p_administrador INTEGER, p_id_usuario INTEGER, p_tabla CHARACTER VARYING, p_transaccion CHARACTER VARYING)
  RETURNS CHARACTER VARYING AS
$BODY$

/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_pedido_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_actividad_pedido'
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

  v_nro_requerimiento                INTEGER;
  v_parametros                       RECORD;
  v_id_requerimiento                 INTEGER;
  v_resp                             VARCHAR;
  v_nombre_funcion                   TEXT;
  v_mensaje_error                    TEXT;
  v_id_def_proyecto_actividad_pedido INTEGER;
  va_id_pedidos                      VARCHAR [];
  v_id_pedido                       INTEGER;

BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_actividad_pedido_ime';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_DEPRACPE_INS'
   #DESCRIPCION:	Insercion de registros
   #AUTOR:		admin
   #FECHA:		12-11-2016 12:56:05
  ***********************************/

  IF (p_transaccion = 'SP_DEPRACPE_INS')
  THEN

    BEGIN
      --Sentencia de la insercion

      va_id_pedidos := string_to_array(v_parametros.id_pedidos, ',');


      FOREACH v_id_pedido IN ARRAY va_id_pedidos
      LOOP

        INSERT INTO sp.tdef_proyecto_actividad_pedido (
          id_def_proyecto_actividad,
          id_pedido,
          estado_reg,
          id_usuario_ai,
          id_usuario_reg,
          usuario_ai,
          fecha_reg,
          id_usuario_mod,
          fecha_mod
        ) VALUES (
          v_parametros.id_def_proyecto_actividad,
          v_id_pedido::INTEGER,
          'activo',
          v_parametros._id_usuario_ai,
          p_id_usuario,
          v_parametros._nombre_usuario_ai,
          now(),
          NULL,
          NULL


        )
        RETURNING id_def_proyecto_actividad_pedido
          INTO v_id_def_proyecto_actividad_pedido;

      END LOOP;
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                  'Definición proyecto actividad pedido almacenado(a) con exito (id_def_proyecto_actividad_pedido'
                                  || v_id_def_proyecto_actividad_pedido || ')');
      v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad_pedido',
                                  v_id_def_proyecto_actividad_pedido :: VARCHAR);

      --Devuelve la respuesta
      RETURN v_resp;

    END;

    /*********************************
     #TRANSACCION:  'SP_DEPRACPE_MOD'
     #DESCRIPCION:	Modificacion de registros
     #AUTOR:		admin
     #FECHA:		12-11-2016 12:56:05
    ***********************************/

  ELSIF (p_transaccion = 'SP_DEPRACPE_MOD')
    THEN

      BEGIN
        --Sentencia de la modificacion
        UPDATE sp.tdef_proyecto_actividad_pedido
        SET
          id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad,
          id_pedido                 = v_parametros.id_pedido,
          id_usuario_mod            = p_id_usuario,
          fecha_mod                 = now(),
          id_usuario_ai             = v_parametros._id_usuario_ai,
          usuario_ai                = v_parametros._nombre_usuario_ai
        WHERE id_def_proyecto_actividad_pedido = v_parametros.id_def_proyecto_actividad_pedido;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Definición proyecto actividad pedido modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad_pedido',
                                    v_parametros.id_def_proyecto_actividad_pedido :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

      /*********************************
       #TRANSACCION:  'SP_DEPRACPE_ELI'
       #DESCRIPCION:	Eliminacion de registros
       #AUTOR:		admin
       #FECHA:		12-11-2016 12:56:05
      ***********************************/

  ELSIF (p_transaccion = 'SP_DEPRACPE_ELI')
    THEN

      BEGIN
        --Sentencia de la eliminacion
        DELETE FROM sp.tdef_proyecto_actividad_pedido
        WHERE id_def_proyecto_actividad_pedido = v_parametros.id_def_proyecto_actividad_pedido;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Definición proyecto actividad pedido eliminado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad_pedido',
                                    v_parametros.id_def_proyecto_actividad_pedido :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

  ELSE

    RAISE EXCEPTION 'Transaccion inexistente: %', p_transaccion;

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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "sp"."ft_def_proyecto_actividad_pedido_ime"( INTEGER, INTEGER, CHARACTER VARYING, CHARACTER VARYING )
OWNER TO postgres;
