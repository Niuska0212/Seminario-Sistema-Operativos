#!/bin/bash
echo "Creando el archivo mytext con la cadena 'Hola Mundo'..."
echo "Hola Mundo" > mytext
echo
echo "Mostrando el contenido de mytext:"
cat mytext
echo
echo "Creando el directorio backup..."
mkdir backup
echo
echo "Moviendo mytext al directorio backup..."
mv mytext backup/
echo
echo "Listando el contenido del directorio backup:"
ls backup
echo
echo "Eliminando mytext del directorio backup..."
rm backup/mytext
echo
echo "Eliminando el directorio backup..."
rmdir backup
