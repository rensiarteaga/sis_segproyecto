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
        if ($this->objParam->getParametro('id_def_proyecto')) {
            $this->objParam->addFiltro("id_def_proyecto = " . $this->objParam->getParametro('id_def_proyecto'));
        } else {
            $this->objParam->addFiltro("id_def_proyecto = 0");
        }

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
        if ($this->objParam->getParametro('id_def_proyecto')) {
            $this->objParam->addFiltro("id_def_proyecto = " . $this->objParam->getParametro('id_def_proyecto'));
        } else {
            $this->objParam->addFiltro("id_def_proyecto = 0");
        }
        $this->objFunc = $this->create('MODDefProyectoActividad');
        $this->res = $this->objFunc->listarProyectoSeguimientoActividad($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>