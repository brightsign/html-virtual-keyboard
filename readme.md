BrightSign HTML Virtual Keyboard
====================
BrightSign virtual keyboard based on the [Mottie Keyboard](https://github.com/Mottie/Keyboard)

How to use the virtual keyboard
----------------
Download the files `keyboard.zip` and `virtualKeyboard.brs` from our [latest release](https://github.com/kev-ac/html-virtual-keyboard/releases/latest)
and continue reading [here](#brightauthor-plugin).

How to build bsvirtualkb.html
----------------
- Install npm (see http://blog.npmjs.org/post/85484771375/how-to-install-npm)
- Run "npm update"
- npm install -g bower
- bower install

- Run "gulp"
    - gulp
- This creates a "dest" directory containing:
    - bsvirtualkb.html (the main page)
    - autorun.brs that demonstrates how to use it
    - css directory
    - js directory 
    - bsvirtualkb.json (see below)
- This also creates "keyboard.zip" in the presentation directory   
    
bsvirtualkb.json
----------------
A config file that currently is only used to pick the languages available in the language dropdown. At present, the 
only languages supported are English and French.


BrightAuthor plugin
-------------------
There are three example presentations that use the "virtualKeyboard.brs" plugin:

- ./presentation/KeyboardPres.bpf
- ./presentation/KeyboardPortraitBottomOnLeft.bpf
- ./presentation/KeyboardPortraitBottomOnRight.bpf

To deploy the virtual keyboard in a BrightAuthor presentation, use the files in the "presentation" directory for the following steps:

- Create a new presentation
    - Click "File->Presentation Properties"
    - Select the "Files" tab
        -  Add "keyboard.zip"
    - Select the "Autorun" tab
        - Under "Script Plugins" click "Add Script Plugin"
        - Select "virtualKeyboard.brs" and for the name enter "virtualKeyboard"
        

Licensing
-------------------
* Keyboard code: MIT License for all versions.
* Caret code by C. F., Wong (Cloudgen): MIT License
* Layouts files: Most are under WTFPL, unless the file itself specifies otherwise.
