/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


Ext.define("viewer.components.safetymapsFlamingo", {
    extend: "viewer.components.Component",
    config: {},
    viewerController: null,
    map: null,
    basePath: "",
    imagePath: "",
    clusterWindow: null,

    constructor: function (conf) {
        var me = this;

        viewer.components.safetymapsFlamingo.superclass.constructor.call(this, conf);

        this.initConfig(conf);

        me.initApplication(conf);
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
        console.log(me.basePath);
        me.imagePath = me.basePath + "/module/assets/";
        safetymaps.creator.api.imagePath = me.imagePath;

        var cssPath = me.basePath.replace("resource=", "mimeType=text/css&resource=");
        me.loadCssFile(cssPath+"libs/bootstrap-3.2.0-dist/css/bootstrap.min.css");
        me.loadCssFile(cssPath +"css/dbk.css");

        me.clusterWindow = Ext.create("viewer.components.safetymapsWindow", {id: "infopanel"});

        safetymaps.safetymapsCreator.constructor(me);
    },

    loadCssFile: function (filename) {
        var fileref = document.createElement("link");
        fileref.setAttribute("rel", "stylesheet");
        fileref.setAttribute("type", "text/css");
        fileref.setAttribute("href", filename);
        document.getElementsByTagName("head")[0].appendChild(fileref);
    }
});