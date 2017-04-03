--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_seguimiento_total_ime(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_seguimiento_total_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_seguimiento_total'
 AUTOR: 		 (admin)
 FECHA:	        13-11-2016 20:28:07
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

  v_nro_requerimiento                    INTEGER;
  v_parametros                           RECORD;
  v_id_requerimiento                     INTEGER;
  v_resp                                 VARCHAR;
  v_nombre_funcion                       TEXT;
  v_mensaje_error                        TEXT;
  v_id_def_proyecto_seguimiento_total    INTEGER;

  j_def_proyecto_seguimiento_actividad   JSON;
  j_proyecto_seguimiento_actividad       JSON;
  v_id_proy_seguimiento_actividad_estado INTEGER;

BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_seguimiento_total_ime';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SP_PRSETO_INS'
   #DESCRIPCION:	Insercion de registros
   #AUTOR:		admin
   #FECHA:		13-11-2016 20:28:07
  ***********************************/

  IF (p_transaccion = 'SP_PRSETO_INS')
  THEN

    BEGIN

      IF (v_parametros.tipo_form = 'new')
      THEN
        --Sentencia de la insercion
        INSERT INTO sp.tdef_proyecto_seguimiento_total (
          id_def_proyecto,
          estado_reg,
          descripcion,
          fecha,
          id_usuario_reg,
          fecha_reg,
          usuario_ai,
          id_usuario_ai,
          fecha_mod,
          id_usuario_mod
        ) VALUES (
          v_parametros.id_def_proyecto,
          'activo',
          v_parametros.descripcion,
          v_parametros.fecha,
          p_id_usuario,
          now(),
          v_parametros._nombre_usuario_ai,
          v_parametros._id_usuario_ai,
          NULL,
          NULL


        )
        RETURNING id_def_proyecto_seguimiento_total
          INTO v_id_def_proyecto_seguimiento_total;

        --INICIO INSERTADOO PROYECTO SEGUIMIENTO ACTIVAIDAD ESTADO
        j_proyecto_seguimiento_actividad := v_parametros.json_new_records;

        FOR j_def_proyecto_seguimiento_actividad IN SELECT *
                                                    FROM json_array_elements(j_proyecto_seguimiento_actividad)
        LOOP

          INSERT INTO sp.tproy_seguimiento_actividad_estado (
            id_estado_seguimiento,
            id_def_proyecto_seguimiento_total,
            id_proyecto_actividad,
            estado_reg,
            id_usuario_reg,
            usuario_ai,
            fecha_reg,
            id_usuario_ai,
            id_usuario_mod,
            fecha_mod
          ) VALUES (
            --v_parametros.id_estado_seguimiento,
            (j_def_proyecto_seguimiento_actividad ->> 'id_estado_seguimiento') :: INTEGER,
            v_id_def_proyecto_seguimiento_total,
            --v_parametros.v_id_def_proyecto_actividad,
            (j_def_proyecto_seguimiento_actividad ->> 'v_id_def_proyecto_actividad') :: INTEGER,
            'activo',
            p_id_usuario,
            v_parametros._nombre_usuario_ai,
            now(),
            v_parametros._id_usuario_ai,
            NULL,
            NULL

          )
          RETURNING id_proy_seguimiento_actividad_estado
            INTO v_id_proy_seguimiento_actividad_estado;

        END LOOP;
        --FIN INSERTADO PROYECTO SEGUIMINETO ACTIVIDAD ESTADO

      ELSE
        BEGIN
          --Sentencia de la modificacion
          UPDATE sp.tdef_proyecto_seguimiento_total
          SET
            id_def_proyecto = v_parametros.id_def_proyecto,
            descripcion     = v_parametros.descripcion,
            fecha           = v_parametros.fecha,
            fecha_mod       = now(),
            id_usuario_mod  = p_id_usuario,
            id_usuario_ai   = v_parametros._id_usuario_ai,
            usuario_ai      = v_parametros._nombre_usuario_ai
          WHERE id_def_proyecto_seguimiento_total = v_parametros.id_def_proyecto_seguimiento_total;

          --INICIO EDITADO PROYECTO SEGUIMIENTO ACTIVAIDAD ESTADO
          j_proyecto_seguimiento_actividad := v_parametros.json_new_records;

          FOR j_def_proyecto_seguimiento_actividad IN SELECT *
                                                      FROM json_array_elements(j_proyecto_seguimiento_actividad)
          LOOP

            UPDATE sp.tproy_seguimiento_actividad_estado
            SET
              id_estado_seguimiento             = (j_def_proyecto_seguimiento_actividad ->>
                                                   'id_estado_seguimiento') :: INTEGER,
              id_def_proyecto_seguimiento_total = v_parametros.id_def_proyecto_seguimiento_total,
              id_proyecto_actividad             = (j_def_proyecto_seguimiento_actividad ->>
                                                   'v_id_def_proyecto_actividad') :: INTEGER,
              id_usuario_mod                    = p_id_usuario,
              fecha_mod                         = now(),
              id_usuario_ai                     = v_parametros._id_usuario_ai,
              usuario_ai                        = v_parametros._nombre_usuario_ai
            WHERE id_proy_seguimiento_actividad_estado =
                  (j_def_proyecto_seguimiento_actividad ->> 'id_proy_seguimiento_actividad_estado') :: INTEGER;


          END LOOP;
          --FIN EDITADO PROYECTO SEGUIMINETO ACTIVIDAD ESTADO
        END;
      END IF;
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                  'Proyecto seguimineto total  almacenado(a) con exito (id_def_proyecto_seguimiento_total'
                                  || v_id_def_proyecto_seguimiento_total || ')');
      v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento_total',
                                  v_id_def_proyecto_seguimiento_total :: VARCHAR);

      --Devuelve la respuesta
      RETURN v_resp;

    END;

    /*********************************
     #TRANSACCION:  'SP_PRSETO_MOD'
     #DESCRIPCION:	Modificacion de registros
     #AUTOR:		admin
     #FECHA:		13-11-2016 20:28:07
    ***********************************/

  ELSIF (p_transaccion = 'SP_PRSETO_MOD')
    THEN

      BEGIN
        --Sentencia de la modificacion
        UPDATE sp.tdef_proyecto_seguimiento_total
        SET
          id_def_proyecto = v_parametros.id_def_proyecto,
          descripcion     = v_parametros.descripcion,
          fecha           = v_parametros.fecha,
          fecha_mod       = now(),
          id_usuario_mod  = p_id_usuario,
          id_usuario_ai   = v_parametros._id_usuario_ai,
          usuario_ai      = v_parametros._nombre_usuario_ai
        WHERE id_def_proyecto_seguimiento_total = v_parametros.id_def_proyecto_seguimiento_total;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Proyecto seguimineto total  modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento_total',
                                    v_parametros.id_def_proyecto_seguimiento_total :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

      /*********************************
       #TRANSACCION:  'SP_PRSETO_ELI'
       #DESCRIPCION:	Eliminacion de registros
       #AUTOR:		admin
       #FECHA:		13-11-2016 20:28:07
      ***********************************/

  ELSIF (p_transaccion = 'SP_PRSETO_ELI')
    THEN

      BEGIN
        --Sentencia de la eliminacion
        DELETE FROM sp.tdef_proyecto_seguimiento_total
        WHERE id_def_proyecto_seguimiento_total = v_parametros.id_def_proyecto_seguimiento_total;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Proyecto seguimineto total  eliminado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_seguimiento_total',
                                    v_parametros.id_def_proyecto_seguimiento_total :: VARCHAR);

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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;