/// <reference path="app.ts"/>

'use strict';

bsApp.service('bsLayouts',
    function () {
        // See https://github.com/Mottie/Keyboard/blob/master/layouts
        var layouts = {
            // 'international': Used for English layout
            en: {
                'normal': [
                    '` 1 2 3 4 5 6 7 8 9 0 - = {bksp}',
                    '{tab} q w e r t y u i o p [ ] \\',
                    'a s d f g h j k l ; \' {enter}',
                    '{shift} z x c v b n m , . / {shift}',
                    '{alt} {space} {alt}'
                ],
                'shift': [
                    '~ ! @ # $ % ^ & * ( ) _ + {bksp}',
                    '{tab} Q W E R T Y U I O P { } |',
                    'A S D F G H J K L : " {enter}',
                    '{shift} Z X C V B N M < > ? {shift}',
                    '{alt} {space} {alt}'
                ],
                'alt': [
                    '~ \u00a1 \u00b2 \u00b3 \u00a4 \u20ac \u00bc \u00bd \u00be \u2018 \u2019 \u00a5 \u00d7 {bksp}',
                    '{tab} \u00e4 \u00e5 \u00e9 \u00ae \u00fe \u00fc \u00fa \u00ed \u00f3 \u00f6 \u00ab \u00bb \u00ac',
                    '\u00e1 \u00df \u00f0 f g h j k \u00f8 \u00b6 \u00b4 {enter}',
                    '{shift} \u00e6 x \u00a9 v b \u00f1 \u00b5 \u00e7 > \u00bf {shift}',
                    '{alt} {space} {alt}'
                ],
                'alt-shift': [
                    '~ \u00b9 \u00b2 \u00b3 \u00a3 \u20ac \u00bc \u00bd \u00be \u2018 \u2019 \u00a5 \u00f7 {bksp}',
                    '{tab} \u00c4 \u00c5 \u00c9 \u00ae \u00de \u00dc \u00da \u00cd \u00d3 \u00d6 \u00ab \u00bb \u00a6',
                    '\u00c4 \u00a7 \u00d0 F G H J K \u00d8 \u00b0 \u00a8 {enter}',
                    '{shift} \u00c6 X \u00a2 V B \u00d1 \u00b5 \u00c7 . \u00bf {shift}',
                    '{alt} {space} {alt}'
                ]
            },
            // 'french-azerty-1'
            fr: {
                'normal': [
                    "\u00b2 & \u00e9 \" ' ( - \u00e8 _ \u00e7 \u00e0 ) = {bksp}",
                    "{tab} a z e r t y u i o p ^ $",
                    "q s d f g h j k l m \u00f9 * {enter}",
                    "{shift} < w x c v b n , ; : ! {shift}",
                    "{alt} {space} {alt}"
                ],
                'shift': [
                    // Intentional space at start of next line for empty key
                    " 1 2 3 4 5 6 7 8 9 0 \u00b0 + {bksp}",
                    "{tab} A Z E R T Y U I O P \u00a8 \u00a3",
                    "Q S D F G H J K L M % \u00b5 {enter}",
                    "{shift} > W X C V B N ? . / \u00a7 {shift}",
                    "{alt} {space} {alt}"
                ],
                'alt': [
                    "\u00b2 & ~ # { [ | ` \\ ^ @ ] } {bksp}",
                    "{tab} a z \u20ac r t y u i o p ^ \u00a4",
                    "q s d f g h j k l m \u00f9 * {enter}",
                    "{shift} < w x c v b n , ; : ! {shift}",
                    "{alt} {space} {alt}"
                ],
                'alt-shift': [
                    // Intentional space at start of next line for empty key
                    " 1 ~ # { [ | ` \\ ^ @ ] } {bksp}",
                    "{tab} A Z \u20ac R T Y U I O P \u00a8 \u00a4",
                    "Q S D F G H J K L M % \u00b5 {enter}",
                    "{shift} > W X C V B N ? . / \u00a7 {shift}",
                    "{alt} {space} {alt}"
                ]
            },
        };
        this.getLayout = function (keyboard, type) {
            var l = layouts[keyboard];
            var kb = l[type];
            return kb;
        };
        this.getKeys = function (kb) {
            var keys = kb.split(' ');
            var ret = [];
            keys.forEach(function (key) {
                // Strip off the curly braces
                if (/[{}]/) {
                    ret.push(key.replace(/{(.*)}/, "$1"));
                } else {
                    ret.push(key);
                }
            });
            return ret;
        };
    });

