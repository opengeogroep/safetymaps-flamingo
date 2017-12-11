/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};

safetymaps.safetymapsCreator = {
    conf: null,
    options: null,
    selectControl: null,
    objectLayers: null,
    clusteringLayer: null,
    selectedObject: null,
    selectedClusterFeature: null,

    constructor: function (conf) {
        this.conf = conf;
        var me = this;
        this.options = $.extend({
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
        me.objectLayers = new safetymaps.creator.CreatorObjectLayers();
        //me.conf.map.getFrameworkMap().addLayers(me.objectLayers.createLayers());

        me.createClusterLayer();

    },

    //creates the clusterLayer with the features and register for feature/cluster clicked event
    createClusterLayer: function () {
        var me = this;
        safetymaps.creator.api.getViewerObjectMapOverview()
                .done(function (data) {
                    var features = safetymaps.creator.api.createViewerObjectFeatures(data);

                    me.clusteringLayer.createLayer();

                    me.conf.map.getFrameworkMap().addLayer(me.clusteringLayer.layer);
                    me.clusteringLayer.addFeaturesToCluster(features);

                    me.setClusterLayerControls();

                    me.conf.map.getFrameworkMap().addLayers(me.objectLayers.createLayers());
                    $(me.clusteringLayer).on("object_selected", function (event, feature) {
                        me.clusterObjectSelected(feature);
                    });
                    $(me.clusteringLayer).on("object_cluster_selected", function (event, features) {
                        me.clusterObjectClusterSelected(features);
                    });

                });
    },

    setClusterLayerControls: function () {
        var me = this;
        me.selectControl = new OpenLayers.Control.SelectFeature(
                me.clusteringLayer.layer,
                {
                    clickout: true,
                    toggle: true,
                    multiple: false
                }
        );

        me.conf.map.getFrameworkMap().addControl(me.selectControl);
        ;
        me.selectControl.activate();

    },

    clusterObjectClusterSelected: function (feature) {
        console.log("object_cluster_clicked", feature);
        var me = this;
        var item_ul = $('<ul id="dbklist" class="nav nav-pills nav-stacked"></ul>');

        var currentCluster = feature.cluster.slice();

        for (var i = 0; i < currentCluster.length; i++) {
            var ret_title = $('<li></li>');
            ret_title.append('<a id="' + currentCluster[i].attributes.id + '" href="#">' + currentCluster[i].attributes.label+'</a>');
            item_ul.append(ret_title);
        }
        
        this.conf.clusterWindow.window.update(item_ul.clone().wrap('<p>').parent().html());
        this.conf.clusterWindow.window.show();
        $("#dbklist").on("click", "a", function(e){
            var feature = me.getFeatureFromCluster(e,currentCluster);
            me.conf.clusterWindow.window.hide();
            me.clusterObjectSelected(feature);
        });

    },
    
    getFeatureFromCluster: function(e,cluster){
        var feature = null;
        
        for(var i = 0; i<cluster.length;i++){
            if(e.target.id === cluster[i].attributes.id.toString()){
                feature = cluster[i];
                return feature;
            }
        }
        console.log("feature is null");
        return feature;
    },
    
    clusterObjectSelected: function (feature) {
        var me = this;

        // Unselect current, if any
        me.unselectObject();

        this.selectedClusterFeature = feature;

        console.log("zooming to feature", feature.geometry);
        me.conf.map.getFrameworkMap().setCenter(new OpenLayers.LonLat(feature.geometry.x, feature.geometry.y), 13);

        safetymaps.creator.api.getObjectDetails(feature.attributes.id)
                .fail(function (msg) {
                    // TODO
                })
                .done(function (object) {
                    me.selectedObjectDetailsReceived(object);
                });
    },

    unselectObject: function () {
        if (this.selectedObject) {
            this.objectLayers.removeAllFeatures();

            if (this.selectedClusterFeature.layer) {
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
            me.selectedObject = object;
        } catch (error) {
            console.log("Error creating layers for object", object);
            if (error.stack) {
                console.log(error.stack);
            }
        }
    }


};
