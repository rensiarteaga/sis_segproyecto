/********************************************I-DAT-RAC-SEP-0-15/01/2013********************************************/

/* Data for the 'segu.tsubsistema' table  (Records 1 - 1) */

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES 
  (E'SEP', E'Seguimiento de Proyectos', E'2017-02-13', E'SEP', E'activo', E'segproyecto', NULL);
  
  ----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SEP', 'si', 1, '', 1, '', '', 'SEP');

  
  
/********************************************F-DAT-RAC-SEP-0-15/01/2013********************************************/

