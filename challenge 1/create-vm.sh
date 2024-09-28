#!/bin/bash

# Función para solicitar datos al usuario
function pedir_dato() {
    local mensaje=$1
    local valor
    read -p "$mensaje: " valor
    echo "$valor"
}

# Solicitar los datos al usuario si no se proporcionan argumentos
VM_NAME=$(pedir_dato "Introduce el nombre de la Máquina Virtual")
OS_TYPE=$(pedir_dato "Introduce el tipo de Sistema Operativo (Ej: Linux_64)")
NUM_CPU=$(pedir_dato "Introduce el número de CPUs")
RAM_SIZE_GB=$(pedir_dato "Introduce el tamaño de la RAM en GB")
VRAM_SIZE=$(pedir_dato "Introduce el tamaño de la VRAM en MB")
HDD_SIZE_GB=$(pedir_dato "Introduce el tamaño del disco duro en GB")

# Convertir el tamaño de RAM a MB
RAM_SIZE=$(( RAM_SIZE_GB * 1024 ))

# Controladores
SATA_CONTROLLER="SATA_Controller"
IDE_CONTROLLER="IDE_Controller"
HDD_FILE="$VM_NAME.vdi"  # Nombre del archivo de disco duro virtual

# Crear la Máquina Virtual
VBoxManage createvm --name "$VM_NAME" --ostype "$OS_TYPE" --register
echo "Máquina virtual '$VM_NAME' creada."

# Configurar CPUs y Memoria
VBoxManage modifyvm "$VM_NAME" --cpus "$NUM_CPU" --memory "$RAM_SIZE" --vram "$VRAM_SIZE"
echo "Configurado: $NUM_CPU CPUs, $RAM_SIZE MB RAM, $VRAM_SIZE MB VRAM."

# Crear el disco duro virtual
VBoxManage createmedium disk --filename "$HDD_FILE" --size $(( HDD_SIZE_GB * 1024 )) --format VDI
echo "Disco duro virtual de $HDD_SIZE_GB GB creado."

# Añadir y configurar el controlador SATA
VBoxManage storagectl "$VM_NAME" --name "$SATA_CONTROLLER" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "$SATA_CONTROLLER" --port 0 --device 0 --type hdd --medium "$HDD_FILE"
echo "Controlador SATA '$SATA_CONTROLLER' y disco duro '$HDD_FILE' asociados."

# Añadir y configurar el controlador IDE para CD/DVD
VBoxManage storagectl "$VM_NAME" --name "$IDE_CONTROLLER" --add ide
echo "Controlador IDE '$IDE_CONTROLLER' creado."

# Mostrar configuración final
VBoxManage showvminfo "$VM_NAME" --details
