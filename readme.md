# BrightSign HTML Virtual Keyboard

BrightSign virtual keyboard based on the [Mottie Keyboard](https://github.com/Mottie/Keyboard)


## How to build bsvirtualkb.html

- clone the repo
- Install npm (see http://blog.npmjs.org/post/85484771375/how-to-install-npm)
- run `npm i`
- Run `npm update`
- `npm install -g bower`
- `bower install`

- Run `gulp`
    - `gulp`
- This creates a "dest" directory containing:
    - bsvirtualkb.html (the main page)
    - autorun.brs that demonstrates how to use it
    - css directory
    - js directory 
    - bsvirtualkb.json (see below)
- This also creates "keyboard.zip" in the presentation directory
    
## bsvirtualkb.json

A config file that currently is only used to pick the languages available in the language dropdown. At present, the 
only languages supported are English and French.

## The plugin itself

The script that defines the plugin to be used in BrightAuthor(:Connected) is `virtualKeyboard.brs`, found in the presentation directory. This script is written so that the keyboard is dynamically sized and placed on the screen based on the screen's resolution. It also automatically rotates the keyboard based on the screen orientation selected in your presentation. Important variables in the plugin script are:

- `startCoordX`: top left x coordinate of the keyboard's rectangle
- `startCoordY`: top left y coordinate of the keyboard's rectangle
- `rectSizeX`: x dimension of the keyboard's rectangle
- `rectSizeY`: y dimension of the keyboard's rectangle
- `monitorOrientation`: orientation of the screen, set in BA(:Con)
- `transform`: rotation of the keyboard's rectangle in degrees, in the negative (-) direction by the Right Hand Rule
- __Note__ `Cint` simply rounds to the nearest integer

## Editing the Virtual Keyboard

There are three important aspects that users of the keyboard may want to change. These aspects are: placement, size, and orientation. All three of these are editted in the plugin script `virtualKeyboard.brs`. Assuming you are using the script provided in this plugin - 

To edit placement:
- Change the `startCoordX` and `startCoordY` variables

To edit size:
- Change the `rectSizeX` and `rectSizeY` variables

To edit orientation: 
- Change the `transform` variable, defined based on the monitor orientation

## Deploying the plugin

To integrate this plugin into BrightAuthor:Connected, obtain the `keyboard.zip` and `virtualKeyboard.brs` files from the "presentation" directory. Follow the following steps:

1. Navigate to __Presentation Settings > Support Content__
2. Under __Support Content__ click the __+__ beside __Script Plugin__ to add the plugin
    1. __Important:__ name the plugin "virtualKeyboard"
    2. Add the `virtualKeyboard.brs` file as the plugin
5. Click the __+__ next to __Files__ to add a file
    1. Name the file keyboard
    2. Add the `keyboard.zip` file to this __File__

To deploy the virtual keyboard in a BrightAuthor presentation, use the files in the "presentation" (`keyboard.zip`, `virtualKeyboard.brs`)directory for the following steps:

- Create a new presentation
    - Click "File->Presentation Properties"
    - Select the "Files" tab
        -  Add "keyboard.zip"
    - Select the "Autorun" tab
        - Under "Script Plugins" click "Add Script Plugin"
        - Select "virtualKeyboard.brs" and for the name enter "virtualKeyboard"

### BrightAuthor Examples

There are three example presentations that use the "virtualKeyboard.brs" plugin:

- ./presentation/KeyboardPres.bpf
- ./presentation/KeyboardPortraitBottomOnLeft.bpf
- ./presentation/KeyboardPortraitBottomOnRight.bpf
        

## Licensing

* Keyboard code: MIT License for all versions.
* Caret code by C. F., Wong (Cloudgen): MIT License
* Layouts files: Most are under WTFPL, unless the file itself specifies otherwise.
