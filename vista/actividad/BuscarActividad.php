<?php
/**
 * @package pxP
 * @file    BuscarActividad.php
 * @author  Gonzalo Sarmiento Sejas
 * @date    16-07-2013
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.BuscarActividad = Ext.extend(Phx.arbInterfaz, {
        constructor: function (config) {

			
            this.maestro = config.data.objPadre.maestro;
            Phx.vista.BuscarActividad.superclass.constructor.call(this, config);
            this.init();
            this.iniciarEventos();
            this.getBoton('triguerreturn').enable();
        },
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
            }],
        NodoCheck: true,//si los nodos tienen los valores para el check
        ActCheck: '../../sis_seguridad/control/GuiRol/checkGuiRol',
        title: 'Buscador de Actividades',
        ActList: '../../sis_segproyecto/control/Actividad/listarActividadArb',

        id_store: 'id_actividad',
        baseParams: {clasificacion: true},
        textRoot: 'Actividades',
        id_nodo: 'id_actividad',
        id_nodo_p: 'id_actividad_padre',
        enableDD: false,
        bnew: false,
        bsave: false,
        bedit: false,
        bdel: false,
        rootVisible: true,
        fwidth: 420,
        fheight: 300,
        fields: [{
            name: 'id',
            type: 'numeric'
        }, {
            name: 'actividad',
            type: 'string'
        }, {
            name: 'id_actividad_padre',
            type: 'numeric'
        }, {
            name: 'id_actividad',
            type: 'numeric'
        }],
        sortInfo: {
            field: 'id_actividad',
            direction: 'ASC'
        },
        onCheckchange: function () {
            //do nothing
        },

        iniciarEventos: function () {
            //muestra el evento cuando checkea
            var me = this; //Cargamos temporalmente la variable
            me.treePanel.on('checkchange', function (node, valor) {
                this.treePanel.suspendEvents()
                if (!node.isLeaf()) {
                    node.expand(true, true, function () {
                        me.recorrerMetodos(node, valor)
                    }, me)
                } else {
                    var nodoPadre = node.parentNode;
                    if (valor) {
                        if (!nodoPadre.attributes.checked) {

                            nodoPadre.getUI().toggleCheck(valor);
                            console.log('nodo padre',nodoPadre);
                        }
                        //nodoPadre.getUI().toggleCheck(true);
                    }
                }
                this.treePanel.resumeEvents()
            }, me);

        },
        recorrerMetodos: function (node, valor) {

            node.cascade(function (Mynode) {
                Mynode.getUI().toggleCheck(valor);
            }, this);

            //console.log(node)
            //this.treePanel	.syncSize( )
            ///alert('llega' + valor)
        },
        getAllChildNodes: function (node) {
            var allNodes = new Array();
            if (!Ext.value(node, false)) {
                return [];
            }
            if (!node.hasChildNodes()) {
                return node;
            } else {
                allNodes.push(node);
                node.eachChild(function (Mynode) {
                    allNodes = allNodes.concat(this.getAllChildNodes(Mynode));
                    if (Mynode.attributes.checked) {
                        var _id = ',' + Mynode.attributes.id_clasificacion;
                        var _desc = ', ' + Mynode.attributes.text;
                        this.id_clasificacion = this.id_clasificacion + _id;
                        this.desc_clasificacion = this.desc_clasificacion + _desc;
                    }
                }, this);
            }
            return allNodes;
        },
        seleccionNodos: function (node) {
            this.id_clasificacion = '';
            this.desc_clasificacion = '';
            var nodes = this.getAllChildNodes(node);
            this.id_clasificacion = this.id_clasificacion.substring(1, this.id_clasificacion.length)
            this.desc_clasificacion = this.desc_clasificacion.substring(1, this.desc_clasificacion.length)
        },
        nodosCheckeados: function () {
            //var nodoRoot = this.treePanel.getRootNode();
            //var allNodos = this.getAllChildNodes(nodoRoot);
            var arregloActividades= [];
            var id_actividades = '';
            this.treePanel.getChecked().forEach(function (node) {
            	
            	if(id_actividades ==''){
            		id_actividades = node.attributes.id_actividad;
            	}
            	else
            	{
            		id_actividades = id_actividades +','+node.attributes.id_actividad;
            	}
               
            });
            return id_actividades;

        },

        id_clasificacion: '',
        desc_clasificacion: '',
        btriguerreturn: true,

        onButtonTriguerreturn: function () {
        	
           this.fireEvent('selectactividades', this, this.nodosCheckeados(), this.maestro.id_def_proyecto);
			
        }

    });
</script>
