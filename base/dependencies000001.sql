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

/***********************************I-DEP-RAC-SP-0-01/03/2017*****************************************/
--------------- SQL ---------------

ALTER TABLE sp.tdef_proyecto_actividad
  ADD CONSTRAINT tdef_proyecto_actividad_fk FOREIGN KEY (id_def_proyecto)
    REFERENCES sp.tdef_proyecto(id_def_proyecto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

    --------------- SQL ---------------

ALTER TABLE sp.tdef_proyecto_actividad
  ADD CONSTRAINT tdef_proyecto_actividad_fk1 FOREIGN KEY (id_actividad)
    REFERENCES sp.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


/***********************************F-DEP-RAC-SP-0-01/03/2017*****************************************/


