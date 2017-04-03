<?php
/**
 * @package pXP
 * @file gen-SistemaDist.php
 * @author  (rarteaga)
 * @date 20-09-2011 10:22:05
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.DefProyectoSeguimientoConstruccion = {
        bsave: false,
        require: '../../../sis_segproyecto/vista/def_proyecto/DefProyecto.php',
        requireclase: 'Phx.vista.DefProyecto',
        title: 'Actividad hijo',
        nombreVista: 'ActividadHijo',

        constructor: function (config) {
            this.maestro = config.maestro;
            Phx.vista.DefProyectoSeguimientoConstruccion.superclass.constructor.call(this, config);
            this.init();
            this.bloquearMenus();
        },
         south: {
                url: '../../../sis_segproyecto/vista/def_proyecto_seguimiento/DefProyectoSeguimiento.php',
                title: 'Seguimiento de proyectos',
                width: '10%',
                height: '50%',
                cls: 'DefProyectoSeguimiento',
                collapsed: true
            }


    };
</script>
