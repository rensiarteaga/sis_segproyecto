<?php
/**
 * @package pXP
 * @file gen-DefProyectoSeguimiento.php
 * @author  (admin)
 * @date 24-02-2017 04:16:20
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.DefProyectoSeguimiento = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.DefProyectoSeguimiento.superclass.constructor.call(this, config);
                this.init();
                this.iniciarEventos();
                //this.load({params:{start:0, limit:this.tam_pag}})
                this.addButton('btnPonderacionD', {
                    text: 'Ponderación detallada',
                    iconCls: 'bchecklist',
                    disabled: true,
                    handler: this.ponderacionDetallada,
                    tooltip: '<b>Ponderación detallada</b><br/>Tabla de Ponderación Detallada'
                });
                //Botón para Imprimir el resumen
                this.addButton('btnImprimirSeguimiento', {
                    text: 'Imprimir',
                    iconCls: 'bprint',
                    disabled: true,
                    handler: this.imprimirPond,
                    tooltip: '<b>Imprimir la ponderacion del del seguimiento</b><br/>Imprime a ponderacion de los datos de seguimiento'
                });
            },

            ponderacionDetallada: function () {
                console.log('entreeeeeeeeeeeeee')
                var rec = this.sm.getSelected();
                var data = rec.data;
                var me = this;
                console.log('valor seleccionado', this);
                me.objSolForm = Phx.CP.loadWindows('../../../sis_segproyecto/vista/def_proyecto_seguimiento/PonderacionDetallada.php',
                    'Tabla de ponderación detallada',
                    {
                        modal: true,
                        width: '90%',
                        height: '90%'
                    }, {
                        data: {
                            objPadre: me.maestro,
                            datos_originales: data
                        }
                    },
                    this.idContenedor,
                    'PonderacionDetallada',
                    {
                        config: [{
                            event: 'selectactividades',
                            delegate: this.onSaveForm,
                        }],

                        scope: this
                    });
            },
            imprimirPond: function () {
                var rec = this.sm.getSelected();
                var data = rec.data;
                if (data) {
                    Phx.CP.loadingShow();
                    Ext.Ajax.request({
                        url: '../../sis_segproyecto/control/DefProyectoSeguimiento/reporteResumenProyecto',
                        params: {
                            'id_def_proyecto': data.id_def_proyecto,
                            'id_def_proyecto_seguimiento': data.id_def_proyecto_seguimiento
                        },
                        success: this.successExport,
                        failure: this.conexionFailure,
                        timeout: this.timeout,
                        scope: this
                    });
                }

            },


            onSaveForm: function (interface, valores, id_def_proyecto) {
                alert('guarde los datos');
                interface.panel.close();
            },

            //asignarseguimiento:function(){
            //	alert("paso");
            //},


            Atributos: [
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_def_proyecto_seguimiento'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_def_proyecto'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    config: {
                        name: 'estado_reg',
                        fieldLabel: 'Estado Reg.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sepr.estado_reg', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha',
                        fieldLabel: 'fecha seguimiento',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'sepr.fecha', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'descripcion',
                        fieldLabel: 'descripcion',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 255
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sepr.descripcion', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'porcentaje',
                        fieldLabel: 'porcentaje',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 393219
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'sepr.porcentaje', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'usr_reg',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu1.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'usuario_ai',
                        fieldLabel: 'Funcionaro AI',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 300
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sepr.usuario_ai', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_reg',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'sepr.fecha_reg', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_usuario_ai',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'sepr.id_usuario_ai', type: 'numeric'},
                    id_grupo: 1,
                    grid: false,
                    form: false
                },
                {
                    config: {
                        name: 'usr_mod',
                        fieldLabel: 'Modificado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu2.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_mod',
                        fieldLabel: 'Fecha Modif.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'sepr.fecha_mod', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                }
            ],
            tam_pag: 50,
            title: 'Seguimiento de proyectos',
            ActSave: '../../sis_segproyecto/control/DefProyectoSeguimiento/insertarDefProyectoSeguimiento',
            ActDel: '../../sis_segproyecto/control/DefProyectoSeguimiento/eliminarDefProyectoSeguimiento',
            ActList: '../../sis_segproyecto/control/DefProyectoSeguimiento/listarDefProyectoSeguimiento',
            id_store: 'id_def_proyecto_seguimiento',
            fields: [
                {name: 'id_def_proyecto_seguimiento', type: 'numeric'},
                {name: 'id_def_proyecto', type: 'numeric'},
                {name: 'estado_reg', type: 'string'},
                {name: 'porcentaje', type: 'numeric'},
                {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'},
                {name: 'descripcion', type: 'string'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},

            ],
            sortInfo: {
                field: 'id_def_proyecto_seguimiento',
                direction: 'ASC'
            },

            // cargar valores iniciales
            loadValoresIniciales: function () {
                Phx.vista.DefProyectoSeguimiento.superclass.loadValoresIniciales.call(this);
                this.Cmp.id_def_proyecto.setValue(this.maestro.id_def_proyecto);
            },
            //relacion de padre hijo en vistas
            onReloadPage: function (m) {
                this.maestro = m;
                this.store.baseParams = {id_def_proyecto: this.maestro.id_def_proyecto};
                this.load({params: {start: 0, limit: 50}})
            },

            onButtonNew: function () {
                //abrir formulario de solicitud
                this.openForm('new');
            },
            onButtonEdit: function () {
                this.openForm('edit', this.sm.getSelected());
            },

            openForm: function (tipo, record) {
                var me = this;
                me.objSolForm = Phx.CP.loadWindows('../../../sis_segproyecto/vista/def_proyecto_seguimiento/FormProyectoSeguimiento.php',
                    'Formulario de seguimiento de proyecto',
                    {
                        modal: true,
                        width: '50%',
                        height: '60%'
                    }, {
                        data: {
                            objPadre: me.maestro,
                            tipo_form: tipo,
                            datos_originales: record
                        }
                    },
                    this.idContenedor,
                    'FormProyectoSeguimiento',
                    {
                        config: [{
                            event: 'successsaveformulario',
                            delegate: this.onSaveForm,
                        }],
                        scope: me
                    });
            },
            onSaveForm: function (frmproseg) {
                var me = this;
                me.reload();
                console.log('entre a cerrar el paneeellll', frmproseg)
                frmproseg.panel.close();
                //alert("paso");
            },
            preparaMenu: function (n) {
                var tb = Phx.vista.DefProyecto.superclass.preparaMenu.call(this);
                var rec = this.sm.getSelected();
                this.getBoton('btnPonderacionD').enable();
                this.getBoton('btnImprimirSeguimiento').enable();

                return tb;
            },
            liberaMenu: function () {
                var tb = Phx.vista.DefProyecto.superclass.liberaMenu.call(this);

                this.getBoton('btnPonderacionD').disable();
                this.getBoton('btnImprimirSeguimiento').disable();


            },

            bdel: true,
            bsave: true,
            bexcel: false
        }
    )
</script>

		