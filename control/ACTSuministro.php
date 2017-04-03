<?php
/**
*@package pXP
*@file gen-ACTSuministro.php
*@author  (admin)
*@date 12-11-2016 14:03:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTSuministro extends ACTbase{    
			
	function listarSuministro(){
		$this->objParam->defecto('ordenacion','a.actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		//if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
		//	$this->objReporte = new Reporte($this->objParam,$this);
		//	$this->res = $this->objReporte->generarReporteListado('MODSuministro','listarSuministro');
		//} else{

        if ($this->objParam->getParametro('id_def_proyecto')) {
            $this->objParam->addFiltro("p.id_def_proyecto = " . $this->objParam->getParametro('id_def_proyecto'));
        } else {
            $this->objParam->addFiltro("id_def_proyecto = 0");
        }
			$this->objFunc=$this->create('MODSuministro');
			$this->res=$this->objFunc->listarSuministro($this->objParam);
		//}



		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarSuministro(){
        $this->objFunc=$this->create('MODSuministro');
      //  if($this->objParam->insertar('id_def_proyecto_actividad')){
            //$this->res=$this->objFunc->eliminarSuministro($this->objParam);
            $this->res=$this->objFunc->insertarSuministro($this->objParam);
      //  } else{
       //     $this->res=$this->objFunc->modificarSuministro($this->objParam);
    //    }
        $this->res->imprimirRespuesta($this->res->generarJson());

       // $this->objFunc=$this->create('MODSuministro');
       // if($this->objParam->insertar('id_seguimiento_suministro')){
       //     $this->res=$this->objFunc->insertarSuministro($this->objParam);
       // } else{
       //     $this->res=$this->objFunc->modificarSuministro($this->objParam);
       // }
       // $this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSuministro(){
			$this->objFunc=$this->create('MODSuministro');	
		$this->res=$this->objFunc->eliminarSuministro($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>