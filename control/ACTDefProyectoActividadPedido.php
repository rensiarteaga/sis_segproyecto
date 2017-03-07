<?php
/**
*@package pXP
*@file gen-ACTDefProyectoActividadPedido.php
*@author  (admin)
*@date 12-11-2016 12:56:05
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDefProyectoActividadPedido extends ACTbase{    
			
	function listarDefProyectoActividadPedido(){
		$this->objParam->defecto('ordenacion','id_def_proyecto_actividad_pedido');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if ($this->objParam->getParametro('id_def_proyecto_actividad')){
            $this->objParam->addFiltro("id_def_proyecto_actividad = ".$this->objParam->getParametro('id_def_proyecto_actividad'));
        }else{
            $this->objParam->addFiltro("id_def_proyecto_actividad = 0");
        }
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDefProyectoActividadPedido','listarDefProyectoActividadPedido');
		} else{
			$this->objFunc=$this->create('MODDefProyectoActividadPedido');
			
			$this->res=$this->objFunc->listarDefProyectoActividadPedido($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDefProyectoActividadPedido(){
		$this->objFunc=$this->create('MODDefProyectoActividadPedido');	
		if($this->objParam->insertar('id_def_proyecto_actividad_pedido')){
			$this->res=$this->objFunc->insertarDefProyectoActividadPedido($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDefProyectoActividadPedido($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDefProyectoActividadPedido(){
			$this->objFunc=$this->create('MODDefProyectoActividadPedido');	
		$this->res=$this->objFunc->eliminarDefProyectoActividadPedido($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarPedidos(){
			$this->objParam->defecto('ordenacion','nrosap');
	
			$this->objParam->defecto('dir_ordenacion','asc');
			$this->objFunc=$this->create('MODDefProyectoActividadPedido');
			$this->res=$this->objFunc->listarPedidos($this->objParam);
			$this->res->imprimirRespuesta($this->res->generarJson());
		}

			
}

?>