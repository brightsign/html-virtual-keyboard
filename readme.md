BrightSign HTML Virtual Keyboard
====================

How to build bsvirtualkb.html
----------------
- Install npm (see http://blog.npmjs.org/post/85484771375/how-to-install-npm)
- Run "npm update"
- npm install -g bower

- Run "gulp"
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
        
