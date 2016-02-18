/**
 * Created by jsinai on 2/16/16.
 */
/// <reference path="app.ts"/>

bsApp.controller('bsController', function ($scope, $filter, $translate, bsState) {

    $scope.getKeys = function (row) {
        return bsState.getKeys(row);
    };
    $scope.getKey = function (key) {
        if (key.length>1){
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
            case 'enter':
                bsState.sendKey('ENTER');
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
        $scope.rows = bsState.getLayout($scope.lang, layout);
    };
    $scope.setLang=function(lang) {
        $scope.lang = lang;
        $translate.use($scope.lang);
        $scope.loadLayout();
    };
    $scope.lang = 'en';
    $scope.upper = false;
    $scope.alt = false;
    $scope.setLang($scope.lang);
});
