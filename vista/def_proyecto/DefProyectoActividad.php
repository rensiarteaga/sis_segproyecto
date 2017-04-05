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
    Phx.vista.DefProyectoActividad = {
        bsave: false,
        require: '../../../sis_segproyecto/vista/def_proyecto/DefProyecto.php',
        requireclase: 'Phx.vista.DefProyecto',
        title: 'Proyecto Actividad',

        constructor: function (config) {
            this.maestro = config.maestro;
            Phx.vista.DefProyectoActividad.superclass.constructor.call(this, config);
            this.init();

            this.bloquearMenus();
        },
        
            east: {
                url: '../../../sis_segproyecto/vista/def_proyecto_actividad/DefProyectoActividad.php',
                title: 'Asignacion actividades',
                width: '50%',
                cls: 'DefProyectoActividad',
                collapsed: true
            }

    };
</script>
