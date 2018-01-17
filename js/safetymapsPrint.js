/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};

safetymaps.print = {
    config: {},
    options: [],

    constructor: function (conf) {
        this.options = {
            // The url to the wms service with layers for printing.
            printWMSPath: conf.printWMSPath,
            // The names of the layers of the wms service with layers for printing.
            // The names should be separated by ";".
            printLayerNames: conf.printLayerNames,
            // The format of the wms service with layers for printing.
            printFormat: conf.printFormat,
            // The srs of the wms service with layers for printing.
            printSRS: conf.printSRS,
            // The transparent flag of the wms service with layers for printing.
            printTransparent: conf.printTransparent,
            // The alpha of the wms service with layers for printing.
            printAlpha: conf.printAlpha
        },
                this.config = conf;
    },

    getObjectProperties: function () {
        var currentDbkObject;
        var newDbkObject;
        var propNames;
        var propName;
        var verblijf;
        var media;
        var mediaPath;
        var len;
        var i;

        // Get the selected dbk-object.
        currentDbkObject = safetymaps.safetymapsCreator.selectedObject;
        // No dbk-object selected?
        if (!currentDbkObject) {
            return {};
        }

        // Get all names of the relevant properties.
        propNames = this.getPrintPropertyNames();

        // Make a copy.
        newDbkObject = {};
        Ext.apply(newDbkObject, currentDbkObject);

        // Remove not relevant properties, and geometries too.
        for (propName in newDbkObject) {
            if (newDbkObject.hasOwnProperty(propName)) {
                if (propNames.indexOf(propName) < 0) {
                    // Remove property.
                    delete newDbkObject[propName];
                } else {
                    // Valid property value?
                    if (newDbkObject[propName]) {
                        // Geometry property exists?
                        if (newDbkObject[propName].hasOwnProperty("geometry")) {
                            delete newDbkObject[propName]["geometry"];
                        } else {
                            // Array?
                            if ((newDbkObject[propName].length) && (newDbkObject[propName].length > 0)) {
                                for (i = 0, len = newDbkObject[propName].length; i < len; i++) {
                                    if (newDbkObject[propName][i].hasOwnProperty("geometry"))
                                        delete newDbkObject[propName][i]["geometry"];
                                }
                            }
                        }
                    }
                }
            }
        }

        // Modify "verblijftijden", HH:MM:SS becomes HH:MM.
        if ((newDbkObject.verblijf) && (newDbkObject.verblijf.length)) {
            for (i = 0, len = newDbkObject.verblijf.length; i < len; i++) {
                verblijf = newDbkObject.verblijf[i];
                if (verblijf.begintijd) {
                    verblijf.begintijd = this.stripSeconds(verblijf.begintijd);
                }
                if (verblijf.eindtijd) {
                    verblijf.eindtijd = this.stripSeconds(verblijf.eindtijd);
                }
            }
        }

        // Add full path to media files.
        mediaPath = this.config.mediaPath;
        // Add slash.
        if (mediaPath.slice(-1) !== "/")
            mediaPath += "/";
        if ((newDbkObject.media) && (newDbkObject.media.length)) {
            for (i = 0, len = newDbkObject.media.length; i < len; i++) {
                media = newDbkObject.media[i];
                // Only images are used in the print.
                if (media.filetype === "afbeelding") {
                    // Has url?
                    if (media.URL) {
                        // No path yet?
                        if (media.URL.slice(0, 4) !== "http") {
                            // Add path.
                            media.URL = mediaPath + media.URL;
                        }
                    }
                }
            }
        }

        // Return the dbk object info.
        return newDbkObject;
    },

    getExtraLayers: function () {
        var result = [{
                url: this.options.printWMSPath,
                layers: this.options.printLayerNames,
                format: this.options.printFormat,
                transparent: this.options.printTransparent,
                srs: this.options.printSRS,
                alpha: this.options.printAlpha
            }];
        return result;
    },

    getPrintPropertyNames: function () {
        var propNames = [
            "adres_id",
            "formele_naam",
            "informele_naam",
            "bhv_aanwezig",
            "gebouwconstructie",
            "oms_nummer",
            "gebruikstype",
            "bouwlaag_max",
            "bouwlaag",
            "verblijf",
            "straatnaam",
            "huisnummer",
            "postcode",
            "plaats",
            "bijzonderheid",
            "contacten",
            "verdiepingen",
            "media",
            "danger_symbols"];
        return propNames;
    }

};