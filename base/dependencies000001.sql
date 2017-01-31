/***********************************I-DEP-RAC-SEGDOC-0-01/02/2017*****************************************/
----------------------------------
--COPY LINES TO dependencies.sql FILE  
---------------------------------


select pxp.f_insert_testructura_gui ('SEP', 'SISTEMA');

--------------- SQL ---------------

ALTER TABLE sp.tactividad
  ADD CONSTRAINT tactividad__id_actividad_fk FOREIGN KEY (id_actividad_padre)
    REFERENCES sp.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/***********************************F-DEP-RAC-SEGDOC-0-01/02/2017*****************************************/


