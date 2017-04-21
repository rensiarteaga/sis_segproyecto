/********************************************I-DAT-RAC-SP-0-15/01/2013********************************************/

/* Data for the 'segu.tsubsistema' table  (Records 1 - 1) */

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES 
  (E'SP', E'Seguimiento de Proyectos', E'2017-02-13', E'SP', E'activo', E'segproyecto', NULL);
  
  ----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');

  
  
/********************************************F-DAT-RAC-SP-0-15/01/2013********************************************/
/********************************************I-DAT-YAC-SP-0-20/02/2017********************************************/

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');

select pxp.f_insert_testructura_gui ('SP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ACTI', 'SP');

/********************************************F-DAT-YAC-SP-0-20/02/2017********************************************/

/********************************************I-DAT-YAC-SP-0-03/03/2017********************************************/

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Proyecto actividad', 'Proyectos Actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyecto.php', 2, '', 'DefProyecto', 'SP');

/********************************************F-DAT-YAC-SP-0-03/03/2017********************************************/
/********************************************I-DAT-YAC-SP-0-02/04/2017********************************************/

select pxp.f_delete_tgui ('SEP');
select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades' , 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Proyecto actividad', 'Proyectos Actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyectoActividad.php', 2, '', 'DefProyectoActividad', 'SP');
select pxp.f_delete_tgui ('PRSECO');
select pxp.f_insert_tgui ('Proyecto seguimiento construcción', 'Proyectos seguimient construcciçon', 'PRSECO', 'si', 0, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoConstruccion.php', 2, '', 'DefProyectoSeguimientoConstruccion', 'SP');
select pxp.f_insert_tgui ('Proyectos seguimiento Totales', 'Proyectos seguimiento Totales', 'PRSETO', 'si', 0, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoTotal.php', 3, '', 'DefProyectoSeguimientoTotal', 'SP');
select pxp.f_insert_tgui ('Seguimientos proyecto', 'Seguimientos proyecto', 'SEPROPONd', 'si', 6, '', 2, '', '', 'SP');

/********************************************F-DAT-YAC-SP-0-02/04/2017********************************************/
/********************************************I-DAT-YAC-SP-0-20/03/2017********************************************/
/*create or REPLACE FUNCTION sp.ft_cantidad_cadena_caracter(cadena VARCHAR,caracter VARCHAR) RETURNS INTEGER AS
$$
DECLARE
  resultado INTEGER;
BEGIN

  resultado := LENGTH(cadena) - LENGTH(REPLACE(cadena, caracter, ''));

  RETURN resultado;
END;
$$
LANGUAGE 'plpgsql';*/
/********************************************F-DAT-YAC-SP-0-20/03/2017********************************************/
/********************************************I-DAT-YAC-SP-0-02/04/2017********************************************/


/* Data for the 'sp.testado_seguimiento' table  (Records 1 - 23) */

INSERT INTO sp.testado_seguimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_estado_seguimiento", "estado", "id_tipo")
VALUES
  (NULL, NULL, E'2016-11-13 15:24:42.367', E'2016-11-13 15:24:42.367', E'activo', NULL, NULL, 12, E'Pendiente', 2),
  (NULL, NULL, E'2016-11-13 15:24:46.811', E'2016-11-13 15:24:46.811', E'activo', NULL, NULL, 13, E'En elaboración de invitación', 2),
  (NULL, NULL, E'2016-11-13 15:24:51.781', E'2016-11-13 15:24:51.781', E'activo', NULL, NULL, 14, E'(1) Licitación/Recepción de ofertas', 2),
  (NULL, NULL, E'2016-11-13 15:24:56.581', E'2016-11-13 15:24:56.581', E'activo', NULL, NULL, 15, E'(2) Calificación', 2),
  (NULL, NULL, E'2016-11-13 15:25:03.236', E'2016-11-13 15:25:03.236', E'activo', NULL, NULL, 16, E'(3) Elaboración de firma de contrato', 2),
  (NULL, NULL, E'2016-11-13 15:25:08.357', E'2016-11-13 15:25:08.357', E'activo', NULL, NULL, 17, E'(4) Elaboración de orden de compra/servicio', 2),
  (NULL, NULL, E'2016-11-13 15:25:12.516', E'2016-11-13 15:25:12.516', E'activo', NULL, NULL, 18, E'En fabricación', 2),
  (NULL, NULL, E'2016-11-13 15:25:17.372', E'2016-11-13 15:25:17.372', E'activo', NULL, NULL, 19, E'En tránsito', 2),
  (NULL, NULL, E'2016-11-13 15:25:23.435', E'2016-11-13 15:25:23.435', E'activo', NULL, NULL, 20, E'En aduana', 2),
  (NULL, NULL, E'2016-11-13 15:25:27.644', E'2016-11-13 15:25:27.644', E'activo', NULL, NULL, 21, E'Recibido en almacén', 2),
  (NULL, NULL, E'2016-11-13 15:25:32.669', E'2016-11-13 15:25:32.669', E'activo', NULL, NULL, 22, E'Recepción provisional', 2),
  (NULL, NULL, E'2016-11-13 15:25:36.876', E'2016-11-13 15:25:36.876', E'activo', NULL, NULL, 23, E'Recepción definitiva', 2),
  (NULL, NULL, E'2016-11-13 15:13:57.136', E'2016-11-13 15:13:57.136', E'activo', NULL, NULL, 1, E'Pendiente', 3),
  (NULL, NULL, E'2016-11-13 15:16:05.972', E'2016-11-13 15:16:05.972', E'activo', NULL, NULL, 2, E'Suspensión de obra', 3),
  (NULL, NULL, E'2016-11-13 15:16:10.077', E'2016-11-13 15:16:10.077', E'activo', NULL, NULL, 3, E'En elaboración de invitación', 3),
  (NULL, NULL, E'2016-11-13 15:16:14.301', E'2016-11-13 15:16:14.301', E'activo', NULL, NULL, 4, E'Proceso de licitación', 3),
  (NULL, NULL, E'2016-11-13 15:16:46.932', E'2016-11-13 15:16:46.932', E'activo', NULL, NULL, 5, E'En recepción de ofertas', 3),
  (NULL, NULL, E'2016-11-13 15:16:50.420', E'2016-11-13 15:16:50.420', E'activo', NULL, NULL, 6, E'Calificación', 3),
  (NULL, NULL, E'2016-11-13 15:16:54.311', E'2016-11-13 15:16:54.311', E'activo', NULL, NULL, 7, E'Proceso de elaboración y firma de contrato', 3),
  (NULL, NULL, E'2016-11-13 15:16:57.755', E'2016-11-13 15:16:57.755', E'activo', NULL, NULL, 8, E'En ejecución', 3),
  (NULL, NULL, E'2016-11-13 15:17:01.868', E'2016-11-13 15:17:01.868', E'activo', NULL, NULL, 9, E'Servicio/Obra concluida', 3),
  (NULL, NULL, E'2016-11-13 15:17:05.715', E'2016-11-13 15:17:05.715', E'activo', NULL, NULL, 10, E'Recepción provisional', 3),
  (NULL, NULL, E'2016-11-13 15:17:09.539', E'2016-11-13 15:17:09.539', E'activo', NULL, NULL, 11, E'Recepción definitiva', 3);

/********************************************F-DAT-YAC-SP-0-02/04/2017********************************************/
/********************************************I-DAT-YAC-SP-1-02/04/2017********************************************/

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Proyecto actividad', 'Proyectos Actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyectoActividad.php', 2, '', 'DefProyectoActividad', 'SP');
select pxp.f_insert_tgui ('Proyecto seguimiento construcción', 'Proyectos seguimient construcciçon', 'PRSECO', 'si', 6, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoConstruccion.php', 2, '', 'DefProyectoSeguimientoConstruccion', 'SP');
select pxp.f_insert_tgui ('Proyectos seguimiento Totales', 'Proyectos seguimiento Totales', 'PRSETO', 'si', 7, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoTotal.php', 3, '', 'DefProyectoSeguimientoTotal', 'SP');
select pxp.f_insert_tgui ('Parametrización', 'Parametrización de las actividades', 'SEPROPONd', 'si', 1, '', 2, '', '', 'SP');

/********************************************F-DAT-YAC-SP-1-02/04/2017********************************************/
/********************************************I-DAT-YAC-SP-0-04/04/2017********************************************/
INSERT INTO sp.ttipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_tipo", "tipo")
VALUES
  (NULL, NULL, E'2017-03-27 10:23:16', E'2017-03-27 10:23:16', E'activo', NULL, NULL, 2, E'Suministro'),
  (NULL, NULL, E'2017-03-28 11:58:07', E'2017-03-28 11:58:07', E'activo', NULL, NULL, 4, E'Cierre'),
  (NULL, NULL, E'2017-03-27 10:22:25', E'2017-03-27 10:22:25', E'activo', NULL, NULL, 1, E'Ingenieria'),
  (NULL, NULL, E'1899-12-30 00:00:00', E'1899-12-30 00:00:00', E'', NULL, NULL, 3, E'Construccion / Obra');

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Proyecto actividad', 'Proyectos Actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyectoActividad.php', 2, '', 'DefProyectoActividad', 'SP');
select pxp.f_insert_tgui ('Proyecto seguimiento construcción', 'Proyectos seguimient construcciçon', 'PRSECO', 'si', 6, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoConstruccion.php', 2, '', 'DefProyectoSeguimientoConstruccion', 'SP');
select pxp.f_insert_tgui ('Proyectos seguimiento Totales', 'Proyectos seguimiento Totales', 'PRSETO', 'si', 7, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoTotal.php', 3, '', 'DefProyectoSeguimientoTotal', 'SP');
select pxp.f_insert_tgui ('Parametrización', 'Parametrización de las actividades', 'SEPROPONd', 'si', 1, '', 2, '', '', 'SP');

/********************************************F-DAT-YAC-SP-0-04/04/2017********************************************/
/********************************************I-DAT-YAC-SP-0-05/04/2017********************************************/
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Definición seguimiento', 'Definición de los proyectos actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyectoActividad.php', 2, '', 'DefProyectoActividad', 'SP');
select pxp.f_insert_tgui ('Seguimiento operativo', 'Proyectos seguimientos operativos', 'PRSECO', 'si', 6, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoConstruccion.php', 2, '', 'DefProyectoSeguimientoConstruccion', 'SP');
select pxp.f_insert_tgui ('Seguimiento estratégico', 'Proyectos seguimientos Estrategicos', 'PRSETO', 'si', 7, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoTotal.php', 3, '', 'DefProyectoSeguimientoTotal', 'SP');
select pxp.f_insert_tgui ('Parametrización', 'Parametrización de las actividades', 'SEPROPONd', 'si', 1, '', 2, '', '', 'SP');

/********************************************F-DAT-YAC-SP-0-05/04/2017********************************************/
