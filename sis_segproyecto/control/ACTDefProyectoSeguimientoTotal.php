<?php
/**
*@package pXP
*@file gen-ACTDefProyectoSeguimientoTotal.php
*@author  (admin)
*@date 13-11-2016 20:28:07
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDefProyectoSeguimientoTotal extends ACTbase{    
			
	function listarDefProyectoSeguimientoTotal(){
		$this->objParam->defecto('ordenacion','id_def_proyecto_seguimiento_total');

		$this->objParam->defecto('dir_ordenacion','asc');
		if ($this->objParam->getParametro('id_def_proyecto')){
            $this->objParam->addFiltro("id_def_proyecto = ".$this->objParam->getParametro('id_def_proyecto'));
        }else{
            $this->objParam->addFiltro("id_def_proyecto = 0");
        }
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODDefProyectoSeguimientoTotal','listarDefProyectoSeguimientoTotal');
		} else{
			$this->objFunc=$this->create('MODDefProyectoSeguimientoTotal');
			
			$this->res=$this->objFunc->listarDefProyectoSeguimientoTotal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarDefProyectoSeguimientoTotal(){
		$this->objFunc=$this->create('MODDefProyectoSeguimientoTotal');	
		if($this->objParam->insertar('id_def_proyecto_seguimiento_total')){
			$this->res=$this->objFunc->insertarDefProyectoSeguimientoTotal($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarDefProyectoSeguimientoTotal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDefProyectoSeguimientoTotal(){
			$this->objFunc=$this->create('MODDefProyectoSeguimientoTotal');	
		$this->res=$this->objFunc->eliminarDefProyectoSeguimientoTotal($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    function listarEstadosSeguimiento()
    {
        $this->objParam->defecto('ordenacion', 'id_estado_seguimiento');

        $this->objParam->defecto('dir_ordenacion', 'asc');

        if ($this->objParam->getParametro('id_tipo')){
            $this->objParam->addFiltro("es.id_tipo = ".$this->objParam->getParametro('id_tipo'));
        }else{
            $this->objParam->addFiltro("es.id_tipo = 0");
        }

        $this->objFunc = $this->create('MODDefProyectoSeguimientoTotal');
        $this->res = $this->objFunc->listarEstadosSeguimiento();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
	function insertarFormEstado(){
        $this->objFunc=$this->create('MODDefProyectoSeguimientoTotal');
        $this->res=$this->objFunc->insertarFormEstado($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
			
}

?>