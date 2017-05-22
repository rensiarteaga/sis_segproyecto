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
        title: 'Seguimiento Operativo',

        constructor: function (config) {
            this.maestro = config.maestro;
            Phx.vista.DefProyectoSeguimientoConstruccion.superclass.constructor.call(this, config);
            this.init();
            //Botón para Imprimir el resumen
            this.addButton('btnImprimir', {
                text: 'Tabla de ponderación',
                iconCls: 'bprint',
                disabled: true,
                handler: this.imprimirCbte,
                tooltip: '<b>Imprimir Reporte tabla de ponderación</b><br/>Imprimr la tabla de ponderación del proyecto'
            });
            this.bloquearMenus();

        },
        imprimirCbte: function () {
            var rec = this.sm.getSelected();
            var data = rec.data;
            if (data) {
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    url: '../../sis_segproyecto/control/DefProyecto/reporteResumenProyecto',
                    params: {
                        'id_def_proyecto': data.id_def_proyecto
                    },
                    success: this.successExport,
                    failure: this.conexionFailure,
                    timeout: this.timeout,
                    scope: this
                });
            }

        },
        preparaMenu: function (n) {
            var tb = Phx.vista.DefProyecto.superclass.preparaMenu.call(this);
            var rec = this.sm.getSelected();
            this.getBoton('btnImprimir').enable();

            return tb;
        },

        liberaMenu: function () {
            var tb = Phx.vista.DefProyecto.superclass.liberaMenu.call(this);

            this.getBoton('btnImprimir').disable();
        },
        south: {
            url: '../../../sis_segproyecto/vista/def_proyecto_seguimiento/DefProyectoSeguimiento.php',
            title: 'Seguimiento de proyectos',
            width: '10%',
            height: '50%',
            cls: 'DefProyectoSeguimiento',
            collapsed: true
        },
        bdel: false,
        bnew:false,
        bedit:false,
        bsave: false,


    };
</script>
