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

/********************************************I-DAT-YAC-SP-0-21/02/2017********************************************/

--------------- SQL ---------------

CREATE TABLE sp.tdef_proyecto (
  id_def_proyecto SERIAL NOT NULL,
  id_proyecto INTEGER,
  fecha_inicio_teorico DATE,
  fecha_fin_teorico DATE,
  descripcion TEXT,
  PRIMARY KEY(id_def_proyecto)
) INHERITS (pxp.tbase)

WITH (oids = false);

/********************************************F-DAT-YAC-SP-0-21/02/2017********************************************/
