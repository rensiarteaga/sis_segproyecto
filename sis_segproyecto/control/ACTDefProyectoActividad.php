<?php

/**
 * @package pXP
 * @file ACTDefProyectoActividad.php
 * @author  (admin)
 * @date 10-11-2016 06:39:27
 * @description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */
class ACTDefProyectoActividad extends ACTbase
{

    function listarDefProyectoActividad()
    {
        $this->objParam->defecto('ordenacion', 'id_def_proyecto_actividad');

        $this->objParam->defecto('dir_ordenacion', 'asc');

        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODDefProyectoActividad', 'listarDefProyectoActividad');
        } else {
            $this->objFunc = $this->create('MODDefProyectoActividad');

            $this->res = $this->objFunc->listarDefProyectoActividad($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarDefProyectoActividad()
    {
        $this->objFunc = $this->create('MODDefProyectoActividad');
        if ($this->objParam->insertar('id_def_proyecto_actividad')) {
            $this->res = $this->objFunc->insertarDefProyectoActividad($this->objParam);
        } else {
            $this->res = $this->objFunc->modificarDefProyectoActividad($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarDefProyectoActividad()
    {
        $this->objFunc = $this->create('MODDefProyectoActividad');
        $this->res = $this->objFunc->eliminarDefProyectoActividad($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarDefinicionProyectosActividades()
    {
        $this->objFunc = $this->create('MODDefProyectoActividad');
        $this->res = $this->objFunc->insertarDefinicionProyectosActividades($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarProyectoSeguimientoActividad()
    {
        $this->objParam->defecto('ordenacion', 'id_def_proyecto_actividad');
        $this->objParam->defecto('dir_ordenacion', 'asc');
        //si es la actividades de tipo construccion o ingenieria
        $this->objParam->addFiltro(" (tad.id_tipo=1 OR id_tipo=3 or id_tipo=4 ) ");
        $this->objFunc = $this->create('MODDefProyectoActividad');

        $this->res = $this->objFunc->listarProyectoSeguimientoActividad($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarProyectoSeguimientoActividadEditar()
    {
        $this->objParam->defecto('ordenacion', 'id_def_proyecto_actividad');
        $this->objParam->defecto('dir_ordenacion', 'asc');

        if ($this->objParam->getParametro('id_def_proyecto_seguimiento')) {
            $this->objParam->addFiltro("tpsa.id_def_proyecto_seguimiento = " . $this->objParam->getParametro('id_def_proyecto_seguimiento'));
        }else{
            $this->objParam->addFiltro("tpsa.id_def_proyecto_seguimiento = 0");
        }

        $this->objFunc = $this->create('MODDefProyectoActividad');
        $this->res = $this->objFunc->listarProyectoSeguimientoActividadEditar($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function listarProyectoSeguimientoActividadTotal()
    {
        $this->objParam->defecto('ordenacion', 'v_id_def_proyecto_actividad');
        $this->objParam->defecto('dir_ordenacion', 'asc');

        //$this->objParam->addFiltro("id_def_proyecto = " . $this->objParam->getParametro('id_def_proyecto'));


        $this->objFunc = $this->create('MODDefProyectoActividad');
        $this->res = $this->objFunc->listarProyectoSeguimientoActividadTotal($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function listarProyectoSeguimientoActividadTotalEditar()
    {
        $this->objParam->defecto('ordenacion', 'v_id_def_proyecto_actividad');
        $this->objParam->defecto('dir_ordenacion', 'asc');

        //$this->objParam->addFiltro("id_def_proyecto = " . $this->objParam->getParametro('id_def_proyecto'));




        $this->objFunc = $this->create('MODDefProyectoActividad');
        $this->res = $this->objFunc->listarProyectoSeguimientoActividadTotalEditar($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>