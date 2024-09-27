#!/bin/bash

# mostrar el menú
function show_menu() {
    echo "---- Menú de Opciones ----"
    echo "1. Listar el contenido de un fichero (carpeta)"
    echo "2. Crear un archivo de texto con una línea de texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Mostrar el uso del comando awk"
    echo "5. Mostrar el uso del comando grep"
    echo "6. Salir"
    echo "--------------------------"
}

# Función para listar el contenido de un directorio
function list_directory() {
    read -p "Introduce la ruta absoluta del directorio: " directory_path
    if [ -d "$directory_path" ]; then
        echo "Contenido de $directory_path:"
        ls "$directory_path"
    else
        echo "El directorio no existe o no es válido."
    fi
}

# Función para crear un archivo de texto con una línea
function create_text_file() {
    read -p "Introduce el nombre del archivo a crear: " file_name
    read -p "Introduce la cadena de texto para almacenar: " text
    echo "$text" > "$file_name"
    echo "El archivo $file_name ha sido creado con la línea: $text"
}

# Función para comparar dos archivos de texto
function compare_files() {
    read -p "Introduce la ruta del primer archivo: " file1
    read -p "Introduce la ruta del segundo archivo: " file2
    if [ -f "$file1" ] && [ -f "$file2" ]; then
        echo "Comparando $file1 y $file2:"
        diff "$file1" "$file2"
    else
        echo "Uno o ambos archivos no existen."
    fi
}

# Función para mostrar un ejemplo de awk
function use_awk() {
    read -p "Introduce el archivo para usar awk: " file
    if [ -f "$file" ]; then
        echo "Ejemplo de awk para mostrar la primera columna del archivo:"
        awk '{print $1}' "$file"
    else
        echo "El archivo no existe."
    fi
}

# Función para mostrar un ejemplo de grep
function use_grep() {
    read -p "Introduce el archivo para usar grep: " file
    read -p "Introduce la palabra a buscar: " word
    if [ -f "$file" ]; then
        echo "Buscando '$word' en $file con grep:"
        grep "$word" "$file"
    else
        echo "El archivo no existe."
    fi
}

# Menú principal
while true; do
    show_menu
    read -p "Selecciona una opción (1-6): " option
    case $option in
        1) list_directory ;;
        2) create_text_file ;;
        3) compare_files ;;
        4) use_awk ;;
        5) use_grep ;;
        6) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida. Inténtalo de nuevo." ;;
    esac
    echo
done
