/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global safetymaps, Ext, moment, actionBeans */

var dbkjsLang = "nl";

Ext.define("viewer.components.safetymapsFlamingo", {
    extend: "viewer.components.Component",
    config: {},
    options: {},
    viewerController: null,
    map: null,
    basePath: "",
    imagePath: "",
    clusterWindow: null,
    featureInfoWindow: null,

    constructor: function (conf) {
        viewer.components.safetymapsFlamingo.superclass.constructor.call(this, conf);

        this.initConfig(conf);
        this.viewerController.addListener(
                viewer.viewercontroller.controller.Event.ON_COMPONENTS_FINISHED_LOADING,
                this.registerFlamingoPrintHandler,
                this);
        this.viewerController.addListener(
                viewer.viewercontroller.controller.Event.ON_COMPONENTS_FINISHED_LOADING,
                this.registerFlamingoSearchHandler,
                this);
        this.initApplication(conf);
    },

    initApplication: function (conf) {
        var me = this;
        me.viewerController = me.config.viewerController;
        me.map = me.viewerController.mapComponent.getMap();
        
        safetymaps.creator.api.basePath = conf.dataPath + "/"; // path to safetymaps-server
        if (actionBeans && actionBeans["componentresource"]) {
            me.basePath = actionBeans["componentresource"];
            me.basePath = Ext.String.urlAppend(me.basePath, "className=" + Ext.getClass(me).getName());
            me.basePath = Ext.String.urlAppend(me.basePath, "resource=");
        } else {
            me.basePath = "";
        }
        me.modules = {
            safetymaps_creator: {
                options: {
                    hideTabs: ""
                }
            }
        }
        me.options = {
            zoom: 13,
            // Set to true to enable style scaling according to map scale
            styleScaleAdjust: conf.scaling,
            // Scale at which scaled values are returned as original
            originalScale: 595.2744,
            // User style value adjustment (before scaling)
            styleSizeAdjust: 0,

            alwaysShowDbkFeature: true,

            noLineScaling: true,

            featureLabelResolution: 6.72,

            dbkLayersMinResolution: 0,

            forcePDFJS: true
        };
        if(dbkjsLang){
            moment.locale(dbkjsLang);
        } else {
            moment.locale("en");
        }
        i18n.init({
            lng: dbkjsLang,
            fallbackLng: 'en',
            debug: false,
            resGetPath: me.basePath + "locales/__lng__/translation.json",
            postProcess: "doReplacements"
        });
        me.imagePath = me.basePath + "/assets/";
        safetymaps.creator.api.imagePath = me.imagePath;
        safetymaps.creator.api.mediaPath = conf.mediaPath+"/";// what is the correct path?
        me.mediaPath = conf.mediaPath+"/";// what is the correct path? "https://vrz-acceptatie-mobiel.safetymaps.nl/media/"
        
        var cssPath = me.basePath.replace("resource=", "mimeType=text/css&resource=");
        me.loadCssFile(cssPath+"libs/bootstrap-3.2.0-dist/css/bootstrap.min.css");
        me.loadCssFile(cssPath +"css/safetymaps.css");

        me.clusterWindow = Ext.create("viewer.components.safetymapsWindow", {id: "infopanel"});

        me.featureInfoWindow = Ext.create("viewer.components.safetymapsWindow", {id: "featureInfo", height:300,width:700});

        safetymaps.safetymapsCreator.constructor(me);
        safetymaps.search.constructor(me);
        safetymaps.print.constructor(me);
        
    },

    loadCssFile: function (filename) {
        var fileref = document.createElement("link");
        fileref.setAttribute("rel", "stylesheet");
        fileref.setAttribute("type", "text/css");
        fileref.setAttribute("href", filename);
        document.getElementsByTagName("head")[0].appendChild(fileref);
    },

    registerFlamingoSearchHandler: function () {
        var me = this;
        var searchComponents = this.config.viewerController.getComponentsByClassName("viewer.components.Search");
        // Register to all search components.
        for (var i = 0; i < searchComponents.length; i++) {
            // Register extra info handler with callback.
            var obj = {
                instance: this,
                title: "Digitale bereikbaarheidskaart"
            };
            searchComponents[i].addDynamicSearchEntry(obj, function (queryId, searchRequestId) {
                console.log(queryId, searchRequestId);
                return safetymaps.search.getSearchResult(queryId, searchRequestId);
            });
        }
        ;
    },

    registerFlamingoPrintHandler: function () {
        var me = this;
        var printComponents = this.viewerController.getComponentsByClassName("viewer.components.Print");
        // Register to all print components.
        for (var i = 0; i < printComponents.length; i++) {
            // Register extra info handler with callback.
            printComponents[i].registerExtraInfo(this, function () {
                if(safetymaps.safetymapsCreator.clusteringLayer.layer.visibility){
                    return safetymaps.print.getObjectProperties();
                } else {
                    return {};
                }
            });
            // Register extra layers handler with callback.
            printComponents[i].registerExtraLayers(this, function () {
                if(safetymaps.safetymapsCreator.clusteringLayer.layer.visibility){
                    return safetymaps.print.getExtraLayers();
                } else {
                    return [];
                }
            });
        }
        ;
    }
});