BrightSign HTML Virtual Keyboard
====================
The repository is at:
gitolite@bs-git01.brightsign:html-virtual-keyboard

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
    
Everything in the dest directory (except the autorun) is required in order to deploy the virtual keyboard.
    
bsvirtualkb.json
----------------
A config file that currently is only used to pick the languages available in the language dropdown. At present, the 
only languages supported are English and French.
