<?php
/**
*@package pXP
*@file gen-ACTDefProyectoSeguimiento.php
*@author  (admin)
*@date 24-02-2017 04:16:20
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__) . '/../reportes/ReporteTablaResumenSeguimiento.php');

class ACTDefProyectoSeguimiento extends ACTbase{    
			
	function listarDefProyectoSeguimiento(){
		$this->objParam->defecto('ordenacion','id_def_proyecto_seguimiento');

		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('id_def_proyecto')){
            $this->objParam->addFiltro("id_def_proyecto = ".$this->objParam->getParametro('id_def_proyecto'));
        }else{
            $this->objParam->addFiltro("id_def_proyecto = 0");
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDefProyectoSeguimiento','listarDefProyectoSeguimiento');
		} else{
			$this->objFunc=$this->create('MODDefProyectoSeguimiento');
			
			$this->res=$this->objFunc->listarDefProyectoSeguimiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDefProyectoSeguimiento(){
		$this->objFunc=$this->create('MODDefProyectoSeguimiento');	
		if($this->objParam->insertar('id_def_proyecto_seguimiento')){
			$this->res=$this->objFunc->insertarDefProyectoSeguimiento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDefProyectoSeguimiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDefProyectoSeguimiento(){
		$this->objFunc=$this->create('MODDefProyectoSeguimiento');	
		$this->res=$this->objFunc->eliminarDefProyectoSeguimiento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarActividad(){
		$this->objParam->defecto('ordenacion','id_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('nombreVista')=='ActividadPadre'){
            $this->objParam->addFiltro("id_actividad_padre is null ");    
        }
		if($this->objParam->getParametro('nombreVista')=='ActividadHijo'){
            $this->objParam->addFiltro("id_actividad_padre = ".$this->objParam->getParametro('id_actividad_padre'));    
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODActividad','listarActividad');
		} else{
			$this->objFunc=$this->create('MODActividad');
			
			$this->res=$this->objFunc->listarActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    function insertarFormDefProyectoSeguimiento(){
        $this->objFunc=$this->create('MODDefProyectoSeguimiento');
        $this->res=$this->objFunc->insertarFormDefProyectoSeguimiento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarDefProyectoSeguiminetoTablaPonderacion(){
        $this->objParam->defecto('ordenacion','id_def_proyecto_seguimiento');

        $this->objParam->defecto('dir_ordenacion','asc');


            $this->objFunc=$this->create('MODDefProyectoSeguimiento');

            $this->res=$this->objFunc->listarDefProyectoSeguiminetoTablaPonderacion($this->objParam);

        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function recuperarReporteResumen()
    {
        $this->objFunc = $this->create('MODDefProyectoSeguimiento');
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

        $nombreArchivo = 'Reporte_ponderacion_detallada_' . uniqid(md5(session_id())) . '.pdf';


        $dataSource = $this->recuperarReporteResumen();

        //parametros basicos
        $tamano = 'LETTER';
        $orientacion = 'P';
        $titulo = 'Tabla ponderado';

        $this->objParam->addParametro('orientacion', $orientacion);
        $this->objParam->addParametro('tamano', $tamano);
        $this->objParam->addParametro('titulo_archivo', $titulo);
        $this->objParam->addParametro('nombre_archivo', $nombreArchivo);
        $reporte = new ReporteTablaResumenSeguimiento($this->objParam);
        $reporte->datosHeader($dataSource->getDatos());
        $reporte->generarReporte();
        $reporte->output($reporte->url_archivo, 'F');

        $this->mensajeExito = new Mensaje();
        //dudas sobre el nombre de reporteSeguimiento.php en donde esta en Reporte.php
        $this->mensajeExito->setMensaje('EXITO', 'Reporte.php', 'Reporte generado', 'Se generó con éxito el reporte: ' . $nombreArchivo, 'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());

    }


			
}

?>