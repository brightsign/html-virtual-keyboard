# BrightSign HTML Virtual Keyboard

BrightSign virtual keyboard based on the [Mottie Keyboard](https://github.com/Mottie/Keyboard)

## How to build bsvirtualkb.html

### Clone

Clone this repo ([How to clone Github Repositories](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository))

```bash
git clone https://github.com/brightsign/html-virtual-keyboard.git
```

Install NPM / Node by following npmjs.com for a guide, otherwise proceed to the next step. Install npm (see http://blog.npmjs.org/post/85484771375/how-to-install-npm).

### Install

```bash
npm install
npm install -g bower
bower install
```

### Bundle

Gulp is currently used to bundle the keyboard.

Install: 

```bash
npm install -g gulp
```

```bash
gulp
```

This creates a "dest" directory containing:
* *bsvirtualkb.html* (the main page)
* *autorun.brs* that demonstrates how to use it in your own BrightScript application
* *css* directory
* *js* directory
* *bsvirtualkb.json* (see below)

__Important__: Lastly it creates */presentation/keyboard.zip* which is what is required below.

## bsvirtualkb.json

A config file that currently is only used to pick the languages available in the language dropdown. At present, the 
only languages supported are English and French.

## The Virtual Keyboard

The */virtualKeyboard.brs* is a BrightScript plugin added to the BrightAuthor:connected presentation, allowing custom BrightScript to overlay on top of the presentation, resulting in a BrightScript Object overlaid on top of the HTML Widget. This script is written so that the keyboard is dynamically sized and placed on the screen based on the screen's resolution. It also automatically rotates the keyboard based on the screen orientation selected in your presentation. 

Important variables in the plugin script are:

* `startX`: top left x coordinate of the keyboard's rectangle
* `startY`: top left y coordinate of the keyboard's rectangle
* `rectX`: x dimension of the keyboard's rectangle
* `rectY`: y dimension of the keyboard's rectangle
* `monitorOrientation`: orientation of the screen, set in BA(:Con)
* `transform`: rotation of the keyboard's rectangle in degrees, in the negative (-) direction by the Right Hand Rule
* __Note__ `Cint` simply rounds to the nearest integer

### Editing the Virtual Keyboard

There are three important aspects that users of the keyboard may want to change. These aspects are: placement, size, and orientation. All three of these could be edited in the plugin script *virtualKeyboard.brs* or for more granular control, the *keyboard.css*.

### virtualKeyboard.brs

To edit placement:

* Change the `startCoordX` and `startCoordY` variables

To edit size:

* Change the `rectSizeX` and `rectSizeY` variables

To edit orientation:

* Change the `transform` variable, based on intended the monitor orientation.
* __Important__: the orientation of your Presentation and / or Screens Layout in BrightAuthor, may conflict with updates applied in the plugin script. 
It's recommend to test the keyboard once orientation is understood and defined in BrightAuthor:connected to ensure the keyboard is placed as intended.

### keyboard.css

It may be the case the values edited in the virtualKeyboard.brs are not sufficient to place the keyboard as intended, or complex. At the top of the *keyboard.css* file, an overview is given to describe how to edit the size or location.

Keep in mind if the *keyboard.css* is updated, a new bundle should be created through running `gulp` at the command prompt, to update the *keyboard.zip* files - this file will be updated and should be published to the player again, through BrightAuthor:connected if this was your original method of deployment.

> To update the size of the keyboard, a few CSS Attributes could be considered:
> - change the font-size of the .ui-keyboard div
> - change the font-size of the .btn and .language-menu
> - change the CSS values associated with the CSS Transform Scale attribute.
> 
> To update the location of the keyboard, a few CSS Attributes could be considered:
> - change the CSS Attributes top or left of the div.ui-keyboard-container

## Deploying the keyboard

To integrate this plugin and HTML Keyboard into a BrightAuthor:Connected presentation, obtain the *keyboard.zip* and *virtualKeyboard.brs* files from the "presentation" directory. Follow the following steps:

1. Navigate to __Presentation Settings > Support Content__
2. Under __Support Content__ click the __+__ beside __Script Plugin__ to add the plugin
    1. __Important:__ name the plugin `virtualKeyboard`
    2. Add the *~/virtualKeyboard.brs* file as the plugin
3. Click the __+__ next to __Files__ to add a file
    1. Name the file keyboard
    2. Add the *~/presentation/keyboard.zip* file to this __File__.

To deploy the virtual keyboard in a BrightAuthor presentation, use the files in the "presentation" (*keyboard.zip*, *virtualKeyboard.brs*)directory for the following steps:

* Create a new presentation
  * Click "File->Presentation Properties"
  * Select the "Files" tab
    * Add *keyboard.zip*
  * Select the "Autorun" tab
    * Under "Script Plugins" click "Add Script Plugin"
    * Select *virtualKeyboard.brs* and for the name enter `virtualKeyboard`

## Debugging the Keyboard

The keyboard is exposed to the Chrome DevTools when they're enabled on the BrightSign's roHtmlWidget or roNodeJs widget, or BrightAuthor. 

Info can be found at the [Product Documentation for Debugging Webpages](https://brightsign.atlassian.net/wiki/spaces/DOC/pages/370672286/HTML+Best+Practices#Debugging-Webpages).

### BrightAuthor Examples

There are a few example presentations that use the *virtualKeyboard.brs* plugin and *keyboard.zip* files found in the "presentation" directory. Open these using [BrightAuthor:connected](https://www.brightsign.biz/resources/software-downloads/).

BrightAuthor:connected

* ./presentation/KeyboardPres-BrightAuthorConnected.bpfx

BrightAuthor

* ./presentation/KeyboardPres.bpf
* ./presentation/KeyboardPortraitBottomOnLeft.bpf
* ./presentation/KeyboardPortraitBottomOnRight.bpf

## Licensing

* Keyboard code: MIT License for all versions.
* Caret code by C. F., Wong (Cloudgen): MIT License
* Layouts files: Most are under WTFPL, unless the file itself specifies otherwise.
