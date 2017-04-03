/********************************************I-DAT-RAC-SEP-0-15/01/2013********************************************/

/* Data for the 'segu.tsubsistema' table  (Records 1 - 1) */

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES 
  (E'SP', E'Seguimiento de Proyectos', E'2017-02-13', E'SP', E'activo', E'segproyecto', NULL);
  
  ----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');

  
  
/********************************************F-DAT-RAC-SEP-0-15/01/2013********************************************/


/********************************************I-DAT-YAC-SP-0-20/02/2017********************************************/

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
----------------------------------
--COPY LINES TO dependencies.sql FILE  
---------------------------------

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
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Proyecto actividad', 'Proyectos Actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyectoActividad.php', 2, '', 'DefProyectoActividad', 'SP');
select pxp.f_delete_tgui ('PRSECO');
select pxp.f_insert_tgui ('Proyecto seguimiento construcción', 'Proyectos seguimient construcciçon', 'PRSECO', 'si', 0, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoConstruccion.php', 2, '', 'DefProyectoSeguimientoConstruccion', 'SP');
select pxp.f_insert_tgui ('Proyectos seguimiento Totales', 'Proyectos seguimiento Totales', 'PRSETO', 'si', 0, 'sis_segproyecto/vista/def_proyecto/DefProyectoSeguimientoTotal.php', 3, '', 'DefProyectoSeguimientoTotal', 'SP');
select pxp.f_insert_tgui ('Seguimientos proyecto', 'Seguimientos proyecto', 'SEPROPONd', 'si', 6, '', 2, '', '', 'SP');

/********************************************F-DAT-YAC-SP-0-02/04/2017********************************************/





/********************************************I-DAT-YAC-SP-0-17/03/2017********************************************/
/*
CREATE OR REPLACE FUNCTION sp.ft_registro_actividad(actividad_padre VARCHAR, actividades_hijos VARCHAR [])
  RETURNS BOOL AS
$$ DECLARE
  hijo           VARCHAR;
  v_id_actividad INTEGER;
  valor BOOL := FALSE ;
BEGIN

  INSERT INTO sp.tactividad (fecha_reg, actividad, id_actividad_padre)
  VALUES (now()  , actividad_padre, NULL)
  RETURNING id_actividad INTO v_id_actividad;
  FOREACH hijo IN ARRAY (actividades_hijos) LOOP
    INSERT INTO sp.tactividad (fecha_reg, actividad, id_actividad_padre)
    VALUES (now() ,hijo, v_id_actividad);
    valor := true;
  END LOOP;
  return valor;
END; $$ LANGUAGE plpgsql;




-------realizando el registro de las actividades

--SELECT sp.ft_registro_actividad('Ingeniería del proyecto'::VARCHAR,ARRAY['Norma 30','Compra de terreno','Planos aprobados para invitación']);
--SELECT sp.ft_registro_actividad('Suministros subestaciones'::VARCHAR,ARRAY['Porticos','Estructuras soporte','Interruptores','Seccionadores','PT''s CT''s','Pararrayos','Transformador de potencia','Tableros control y protecciones','Telecomunicaciones','Cables de Control y potencia','Otros varios (menores a 50.000 Bs.)']);
--SELECT sp.ft_registro_actividad('Conformación plataforma'::VARCHAR,ARRAY['Instalación faenas','Relevamiento topografico','Limpieza y retiro de capa vegetal (orgánico)','Excavación no clasificada.','Rellenos Compactados','Cerco perimetral de malla olímpica con postes de hormigón de 3.50 metros','Construcción sitemas de drenajes']);
--SELECT sp.ft_registro_actividad('Construcción Sala de Control'::VARCHAR,ARRAY['Instalación faenas','Replanteo y excavaciones','Fundaciones, columnas y vigas','Construcción de Muros','Construcción Techo ','Zanjas sala de control','Conformación del piso de la sala','Instalación carpinteria en sala','Instalaciones sanitarias y electricas','Pintura y acabados sala de control']);
--SELECT sp.ft_registro_actividad('Obras Civiles de Patio'::VARCHAR,ARRAY['Instalación faenas','Replanteo y excavaciones','fundaciones pórtico y equipos','Fundación transformador','Malla de tierra','Zanjas de patio','Fundaciones tableros intermediarios','Fundaciones postes iluminación eterna','Cerco o muro perimetral','Drenajes internos','Cordones de protección','Tendido de grava']);
--SELECT sp.ft_registro_actividad('Montaje electromecanico S/E'::VARCHAR,ARRAY['Instalación faenas','Montaje porticos y soportes equipos','Sistema de barras en alta tension','Sistema de barras rigidas','Montaje interruptores','Montaje seccionadores','Montaje PT''s y CT''s','Montaje otros equipos','Montaje del Transformador','Instalación iluminación de patio','Conexionado cables C&P','Comissioning C&P','Estudios Norma Operativa 8, 11 y 17','Pruebas a equipos de patio y C&P','Puesta en servicio']);
--SELECT sp.ft_registro_actividad('Cierre de proyecto'::VARCHAR,ARRAY['Informe puesta en sevicio','Cierre Contable del proyecto']);
*/
/********************************************F-DAT-YAC-SP-0-17/03/2017********************************************/

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

BEGIN;

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

COMMIT;
/********************************************F-DAT-YAC-SP-0-02/04/2017********************************************/
