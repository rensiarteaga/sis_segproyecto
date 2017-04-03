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
    Phx.vista.PonderacionDetallada = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                console.log('maestro de pondercion detallada',config)
                //llama al constructor de la clase padre
                Phx.vista.PonderacionDetallada.superclass.constructor.call(this, config);
                this.init();
                this.iniciarEventos();
                console.log('Mostrado los valos del config', config.data.datos_originales)
                this.store.baseParams = {id_def_proyecto: config.data.datos_originales.id_def_proyecto,
                    id_def_proyecto_seguimiento: config.data.datos_originales.id_def_proyecto_seguimiento};
                this.load({params:{start:0, limit:this.tam_pag}})
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
                        name: 'id_actividad'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_actividad_padre'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    config: {
                        name: 'avance',
                        fieldLabel: 'Avance',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'NumberField',
                    //filters: {pfiltro: 'avance', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },

                {
                    config: {
                        name: 'ancestors',
                        fieldLabel: 'ancestors',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 255
                    },
                    type: 'TextField',
                   // filters: {pfiltro: 't1.ancestors', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'total_avance',
                        fieldLabel: 'total_avance',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 393219
                    },
                    type: 'NumberField',
                  //  filters: {pfiltro: 't1.total_avance', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                }

            ],
            tam_pag: 50,
            title: 'Tabla de ponderacion de seguimiento proyectos',
            ActSave: '../../sis_segproyecto/control/DefProyectoSeguimiento/insertarDefProyectoSeguimiento',
            ActDel: '../../sis_segproyecto/control/DefProyectoSeguimiento/eliminarDefProyectoSeguimiento',
            ActList: '../../sis_segproyecto/control/DefProyectoSeguimiento/listarDefProyectoSeguiminetoTablaPonderacion',
            id_store: 'id_actividad',
            fields: [
                {name: 'id_actividad', type: 'numeric'},
                {name: 'id_actividad_padre', type: 'numeric'},
                {name: 'avance', type: 'numeric'},
                {name: 'ancestors', type: 'string'},
                {name: 'total_avance', type: 'numeric'},

            ],
            sortInfo: {
                field: 'id_actividad',
                direction: 'ASC'
            },
            bdel: false,
            bnew: false,
            bedit: false,
            bsave: false,
            bexcel: false
        }
    )
</script>

		