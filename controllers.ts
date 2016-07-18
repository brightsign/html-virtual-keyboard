/**
 * Created by jsinai on 2/16/16.
 */
/// <reference path="app.ts"/>
/// <reference path="layouts.ts"/>

bsApp.controller('bsController', function ($scope, $filter, $translate, bsState, bsLayouts) {

    $scope.getKeys = function (row) {
        return bsLayouts.getKeys(row);
    };
    $scope.getKey = function (key) {
        if (key.length > 1) {
            return $filter('translate')(key);
        } else {
            return key;
        }
    };
    $scope.getClasses = function (key) {
        switch (key) {
            case 'enter':
            case 'accept':
                return 'active btn-primary';
            case 'cancel':
                return 'active btn-warning';
            case 'space':
                return 'ui-keyboard-space btn-default';
            default:
                return 'btn-default';
        }
    };
    $scope.clickMe = function (key) {
        switch (key) {
            case 'space':
                bsState.sendKey(' ');
                break;
            case 'enter':
                bsState.sendKey('ENTER');
                $scope.upper = false;
                $scope.loadLayout();
                break;
            case 'bksp':
                bsState.sendKey('BACKSPACE');
                break;
            case 'alt':
                $scope.alt = !$scope.alt;
                $scope.loadLayout();
                break;
            case 'shift':
                $scope.upper = !$scope.upper;
                $scope.loadLayout();
                break;
            case 'cancel':
                $scope.upper = false;
                $scope.loadLayout();
                bsState.hide();
                break;
            case 'accept':
                bsState.sendKey('ENTER');
                bsState.hide();
                break;
            default:
                bsState.sendKey(key);
        }
    };
    $scope.loadLayout = function () {
        var layout = $scope.upper ? ($scope.alt ? 'alt-shift' : 'shift') : ($scope.alt ? 'alt' : 'normal');
        $scope.rows = bsLayouts.getLayout($scope.lang, layout);
    };
    $scope.setLang = function (lang) {
        $scope.lang = lang;
        $translate.use($scope.lang);
        $scope.loadLayout();
    };
    bsState.loadConfig().then(function (ret) {
        $scope.config = ret.data;
        $scope.langs = $scope.config.languages;
    });
    $scope.lang = 'en';
    $scope.upper = false;
    $scope.alt = false;


    var portraitMode = $(window).width() < $(window).height();
    var screenSize;
    if (portraitMode) {
        screenSize = $(window).height();
    } else {
        screenSize = $(window).width();
    }
    var textSize;
    switch (screenSize) {
        case 1920:
            textSize = "1.6em";
            break;
        case 1280:
            textSize = "1.2em";
            break;
        default:
            textSize = "1em";
    }


    $scope.keyboardSize = {'font-size' : textSize};
    $scope.setLang($scope.lang);
});
