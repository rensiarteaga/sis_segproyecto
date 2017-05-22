<?php
/**
*@package pXP
*@file gen-ACTDefProyectoSeguimientoActividad.php
*@author  (admin)
*@date 24-02-2017 05:02:05
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDefProyectoSeguimientoActividad extends ACTbase{    
			
	function listarDefProyectoSeguimientoActividad(){
		$this->objParam->defecto('ordenacion','id_def_proyecto_seguimiento_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDefProyectoSeguimientoActividad','listarDefProyectoSeguimientoActividad');
		} else{
			$this->objFunc=$this->create('MODDefProyectoSeguimientoActividad');
			
			$this->res=$this->objFunc->listarDefProyectoSeguimientoActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDefProyectoSeguimientoActividad(){
		$this->objFunc=$this->create('MODDefProyectoSeguimientoActividad');	
		if($this->objParam->insertar('id_def_proyecto_seguimiento_actividad')){
			$this->res=$this->objFunc->insertarDefProyectoSeguimientoActividad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDefProyectoSeguimientoActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDefProyectoSeguimientoActividad(){
			$this->objFunc=$this->create('MODDefProyectoSeguimientoActividad');	
		$this->res=$this->objFunc->eliminarDefProyectoSeguimientoActividad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>