/// <reference path="/Users/jsinai/Library/Preferences/WebStorm11/javascript/extLibs/http_github.com_borisyankov_DefinitelyTyped_raw_master_angularjs_angular.d.ts" />

'use strict';

/* BrightSign AngularJS Module */

var bsApp = angular.module('bsApp', ['ngSanitize', 'pascalprecht.translate']);

bsApp.config(function ($translateProvider) {
    $translateProvider
        .translations('en', {
            accept: 'Accept',
            alt: 'Alt',
            bksp: 'Bksp',
            cancel: 'Cancel',
            enter: 'Enter',
            shift: 'Shift',
            space: '&nbsp;',
            tab: '\u21e5 Tab'
        })
        .translations('fr', {
            accept: 'Valider',
            alt: 'AltGr',
            bksp: '\u2190Suppr',
            cancel: 'Annuler',
            enter: 'Entr\u00e9e',
            shift: 'Maj',
            space: '&nbsp;',
            tab: '\u21e5 Tab'
        });
    $translateProvider.preferredLanguage('en');
    // Need this for the unicode chars to show up
    // See http://angular-translate.github.io/docs/#/guide/19_security
    $translateProvider.useSanitizeValueStrategy('escape');
});