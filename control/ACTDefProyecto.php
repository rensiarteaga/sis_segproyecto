<?php
/**
 * @package pXP
 * @file gen-ACTDefProyecto.php
 * @author  (admin)
 * @date 08-02-2017 19:56:10
 * @description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */
require_once(dirname(__FILE__) . '/../reportes/REjecucionPorPartida.php');

class ACTDefProyecto extends ACTbase
{

    function listarDefProyecto()
    {
        $this->objParam->defecto('ordenacion', 'id_def_proyecto');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODDefProyecto', 'listarDefProyecto');
        } else {
            $this->objFunc = $this->create('MODDefProyecto');

            $this->res = $this->objFunc->listarDefProyecto($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarDefProyecto()
    {
        $this->objFunc = $this->create('MODDefProyecto');
        if ($this->objParam->insertar('id_def_proyecto')) {
            $this->res = $this->objFunc->insertarDefProyecto($this->objParam);
        } else {
            $this->res = $this->objFunc->modificarDefProyecto($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarDefProyecto()
    {
        $this->objFunc = $this->create('MODDefProyecto');
        $this->res = $this->objFunc->eliminarDefProyecto($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarProyectos()
    {
        $this->objParam->defecto('ordenacion', 'idproyecto');

        $this->objParam->defecto('dir_ordenacion', 'asc');

        $this->objFunc = $this->create('MODDefProyecto');
        $this->res = $this->objFunc->listarProyecto();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }


    function recuperarReporteResumen()
    {
        $this->objFunc = $this->create('MODDefProyecto');
        $cbteHeader = $this->objFunc->listarReporteResumen($this->objParam);

        if ($cbteHeader->getTipo() == 'EXITO') {
            return $cbteHeader;
        } else {
            $cbteHeader->imprimirRespuesta($cbteHeader->generarJson());
            exit;
        }

    }

    function reporteResumenProyecto()
    {

         $nombreArchivo = 'EjecucionPorPartida' . uniqid(md5(session_id())) . '.pdf';


        $dataSource = $this->recuperarReporteResumen();

        //parametros basicos
        $tamano = 'LETTER';
        $orientacion = 'L';
        $titulo = 'Consolidado';

        $this->objParam->addParametro('orientacion', $orientacion);
        $this->objParam->addParametro('tamano', $tamano);
        $this->objParam->addParametro('titulo_archivo', $titulo);
        $this->objParam->addParametro('nombre_archivo', $nombreArchivo);
        $reporte = new REjecucionPorPartida($this->objParam);
        $reporte->datosHeader($dataSource->getDatos());
        $reporte->generarReporte();
        $reporte->output($reporte->url_archivo, 'F');

        $this->mensajeExito = new Mensaje();
        $this->mensajeExito->setMensaje('EXITO', 'Reporte.php', 'Reporte generado', 'Se generó con éxito el reporte: ' . $nombreArchivo, 'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());

    }
}

?>