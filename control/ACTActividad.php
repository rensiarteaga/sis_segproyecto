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
		$this->objParam->defecto('ordenacion','acti.tipo_actividad');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('nombreVista')=='ActividadPadre'){
            $this->objParam->addFiltro("id_actividad_padre is null ");    
        }
		if($this->objParam->getParametro('nombreVista')=='ActividadHijo' or $this->objParam->getParametro('nombreVista')=='ActividadNieto'){
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
function listarActividadArb() {
        $node = $this->objParam->getParametro('node');
		//$clasificacion = $this->objParam->getParametro('clasificacion');								
        $id_actividad = $this->objParam->getParametro('id_actividad');

        if ($node == 'id') {
            $this->objParam->addParametro('id_padre', '%');
        } else {
            $this->objParam->addParametro('id_padre', $id_actividad);
        }
		//$this->objParam->addParametro('clasificacion', $clasificacion);
								
        $this->objFunc = $this->create('MODActividad');
        $this->res = $this->objFunc->listarActividadArb();
						
        $this->res->setTipoRespuestaArbol();
								
        $arreglo = array();
		$arreglo_valores=array();
		
		//para cambiar un valor por otro en una variable
		array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'true','val_nue'=>true));
		array_push($arreglo_valores,array('variable'=>'checked','val_ant'=>'false','val_nue'=>false));
		$this->res->setValores($arreglo_valores);


        array_push($arreglo, array('nombre' => 'id', 'valor' => 'id_actividad'));
        array_push($arreglo, array('nombre' => 'id_p', 'valor' => 'id_actividad_padre'));
        //array_push($arreglo, array('nombre' => 'text', 'valores' => '[#id_actividad#]-#actividad#'));
        array_push($arreglo, array('nombre' => 'text', 'valores' => '#actividad#'));
        array_push($arreglo, array('nombre' => 'cls', 'valor' => 'descripcion'));
        array_push($arreglo, array('nombre' => 'qtip', 'valores' => '<b>#id_actividad# </b><br><b>#actividad#</b><br/>#tipo#'));
		
        /*Estas funciones definen reglas para los nodos en funcion a los tipo de nodos que contenga cada uno*/
        $this->res->addNivelArbol('tipo_nodo', 'raiz', array('leaf' => false, 'draggable' => false, 'allowDelete' => true, 'allowEdit' => false, 'cls' => 'folder', 'tipo_nodo' => 'raiz', 'icon' => '../../../lib/imagenes/a_form_edit.png'), $arreglo,$arreglo_valores);
        $this->res->addNivelArbol('tipo_nodo', 'rama', array('leaf' => false, 'draggable' => false, 'allowDelete' => true, 'allowEdit' => false, 'tipo_nodo' => 'hijo', 'icon' => '../../../lib/imagenes/a_form_edit.png'), $arreglo,$arreglo_valores);
      
    
        //Se imprime el arbol en formato JSON
        //var_dump($this->res->generarJson());exit;
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarTipos()
    {
        $this->objParam->defecto('ordenacion', 'id_tipo');

        $this->objParam->defecto('dir_ordenacion', 'asc');

        $this->objFunc = $this->create('MODActividad');
        $this->res = $this->objFunc->listarTipos();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

			
}
?>