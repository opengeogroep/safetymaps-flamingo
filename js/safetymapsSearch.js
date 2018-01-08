/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};

safetymaps.search = {
    config: {},
    features: [],
    constructor: function (conf) {
        this.config = conf;
    },

    createValues: function (features) {
        this.features = features;
    },

    checkFeatureForSearch: function (feature, searchResult, queryFields, queryFieldTypes, queryId, buffer) {
        //doet nu nog niks
    },

    getSearchResult: function (queryId, searchRequestId) {
        var buffer = 300;
        var searchResult = [];
        var queryFields = ["formele_naam","informele_naam"];
        try {
            for (var i = 0; i < this.features.length; i++) {
                var feature = this.features[i];
                this.getSearchFeatureData(searchResult, queryFields, [], queryId, feature, buffer);
            }
            var result = {
                success: true,
                errorMessage: "",
                results: searchResult,
                searchRequestId: searchRequestId
            };
        } catch (err) {
            result = {
                success: false,
                errorMessage: err.message,
                results: [],
                searchRequestId: searchRequestId
            };
        }
        return result;
    },

    getSearchFeatureData: function (searchResult, queryFields, queryFieldTypes, queryId, feature, buffer) {
        for (var i = 0; i < queryFields.length; i++) {
            if (feature.attributes.apiObject[queryFields[i]]) {
                if (feature.attributes.apiObject[queryFields[i]].toString().toLowerCase().indexOf(queryId) !== -1) {
                    var data = {
                        type: queryFields[i],
                        label: feature.attributes.apiObject.formele_naam,
                        location: {
                            minx: feature.geometry.x - buffer,
                            miny: feature.geometry.y - buffer,
                            maxx: feature.geometry.x + buffer,
                            maxy: feature.geometry.y + buffer
                        }
                    };
                    searchResult.push(data);
                }
            }
        }
    }

};
