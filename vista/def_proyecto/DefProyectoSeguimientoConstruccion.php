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
            //Botón para Imprimir el resumen
            this.addButton('btnImprimir', {
                text: 'Imprimir',
                iconCls: 'bprint',
                disabled: true,
                handler: this.imprimirCbte,
                tooltip: '<b>Imprimir Resumen</b><br/>Imprime el Resumen del proyecto'
            });
            //Botón para Cargar Suministro
            this.addButton('btnSeguimientoSuministro', {
                text: 'Suministro',
                iconCls: ' x-btn-text bgood',
                disabled: true,
                handler: this.CargarSuministro,
                tooltip: '<b>Suministro</b><br/>Muestra los seguimientos al suministro'
            });
            this.bloquearMenus();

        },
        imprimirCbte: function () {
            console.log('entreeeeeeeeeeeeee')
            var rec = this.sm.getSelected();
            var data = rec.data;
            console.log('valor seleccionado', this.sm.getSelected);
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
        openFormSuministro: function (tipo, record) {
            var me = this;
            me.objSolForm = Phx.CP.loadWindows('../../../sis_segproyecto/vista/suministro/Suministro.php',
                'Formulario de seguimiento al suministro',
                {
                    modal: true,
                    width: '60%',
                    height: '60%'
                }, {
                    data: {
                        objPadre: me.maestro,
                        tipo_form: tipo,
                        datos_originales: record
                    }
                },
                this.idContenedor,
                'Suministro',
                {
                    config: [{
                        event: 'successsaveformulario',
                        delegate: this.onSaveForm,
                    }],
                    scope: me
                });
        },
        CargarSuministro: function () {

            this.openFormSuministro('new', this.sm.getSelected());
        },
        preparaMenu: function (n) {
            var tb = Phx.vista.DefProyecto.superclass.preparaMenu.call(this);
            var rec = this.sm.getSelected();
            this.getBoton('btnImprimir').enable();
            this.getBoton('btnSeguimientoSuministro').enable();

            return tb;
        },

        liberaMenu: function () {
            var tb = Phx.vista.DefProyecto.superclass.liberaMenu.call(this);

            this.getBoton('btnImprimir').disable();
            this.getBoton('btnSeguimientoSuministro').disable();
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
