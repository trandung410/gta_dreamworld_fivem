ENGLISH:
Welcome to the VB-AC installation file. Remember that this script could have, a few bugs, as it was recently refactored.
If you find something that isn't working, feel free to open a Issue ticket on my GitHub.
I hope you enjoy every functionalities that this script has. This AC is free, but it detects a lot more things that other AC's that are paid.

ESPAÑOL:
Bienvenido al archivo de instalación del VB-AC. Recuerda que este script está en testeo, por lo que podría tener algún bug.
Si encuentras algo que no funciona, abre una incidencia en mi GitHub.
Espero que disfrutes todas las funcionalidades que trae este script, recuerdo que es gratis pero detecta más cosas que otros que son de pago.
Dicho esto, un saludo.

IMPORTANT - SERVER.CFG: THIS SCRIPT MUST BE STARTED AT THE END OF THE CFG!!!!!!!!!!!!!!!!
ensure menuv
ensure vbac-module2
ensure VB-AC

ADMIN BYPASSES (SERVER.CFG):

ADMIN BYPASS (INCLUDES ADMIN MENU):
add_ace vbacadmin allow 
add_ace identifier.steam:000000000000000 vbacadmin allow

ADMIN BYPASS (DOES NOT INCLUDE ADMIN MENU):
add_ace vbacbypass allow 
add_ace identifier.steam:000000000000000 vbacbypass allow
