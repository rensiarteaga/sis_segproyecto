<?php
/**
*@package pXP
*@file gen-ACTDefProyecto.php
*@author  (admin)
*@date 08-02-2017 19:56:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDefProyecto extends ACTbase{    
			
	function listarDefProyecto(){
		$this->objParam->defecto('ordenacion','id_def_proyecto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDefProyecto','listarDefProyecto');
		} else{
			$this->objFunc=$this->create('MODDefProyecto');
			
			$this->res=$this->objFunc->listarDefProyecto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDefProyecto(){
		$this->objFunc=$this->create('MODDefProyecto');	
		if($this->objParam->insertar('id_def_proyecto')){
			$this->res=$this->objFunc->insertarDefProyecto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDefProyecto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDefProyecto(){
			$this->objFunc=$this->create('MODDefProyecto');	
		$this->res=$this->objFunc->eliminarDefProyecto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarProyectos(){
			$this->objParam->defecto('ordenacion','idproyecto');
	
			$this->objParam->defecto('dir_ordenacion','asc');

			$this->objFunc=$this->create('MODDefProyecto');	
			$this->res=$this->objFunc->listarProyecto();
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
	
			
}

?>