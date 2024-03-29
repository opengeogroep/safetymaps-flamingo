/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};
var dkjs = {};

safetymaps.safetymapsCreator = {
    conf: null,
    options: null,
    selectControl: null,
    hoverControl: null,
    objectLayers: null,
    clusteringLayer: null,
    selectedObject: null,
    selectedClusterFeature: null,

    constructor: function (conf) {
        this.conf = conf;
        var me = this;
        this.options = $.extend({
            clusterStrategy: {
            distance: 80,
            threshold: 2
            },
            clusteringSymbol: {
                icon: conf.imagePath + "cluster.png",
                width: 51,
                height: 56
            },
            objectSymbol: {
                icon: conf.imagePath + "object.png",
                width: 23,
                height: 40
            }
        }, this.options);
        var pStyles = safetymaps.creator.api.getStyles();
        me.clusteringLayer = new safetymaps.ClusteringLayer(me.options);
        me.conf.map = me.conf.map.getFrameworkMap();
        me.objectLayers = new safetymaps.creator.CreatorObjectLayers(me.conf);
        //me.conf.map.getFrameworkMap().addLayers(me.objectLayers.createLayers())
        me.createClusterLayer();
        dbkjs = me.conf;
    },

    //creates the clusterLayer with the features and register for feature/cluster clicked event
    createClusterLayer: function () {
        var me = this;
        safetymaps.creator.api.getViewerObjectMapOverview()
                .done(function (data) {
                    var features = safetymaps.creator.api.createViewerObjectFeatures(data);

                    me.clusteringLayer.createLayer();

                    me.conf.map.addLayer(me.clusteringLayer.layer);
                    me.clusteringLayer.addFeaturesToCluster(features);

                    me.createControls();

                    me.conf.map.addLayers(me.objectLayers.createLayers());
                    $(me.clusteringLayer).on("object_selected", function (event, feature) {
                        me.clusterObjectSelected(feature);
                    });
                    $(me.clusteringLayer).on("object_cluster_selected", function (event, features) {
                        me.clusterObjectClusterSelected(features);
                    });

                    safetymaps.search.createValues(features);
                    me.activateControls();    
                    $(me).triggerHandler("safetymapsInit", me); // fires for the toggle component
                });
    },

    activateControls: function () {
        var me = this;
        $.each(me.objectLayers.selectLayers, function (i, l) {
            me.selectControl.layers.push(l);
            if (l.hover) {
                me.hoverControl.layers.push(l);
            }
            me.conf.map.setLayerIndex(l,90+i);
            l.events.register("featureselected", me, me.objectLayerFeatureSelected);
            l.events.register("featureunselected", me, function(e){
                if(e.feature.attributes.temp){
                    delete e.feature.attributes.temp;
                    return;
                }
                me.conf.featureInfoWindow.window.hide();
                if (e.feature.layer === me.objectLayers.layerCustomPolygon) {
                    e.feature.layer.redraw();
                }
            });
        });
        me.hoverControl.activate();
        me.selectControl.activate();
    },

    createControls: function () {
        var me = this;
        me.hoverControl = new OpenLayers.Control.SelectFeature(
                [],
                {
                    hover: true,
                    highlightOnly: true,
                    clickTolerance: 30,
                    renderIntent: "temporary"
                }
        );
        me.hoverControl.handlers.feature.stopDown = false;
        me.hoverControl.handlers.feature.stopUp = false;
        me.conf.map.addControl(me.hoverControl);

        me.selectControl = new OpenLayers.Control.SelectFeature(
                [me.clusteringLayer.layer],
                {
                    clickout: true,
                    toggle: true,
                    multiple: false
                }
        );
        me.selectControl.handlers.feature.stopDown = false;
        me.selectControl.handlers.feature.stopUp = false;
        me.conf.map.addControl(me.selectControl);

    },

    clusterObjectClusterSelected: function (feature) {
        console.log("object_cluster_clicked", feature);
        var me = this;
        //clear the window
        this.conf.clusterWindow.tab.removeAll();
        this.conf.clusterWindow.window.setTitle("infopanel");

        var currentCluster = feature.cluster.slice();
        var features = new Array();
        for (var i = 0; i < currentCluster.length; i++) {
            var informele_naam = currentCluster[i].attributes.apiObject.informele_naam;
            var naam = currentCluster[i].attributes.apiObject.formele_naam;
            if(informele_naam && informele_naam !== naam && informele_naam.trim().length > 0){
                naam += " (" + informele_naam + ")";
            }
            var obj = {
                name: naam,
                object: currentCluster[i]
            };
            features.push(obj);
        }
        var callback = {scope: me, fn: me.clusterListClicked};
        var config = {tabName: "cluster", fields: ["name"], columns: [{text: 'Name', dataIndex: 'name'}]};
        this.conf.clusterWindow.createGrid(config, features, callback,false);
        this.conf.clusterWindow.window.show();
    },

    clusterListClicked: function (gridview, row) {
        this.conf.clusterWindow.window.hide();
        this.clusterObjectSelected(row.data.object);
    },

    floorClicked: function (gridview, row) {
        var me = this;
        var floor = row.data[0];
        console.log("clicked floor" + floor);
        $.each(row.data.object.verdiepingen, function (i, v) {
            if (v.id !== row.data.object.id && v.bouwlaag === floor) {
                me.selectObjectById(v.id);
            }
        });
    },

    clusterObjectSelected: function (feature) {

        this.selectedClusterFeature = feature;
        this.selectObjectById(feature.attributes.id, {x: feature.geometry.x, y: feature.geometry.y});
    },

    selectObjectById: function (id, xyToZoom) {
        var me = this;

        // Unselect current, if any
        me.unselectObject();

        if (xyToZoom) {
            console.log("zooming to selected object at ", xyToZoom);
            me.conf.map.setCenter(new OpenLayers.LonLat(xyToZoom.x, xyToZoom.y), 13);
        }

        // Get object details
        $("#creator_object_info").text(i18n.t("dialogs.busyloading") + "...");
        safetymaps.creator.api.getObjectDetails(id)
                .fail(function (msg) {
                    $("#creator_object_info").text("Error: " + msg);
                })
                .done(function (object) {
                    me.selectedObjectDetailsReceived(object);
                });
    },

    unselectObject: function () {
        if (this.selectedObject) {
            this.objectLayers.removeAllFeatures();

            if (this.selectedClusterFeature && this.selectedClusterFeature.layer) {
                this.selectControl.unselect(this.selectedClusterFeature);
            }
        }
        this.selectedObject = null;
        this.selectedClusterFeature = null;
    },

    selectedObjectDetailsReceived: function (object) {
        var me = this;
        try {
            me.objectLayers.addFeaturesForObject(object);
            me.updateInfoWindow(object);
            me.selectedObject = object;
            
            var ids = [object.id];
            $.each(object.verdiepingen || [], function(i, v) {
                ids.push(v.id);
            });
            this.clusteringLayer.setSelectedIds(ids);
        } catch (error) {
            console.log("Error creating layers for object", object);
            if (error.stack) {
                console.log(error.stack);
            }
        }
    },

    objectLayerFeatureSelected: function (e) {
        var me = this;
        var layer = e.feature.layer;
        var f = e.feature.attributes;
        me.conf.featureInfoWindow.window.removeAll();
        if (layer === me.objectLayers.layerCustomPolygon) {
            console.log("CustomPolygon feature selected", e);
            var desc = f.style.en;
            if(f.style.hasOwnProperty(dbkjsLang)) {
                if(f.style[dbkjsLang] !== "") {
                    desc = f.style[dbkjsLang];
                }
            }
            var columns = [
                {text: "", dataIndex: 1,renderer:function(value,meta){meta.tdAttr = 'style="background:'+f.style.color+';"';return value;}},
                {text: '<b>'+i18n.t("dialogs.information")+'</b>', dataIndex: 2}
            ];
            var values = [
                {1:'',2: desc}
            ];
            var conf = {tabName: "", feature: true, fields: [], columns: columns};
            me.conf.featureInfoWindow.window.setTitle(i18n.t("creator.area"));
            me.conf.featureInfoWindow.createGrid(conf, values, false,false);
            layer.redraw();
        } else if (layer === me.objectLayers.layerFireCompartmentation) {
            console.log("FireCompartmentation feature selected", e);
            var desc = f.style.en;
            if(f.style.hasOwnProperty(dbkjsLang)) {
                if(f.style[dbkjsLang] !== "") {
                    desc = f.style[dbkjsLang];
                }
            }
            var columns = [
                {text: '<b>'+i18n.t("dialogs.information")+'</b>', dataIndex: 1}
            ];
            var values = [
                {1: desc}
            ];
            var conf = {tabName: "", feature: true, fields: [], columns: columns};
            me.conf.featureInfoWindow.window.setTitle(i18n.t("creator.fire_compartment"));
            me.conf.featureInfoWindow.createGrid(conf, values, false,false);
        } else if (layer === me.objectLayers.layerCommunicationCoverage) {
            console.log("communication feature selected", e);
            var img = safetymaps.creator.api.imagePath + (f.coverage ? "coverage" : "no_coverage") + ".png";
            var columns = [
                {text: '<b>' + i18n.t("creator.symbol_" + (f.coverage ? "" : "no_") + "communication_coverage") + '</b>', dataIndex: 1},
                {text: '<b>' + i18n.t("dialogs.information") + '</b>', dataIndex: 2},
                {text: '<b>' + i18n.t("creator.communication_alternative") + '</b>', dataIndex: 3}
            ];
            var values = [
                {1: '<img style="width: 20%" src="' + img + '">', 2: Mustache.escape(f.info), 3: Mustache.escape(f.alternative)}
            ];
            var conf = {tabName: "", feature: true, fields: [], columns: columns};
            me.conf.featureInfoWindow.window.setTitle(i18n.t("creator.symbols"));
            me.conf.featureInfoWindow.createGrid(conf, values, false,false);
        } else if (layer === me.objectLayers.layerSymbols) {
            console.log("symbol selected", e);
            var img = safetymaps.creator.api.imagePath + 'symbols/' + f.code + '.png';
            var columns = [
                {text: '<b>' + i18n.t("symbol." + f.code) + '</b>', dataIndex: 1},
                {text: '<b>' + i18n.t("dialogs.information") + '</b>', dataIndex: 2}
            ];
            var values = [
                {1: '<img style="width: 20%" src="' + img + '" alt="' + f.code + '" title="' + f.code + '">', 2: Mustache.escape(f.description)}
            ];
            var conf = {tabName: "", feature: true, fields: [], columns: columns};
            me.conf.featureInfoWindow.window.setTitle(i18n.t("creator.symbols"));
            me.conf.featureInfoWindow.createGrid(conf, values, false,false);
        } else if (layer === me.objectLayers.layerDangerSymbols) {
            var columns = [
                {text: '<b>' + i18n.t("creator.danger_symbol_icon") + '</b>', dataIndex: 1},
                {text: '<b>' + i18n.t("creator.danger_symbol_hazard_identifier") + '</b>', dataIndex: 2},
                {text: '<b>' + i18n.t("creator.danger_symbol_name") + '</b>', dataIndex: 3},
                {text: '<b>' + i18n.t("creator.danger_symbol_quantity") + '</b>', dataIndex: 4},
                {text: '<b>' + i18n.t("creator.danger_symbol_information") + '</b>', dataIndex: 5}
            ];
            var obj = {
                1: '<img style="width: 20%" src="{{img}}" alt="{{symbolName}}" title="{{symbolName}}">',
                2: '<div class="gevicode">{{f.geviCode}}</div><div class="unnummer">{{f.unNr}}</div>',
                3: '{{f.substance_name}}',
                4: '{{f.amount}}',
                5: '{{f.description}}'
            };
            for (idx in obj) { 
                obj[idx] = Mustache.render(obj[idx], { 
                    img: safetymaps.creator.api.imagePath + 'danger_symbols/' + f.symbol + '.png',
                    symbolName: i18n.t("creator.danger_symbol_" + f.symbol),
                    f: f
                });
            };
            var values = [obj];
            var conf = {tabName: "", feature: true, fields: [], columns: columns};
            me.conf.featureInfoWindow.window.setTitle(i18n.t("creator.danger_symbols"));
            me.conf.featureInfoWindow.createGrid(conf, values, false,false);
        }
        this.conf.featureInfoWindow.window.show();
    },

    updateInfoWindow: function (object) {
        this.conf.clusterWindow.tab.removeAll();
        safetymaps.safetymapsCreator.renderGeneral(object, this.conf.clusterWindow);
        safetymaps.safetymapsCreator.renderDetails(object, this.conf.clusterWindow);
        safetymaps.safetymapsCreator.renderContacts(object, this.conf.clusterWindow);
        safetymaps.safetymapsCreator.renderOccupancy(object, this.conf.clusterWindow);
        safetymaps.safetymapsCreator.renderMedia(object, this.conf.clusterWindow);
        safetymaps.safetymapsCreator.renderSymbols(object, this.conf.clusterWindow, "danger");
        safetymaps.safetymapsCreator.renderFloors(object, this.conf.clusterWindow);
        safetymaps.safetymapsCreator.renderSymbols(object, this.conf.clusterWindow, "normal");
        this.conf.clusterWindow.window.show();
        if(object.informele_naam){ 
            this.conf.clusterWindow.window.setTitle(object.informele_naam);
        } else if(object.formele_naam){ 
            this.conf.clusterWindow.window.setTitle(object.formele_naam);
        } else {
            this.conf.clusterWindow.window.setTitle("(In)formele naam ontbreekt");
        }
    }
};
