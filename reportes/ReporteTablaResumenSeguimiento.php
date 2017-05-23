<?php

// Extend the TCPDF class to create custom MultiRow
class ReporteTablaResumenSeguimiento extends ReportePDF
{
    var $datos_titulo;
    var $datos_detalle;
    var $ancho_hoja;
    var $gerencia;
    var $numeracion;
    var $ancho_sin_totales;
    var $cantidad_columnas_estaticas;
    var $s1;
    var $t1;
    var $tg1;
    var $total;
    var $datos_entidad;
    var $datos_periodo;
    var $ult_codigo_partida;
    var $ult_concepto;


    //nuevos datos que vienen del modelo
    var $id_def_proyecto;
    var $fecha_inicio_teorico;
    var $fecha_fin_teorico;
    var $descripcion;


    function datosHeader($detalle)
    {
        $this->ancho_hoja = $this->getPageWidth() - PDF_MARGIN_LEFT - PDF_MARGIN_RIGHT - 10;
        $this->datos_detalle = $detalle;
        $this->datos_titulo = $totales;
        $this->datos_entidad = $dataEmpresa;
        $this->datos_gestion = $gestion;
        $this->subtotal = 0;
        $this->SetMargins(7, 65, 5);
    }

    function header()
    {


    }

    function generarReporte()
    {

        $this->AddPage();


        //adiciona reporte
        ob_start();
        include(dirname(__FILE__) . '/tpl/reporteSeguimientoOperativo.php');
        $content = ob_get_clean();

        $this->writeHTML($content, false, false, true, false, '');

        $this->SetFont ('helvetica', '', 5 , '', 'default', true );


    }

    function footer()
    {

    }


}

?>