--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sp.ft_def_proyecto_actividad_ime(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
$body$
/**************************************************************************
 SISTEMA:		Seguimiento de Proyectos
 FUNCION: 		sp.ft_def_proyecto_actividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sp.tdef_proyecto_actividad'
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

  v_nro_requerimiento         INTEGER;
  v_parametros                RECORD;
  v_id_requerimiento          INTEGER;
  v_resp                      VARCHAR;
  v_nombre_funcion            TEXT;
  v_mensaje_error             TEXT;
  v_id_def_proyecto_actividad INTEGER;

  va_id_actividades           VARCHAR [];
  v_id_actividad              VARCHAR;
  v_consulta                  VARCHAR;
  v_cantidad_Actividad_Seg    INTEGER;


BEGIN

  v_nombre_funcion = 'sp.ft_def_proyecto_actividad_ime';
  v_parametros = pxp.f_get_record(p_tabla);
  RAISE NOTICE 'llega %', v_nombre_funcion;
  /*********************************
   #TRANSACCION:  'SP_DEPRAC_INS'
   #DESCRIPCION:	Insercion de registros
   #AUTOR:		admin
   #FECHA:		10-11-2016 06:41:48
  ***********************************/

  IF (p_transaccion = 'SP_DEPRAC_INS')
  THEN

    BEGIN
      --Sentencia de la insercion
      INSERT INTO sp.tdef_proyecto_actividad (
        id_def_proyecto,
        id_actividad,
        estado_reg,
        descripcion,
        usuario_ai,
        fecha_reg,
        id_usuario_reg,
        id_usuario_ai,
        fecha_mod,
        id_usuario_mod
      ) VALUES (
        v_parametros.id_def_proyecto,
        v_parametros.id_actividad,
        'activo',
        v_parametros.descripcion,
        v_parametros._nombre_usuario_ai,
        now(),
        p_id_usuario,
        v_parametros._id_usuario_ai,
        NULL,
        NULL

      )
      RETURNING id_def_proyecto_actividad
        INTO v_id_def_proyecto_actividad;

      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje',
                                  'DefinicionProyectoActividad almacenado(a) con exito (id_def_proyecto_actividad' ||
                                  v_id_def_proyecto_actividad || ')');
      v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad', v_id_def_proyecto_actividad :: VARCHAR);

      --Devuelve la respuesta
      RETURN v_resp;

    END;

    /*********************************
     #TRANSACCION:  'SP_DEPRAC_MOD'
     #DESCRIPCION:	Modificacion de registros
     #AUTOR:		admin
     #FECHA:		10-11-2016 06:41:48
    ***********************************/

  ELSIF (p_transaccion = 'SP_DEPRAC_MOD')
    THEN

      BEGIN
        --Sentencia de la modificacion
        UPDATE sp.tdef_proyecto_actividad
        SET
          id_def_proyecto = v_parametros.id_def_proyecto,
          id_actividad    = v_parametros.id_actividad,
          descripcion     = v_parametros.descripcion,
          fecha_mod       = now(),
          id_usuario_mod  = p_id_usuario,
          id_usuario_ai   = v_parametros._id_usuario_ai,
          usuario_ai      = v_parametros._nombre_usuario_ai
        WHERE id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'DefinicionProyectoActividad modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad',
                                    v_parametros.id_def_proyecto_actividad :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

      /*********************************
       #TRANSACCION:  'SP_DEPRAC_ELI'
       #DESCRIPCION:	Eliminacion de registros
       #AUTOR:		admin
       #FECHA:		10-11-2016 06:41:48
      ***********************************/

  ELSIF (p_transaccion = 'SP_DEPRAC_ELI')
    THEN

      BEGIN
        --Sentencia de la eliminacion
        v_cantidad_Actividad_Seg = (SELECT count(*)
                                    FROM sp.tdef_proyecto_seguimiento_actividad
                                    WHERE
                                      id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad);
        IF (v_cantidad_Actividad_Seg > 0)
        THEN
          RAISE NOTICE '%', v_cantidad_Actividad_Seg;
          RAISE EXCEPTION 'No se puede ELIMINAR, usted tiene seguimientos registrados con esta actividad.';
        ELSE
          DELETE FROM sp.tdef_proyecto_actividad
          WHERE id_def_proyecto_actividad = v_parametros.id_def_proyecto_actividad;

          --Definicion de la respuesta
          v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'DefinicionProyectoActividad eliminado(a)');
          v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad',
                                      v_parametros.id_def_proyecto_actividad :: VARCHAR);
        END IF;
        --Devuelve la respuesta
        RETURN v_resp;

      END;

      /*********************************
#TRANSACCION:  'SP_DEPRACS_INS'
#DESCRIPCION:	insertar varias actividades aun definicion proyecto
#AUTOR:		yac
#FECHA:		03-03-2017 09:41:48
***********************************/

  ELSIF (p_transaccion = 'SP_DEPRACS_INS')
    THEN

      BEGIN


        va_id_actividades := string_to_array(v_parametros.id_actividades, ',');


        FOREACH v_id_actividad IN ARRAY va_id_actividades
        LOOP

          IF exists(SELECT 1
                    FROM sp.tdef_proyecto_actividad
                    WHERE id_actividad = v_id_actividad::INTEGER AND id_def_proyecto = v_parametros.id_def_proyecto)
          THEN
            RAISE NOTICE 'tiene actividades repetidas, que quiere insertar';

          ELSE
            --Sentencia de la insercion
            INSERT INTO sp.tdef_proyecto_actividad (
              id_def_proyecto,
              id_actividad,
              estado_reg,
              descripcion,
              usuario_ai,
              fecha_reg,
              id_usuario_reg,
              id_usuario_ai,
              fecha_mod,
              id_usuario_mod
            ) VALUES (
              v_parametros.id_def_proyecto,
              v_id_actividad :: INTEGER,
              'activo',
              '',
              v_parametros._nombre_usuario_ai,
              now(),
              p_id_usuario,
              v_parametros._id_usuario_ai,
              NULL,
              NULL
            )
            RETURNING id_def_proyecto_actividad
              INTO v_id_def_proyecto_actividad;

          END IF;
        END LOOP;


        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'DefinicionProyectoActividad eliminado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_def_proyecto_actividad', v_id_def_proyecto_actividad :: VARCHAR);
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