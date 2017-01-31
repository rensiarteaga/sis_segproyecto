<?php
/**
*@package pXP
*@file gen-ACTActividad.php
*@author  (admin)
*@date 31-01-2017 21:38:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTActividad extends ACTbase{    
			
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
				
	function insertarActividad(){
		$this->objFunc=$this->create('MODActividad');	
		if($this->objParam->insertar('id_actividad')){
			$this->res=$this->objFunc->insertarActividad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarActividad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarActividad(){
			$this->objFunc=$this->create('MODActividad');	
		$this->res=$this->objFunc->eliminarActividad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>