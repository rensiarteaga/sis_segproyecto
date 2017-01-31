<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (rarteaga)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ActividadPadre = {    
    bsave:false,    
    require:'../../../sis_segproyecto/vista/actividad/Actividad.php',
    requireclase:'Phx.vista.Actividad',
    title:'Actividad Padre',
    nombreVista: 'ActividadPadre',    

    constructor: function(config) {
        this.maestro=config.maestro;  
        Phx.vista.ActividadPadre.superclass.constructor.call(this,config);
        this.init();
        this.store.baseParams={nombreVista:this.nombreVista}
		this.load({params:{start:0, limit:this.tam_pag }})  
    } ,
    tabeast:[
         {
          url:'../../../sis_segproyecto/vista/actividad/ActividadHijo.php',
          title:'Subactividad', 
          width:400,
          cls:'ActividadHijo'
         }
        ],
    
};
</script>
