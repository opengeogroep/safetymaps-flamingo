/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};
safetymaps.safetymapsCreator = safetymaps.safetymapsCreator || {};

safetymaps.safetymapsCreator.renderGeneral = function (object, window) {
    var fields = ["l", "html"];
    var columns = [
        {text: '', dataIndex: 'l'},
        {text: '', dataIndex: 'html'}
    ];
    var conf = {tabName: "General",
        fields: fields,
        columns: columns
    };
    var rows = safetymaps.creator.renderGeneral(object);
    var values = [];
    $.each(rows, function (i, row) {
        if (row.t || row.html) {
            row.html = row.html ? row.html : Mustache.escape(row.t);
            values.push(row);
        }
    });
    window.createGrid(conf, values, {});

};

safetymaps.safetymapsCreator.renderDetails = function (object, window) {
    var tabs = safetymaps.creator.renderDetails(object);
    var values = [];
    for (var i = 0; i < tabs.length; i++) {
        var fields = [];
        var columns = [];
        var tab = tabs[i];
        $.each(tab.rows, function (i, row) {
            if (i === 0) {
                for (var key in row) {
                    fields.push(key);
                    columns.push({text: row[key], dataIndex: key});
                }
            } else if (row.t || row.html) {
                row.html = row.html ? row.html : Mustache.escape(row.t);
                values.push(row);
            }
        });
        var conf = {tabName: tab.name,
            fields: fields,
            columns: columns
        };

        window.createGrid(conf, values, {});
    }
};

safetymaps.safetymapsCreator.renderOccupancy = function (object, window) {
    var rows = safetymaps.creator.renderOccupancy(object);
    var fields = [];
    var columns = [];
    var values = [];
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (i === 0) {
            for (var key in row) {
                fields.push(key);
                columns.push({text: row[key], dataIndex: key});
            }
        } else {
            var obj = {};
            for (var key in row) {
                obj[key] = row[key];
            }
            values.push(obj);
        }
    }
    var conf = {tabName: i18n.t("creator.occupancy"),
        fields: fields,
        columns: columns
    };
    if (values && values.length) {
        window.createGrid(conf, values, {});
    }

};

safetymaps.safetymapsCreator.renderContacts = function (object, window) {
    var rows = safetymaps.creator.renderContacts(object);
    var fields = [];
    var columns = [];
    var values = [];
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (i === 0) {
            for (var key in row) {
                fields.push(key);
                columns.push({text: row[key], dataIndex: key});
            }
        } else {
            var obj = {};
            for (var key in row) {
                obj[key] = row[key];
            }
            values.push(obj);
        }
    }
    var conf = {tabName: i18n.t("creator.contacts"),
        fields: fields,
        columns: columns
    };
    if (values && values.length) {
        window.createGrid(conf, values, {});
    }
};

safetymaps.safetymapsCreator.renderMedia = function (object, window) {
    var carousel = safetymaps.creator.renderMedia(object);
    safetymaps.safetymapsCreator.embedPDFs(carousel);
    
    if (carousel && carousel.length) {
        window.createCarousel(carousel);
    };
};

safetymaps.safetymapsCreator.embedPDFs = function(element) {
    $.each($(element).find(".pdf-embed"), function(i, pdf) {
        if(pdf.children.length === 0) {
            var url = safetymaps.utils.getAbsoluteUrl($(pdf).attr("data-url"));
            console.log($(pdf));
            $(pdf)[0].outerHTML = '<div><a href="' + url + '" target="_blank"><h2>' + "download"  + '</h2></a></div>'
        }         
    });
};

safetymaps.safetymapsCreator.renderFloors = function (object, window) {
    var me = this;
    var floors = safetymaps.creator.renderFloors(object);
    var fields = [];
    var columns = [];
    var values = [];
    for (var i = 0; i < floors.length; i++) {
        var row = floors[i];
        if (i === 0) {
            for (var key in row) {
                fields.push(key);
                columns.push({text: row[key], dataIndex: key});
            }
        } else {
            var obj = {object:object};
            for (var key in row) {
                obj[key] = row[key];
            }
            values.push(obj);
        }
    }
    var conf = {tabName: i18n.t("creator.floors"),
        fields: fields,
        columns: columns
    };
    if (values && values.length) {
        var callback = {scope: me, fn: me.floorClicked};
        window.createGrid(conf, values, callback);
    }
};

safetymaps.safetymapsCreator.renderSymbols = function (object, window, type) {
    var rows;
    var name;
    if (type === "normal") {
        name = i18n.t("creator.symbols");
        rows = safetymaps.creator.renderSymbols(object);
    } else if (type === "danger") {
        name = i18n.t("creator.danger_symbols");
        rows = safetymaps.creator.renderDangerSymbols(object);
    }
    var fields = [];
    var columns = [];
    var values = [];
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (i === 0) {
            for (var key in row) {
                fields.push(key);
                columns.push({text: row[key], dataIndex: key});
            }
        } else {
            var obj = {};
            for (var key in row) {
                obj[key] = row[key];
            }
            values.push(obj);
        }
    }
    var conf = {tabName: name,
        fields: fields,
        columns: columns
    };
    if (values && values.length) {
        window.createGrid(conf, values, {});
    }

};
