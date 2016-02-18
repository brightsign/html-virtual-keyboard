/// <reference path="app.ts"/>
/// <reference path="layouts.ts"/>

'use strict';

bsApp.factory('bsVirtualKb',
    function () {
        return new BSVirtualKeyboard();
    }
);

bsApp.service('bsState',
    function ($http, bsVirtualKb) {
        this.sendKey = function (key) {
            console.log("Sending key " + key);
            bsVirtualKb.SendKey(key);
        };
        this.hide = function () {
            console.log("Hiding");
            bsVirtualKb.Hide();
        };
        this.loadConfig = function() {
            return $http({
                method: 'GET',
                url: 'bsvirtualkb.json',
                transformResponse: function (data) {
                    return JSON.parse(data);
                }
            });
        };
    });

