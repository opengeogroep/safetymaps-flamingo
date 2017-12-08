/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};

safetymaps.safetymapsCreator = {
    conf: null,
    options: null,
    objectLayers:null,
    clusteringLayer: null,
    
    constructor: function(conf){
        this.conf= conf;
        var me = this;
        this.options = $.extend({
            clusteringSymbol:{
                    icon: conf.imagePath+"cluster.png",
                    width: 51,
                    height: 56
            },
                objectSymbol:{ 
                    icon: conf.imagePath+"object.png",
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
    
    //creates the clusterLayer with the features and the cluster strategy
    createClusterLayer: function(){
        var me = this;
        safetymaps.creator.api.getViewerObjectMapOverview()
        .done(function(data) {
            var features = safetymaps.creator.api.createViewerObjectFeatures(data);
            
            var clusterStrategy = new OpenLayers.Strategy.Cluster({distance:80, threshold:3});
            me.clusteringLayer.createLayer();  
            
            clusterStrategy.setLayer(me.clusteringLayer.layer);
            clusterStrategy.activate();
            me.conf.map.getFrameworkMap().addLayer(me.clusteringLayer.layer);
            me.clusteringLayer.addFeaturesToCluster(features);
            
            me.setClusterLayerControls(); 
            
            me.conf.map.getFrameworkMap().addLayers(me.objectLayers.createLayers());
            $(me.clusteringLayer).on("object_selected", function(event, feature) {
                me.clusterObjectSelected(feature);
            });
            
        });
    },
    
    setClusterLayerControls: function(){
        var me = this;
        var selectControl = new OpenLayers.Control.SelectFeature(
            me.clusteringLayer.layer,
            {
                clickout: true,
                toggle: true,
                multiple: false
            }
        );
        
        me.conf.map.getFrameworkMap().addControl(selectControl);;
        selectControl.activate();
        
    },
    
    clusterObjectSelected: function(feature){
        var me = this;
        if(feature.cluster){
            //build gui for search..
        }else{
            //single feature clicked
            me.singleObjectClicked(feature);
            
        }
    },
    
    singleObjectClicked: function(feature){
        var me = this;
        me.conf.map.getFrameworkMap().setCenter(new OpenLayers.LonLat(feature.geometry.x, feature.geometry.y), 13);
        
        safetymaps.creator.api.getObjectDetails(feature.attributes.id)
        .fail(function(msg) {
            // TODO
        })
        .done(function(object) {
            console.log(object);
            me.selectedObjectDetailsReceived(object);
        });
    },
    
    selectedObjectDetailsReceived: function(object){
        var me = this;
        try {
            me.objectLayers.addFeaturesForObject(object);
            me.selectedObject = object;
        } catch(error) {
            console.log("Error creating layers for object", object);
            if(error.stack) {
                console.log(error.stack);
            }
        }
    }
    
    
};
