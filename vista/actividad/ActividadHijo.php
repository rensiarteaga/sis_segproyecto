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
    Phx.vista.ActividadHijo = {
        bsave: false,
        require: '../../../sis_segproyecto/vista/actividad/Actividad.php',
        requireclase: 'Phx.vista.Actividad',
        title: 'Actividad hijo',
        nombreVista: 'ActividadHijo',

        constructor: function (config) {
            this.maestro = config.maestro;
            Phx.vista.ActividadHijo.superclass.constructor.call(this, config);
            this.init();
            this.bloquearMenus();
        },

        loadValoresIniciales: function () {
            Phx.vista.ActividadHijo.superclass.loadValoresIniciales.call(this);
            this.Cmp.id_actividad_padre.setValue(this.maestro.id_actividad);
            this.Cmp.tipo_actividad.setValue(this.maestro.tipo_actividad);
            this.Cmp.id_tipo.setValue(this.maestro.id_tipo);
        },

        onReloadPage: function (m) {
            this.maestro = m;
            this.store.baseParams = {id_actividad_padre: this.maestro.id_actividad, nombreVista: this.nombreVista};
            this.load({params: {start: 0, limit: 50}})

        },
        tabeast: [
            {
                url: '../../../sis_segproyecto/vista/actividad/ActividadNieto.php',
                title: 'Subactividad hijo',
                width: 500,
                cls: 'ActividadNieto'
            }
        ],

    };
</script>
