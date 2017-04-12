CREATE OR REPLACE FUNCTION "sp"."ft_def_proyecto_seguimiento_ime"(
  p_administrador INTEGER, p_id_usuario INTEGER, p_tabla CHARACTER VARYING, p_transaccion CHARACTER VARYING)
  RETURNS CHARACTER VARYING AS
$BODY$

/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_seguimiento'
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

  v_nro_requerimiento                     INTEGER;
  v_parametros                            RECORD;
  v_id_requerimiento                      INTEGER;
  v_resp                                  VARCHAR;
  v_nombre_funcion                        TEXT;
  v_mensaje_error                         TEXT;
  v_id_def_proyecto_seguimiento           INTEGER;
  j_def_proyecto_seguimiento_actividad    JSON;
  j_proyecto_seguimiento_actividad        JSON;
  v_id_def_proyecto_seguimiento_actividad INTEGER;
  v_promedio_pro_seg                      NUMERIC :=0;
  contador                                INTEGER :=0;
  v_id_def_proyecto_seguimiento_temp      VARCHAR;

BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_ime';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_SEPR_INS'
   #DESCRIPCION:	Insercion de registros
   #AUTOR:		admin
   #FECHA:		24-02-2017 04:16:20
  ***********************************/

  IF (p_transaccion = 'SP_SEPR_INS')
  THEN

    BEGIN
      --Sentencia de la insercion
      INSERT INTO sp.tdef_proyecto_seguimiento (
        id_def_proyecto,
        estado_reg,
        porcentaje,
        fecha,
        descripcion,
        id_usuario_reg,
        usuario_ai,
        fecha_reg,
        id_usuario_ai,
        id_usuario_mod,
        fecha_mod
      ) VALUES (
        v_parametros.id_def_proyecto,
        'activo',
        v_parametros.porcentaje,
        v_parametros.fecha,
        v_parametros.descripcion,
        p_id_usuario,
        v_parametros._nombre_usuario_ai,
        now(),
        v_parametros._id_usuario_ai,
        NULL,
        NULL


      )
      RETURNING id_def_proyecto_seguimiento
        INTO v_id_def_proyecto_seguimiento;

      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                  'Seguimiento de proyectos almacenado(a) con exito (id_def_proyecto_seguimiento' ||
                                  v_id_def_proyecto_seguimiento || ')');
      v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento', v_id_def_proyecto_seguimiento :: VARCHAR);

      --Devuelve la respuesta
      RETURN v_resp;

    END;

    /*********************************
     #TRANSACCION:  'SP_SEPR_MOD'
     #DESCRIPCION:	Modificacion de registros
     #AUTOR:		admin
     #FECHA:		24-02-2017 04:16:20
    ***********************************/

  ELSIF (p_transaccion = 'SP_SEPR_MOD')
    THEN

      BEGIN
        --Sentencia de la modificacion
        UPDATE sp.tdef_proyecto_seguimiento
        SET
          id_def_proyecto = v_parametros.id_def_proyecto,
          porcentaje      = v_parametros.porcentaje,
          fecha           = v_parametros.fecha,
          descripcion     = v_parametros.descripcion,
          id_usuario_mod  = p_id_usuario,
          fecha_mod       = now(),
          id_usuario_ai   = v_parametros._id_usuario_ai,
          usuario_ai      = v_parametros._nombre_usuario_ai
        WHERE id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Seguimiento de proyectos modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento',
                                    v_parametros.id_def_proyecto_seguimiento :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

      /*********************************
       #TRANSACCION:  'SP_SEPR_ELI'
       #DESCRIPCION:	Eliminacion de registros
       #AUTOR:		admin
       #FECHA:		24-02-2017 04:16:20
      ***********************************/

  ELSIF (p_transaccion = 'SP_SEPR_ELI')
    THEN

      BEGIN
        --Sentencia de la eliminacion
        DELETE FROM sp.tdef_proyecto_seguimiento
        WHERE id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Seguimiento de proyectos eliminado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento',
                                    v_parametros.id_def_proyecto_seguimiento :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;
      /*********************************
#TRANSACCION:  'SP_FSEPR_INS'
#DESCRIPCION:	Insercion de registros de proyecto serguinmiento con sus respectivas evaluaciones
#AUTOR:		juan
#FECHA:		10-03-2017 04:16:20
***********************************/

  ELSIF (p_transaccion = 'SP_FSEPR_INS')
    THEN


      BEGIN
        --raise notice 'prueba de json %', (SELECT j_def_proyecto_seguimiento_actividad->>'porcentaje' AS promedio FROM json_array_elements(j_proyecto_seguimiento_actividad));

        IF (v_parametros.tipo_form = 'new')
        THEN
          --Sentencia de la insercion
          INSERT INTO sp.tdef_proyecto_seguimiento (
            id_def_proyecto,
            estado_reg,
            fecha,
            descripcion,
            id_usuario_reg,
            usuario_ai,
            fecha_reg,
            id_usuario_ai,
            id_usuario_mod,
            fecha_mod
          ) VALUES (
            v_parametros.id_def_proyecto,
            'activo',
            v_parametros.fecha,
            v_parametros.descripcion,
            p_id_usuario,
            v_parametros._nombre_usuario_ai,
            now(),
            v_parametros._id_usuario_ai,
            NULL,
            NULL


          )
          RETURNING id_def_proyecto_seguimiento
            INTO v_id_def_proyecto_seguimiento;

          j_proyecto_seguimiento_actividad := v_parametros.json_new_records;

          FOR j_def_proyecto_seguimiento_actividad IN SELECT *
                                                      FROM json_array_elements(j_proyecto_seguimiento_actividad)
          LOOP

            --RAISE NOTICE 'id_def_proyecto_actividad %', j_def_proyecto_seguimiento_actividad->>'id_def_proyecto_actividad';
            INSERT INTO sp.tdef_proyecto_seguimiento_actividad (
              id_def_proyecto_seguimiento,
              id_def_proyecto_actividad,
              estado_reg,
              porcentaje_avance,
              usuario_ai,
              fecha_reg,
              id_usuario_reg,
              id_usuario_ai,
              id_usuario_mod,
              fecha_mod
            ) VALUES (
              v_id_def_proyecto_seguimiento,
              (j_def_proyecto_seguimiento_actividad ->> 'id_def_proyecto_actividad') :: INTEGER,
              'activo',
              (j_def_proyecto_seguimiento_actividad ->> 'porcentaje') :: NUMERIC,
              v_parametros._nombre_usuario_ai,
              now(),
              p_id_usuario,
              v_parametros._id_usuario_ai,
              NULL,
              NULL
            )
            RETURNING id_def_proyecto_seguimiento_actividad
              INTO v_id_def_proyecto_seguimiento_actividad;

          END LOOP;
          UPDATE sp.tdef_proyecto_seguimiento
          SET
            porcentaje = (SELECT sp.f_calcular_porcentaje_total_seguimiento(v_parametros.id_def_proyecto,
                                                                            v_id_def_proyecto_seguimiento))
          WHERE id_def_proyecto_seguimiento = v_id_def_proyecto_seguimiento;

        ELSE
          --Sentencia de la modificacion
          UPDATE sp.tdef_proyecto_seguimiento
          SET
            id_def_proyecto = v_parametros.id_def_proyecto,
            fecha           = v_parametros.fecha,
            descripcion     = v_parametros.descripcion,
            id_usuario_mod  = p_id_usuario,
            fecha_mod       = now(),
            id_usuario_ai   = v_parametros._id_usuario_ai,
            usuario_ai      = v_parametros._nombre_usuario_ai
          WHERE id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento;

          -- guardadando las subactividades
          j_proyecto_seguimiento_actividad := v_parametros.json_new_records;

          FOR j_def_proyecto_seguimiento_actividad IN SELECT *
                                                      FROM json_array_elements(j_proyecto_seguimiento_actividad)
          LOOP

            --RAISE NOTICE 'id_def_proyecto_actividad %', j_def_proyecto_seguimiento_actividad->>'id_def_proyecto_actividad';
            UPDATE sp.tdef_proyecto_seguimiento_actividad
            SET
              porcentaje_avance = (j_def_proyecto_seguimiento_actividad ->> 'porcentaje') :: NUMERIC,
              id_usuario_mod    = p_id_usuario,
              fecha_mod         = now(),
              id_usuario_ai     = v_parametros._id_usuario_ai,
              usuario_ai        = v_parametros._nombre_usuario_ai
            WHERE id_def_proyecto_seguimiento_actividad =
                  (j_def_proyecto_seguimiento_actividad ->> 'id_def_proyecto_seguimiento_actividad') :: INTEGER;

          END LOOP;

          UPDATE sp.tdef_proyecto_seguimiento
          SET
            porcentaje = (SELECT sp.f_calcular_porcentaje_total_seguimiento(v_parametros.id_def_proyecto,
                                                                            v_parametros.id_def_proyecto_seguimiento))
          WHERE id_def_proyecto_seguimiento = v_parametros.id_def_proyecto_seguimiento;
        END IF;


        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                    'Seguimiento de proyectos almacenado(a) con exito (id_def_proyecto_seguimiento' ||
                                    v_id_def_proyecto_seguimiento || ')');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento', v_id_def_proyecto_seguimiento :: VARCHAR);

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
ALTER FUNCTION "sp"."ft_def_proyecto_seguimiento_ime"( INTEGER, INTEGER, CHARACTER VARYING, CHARACTER VARYING )
OWNER TO postgres;
