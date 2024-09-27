#!/bin/bash

# Verificacion de los parametros que fueron enviados, nombre de la maquina, tipo de so, la cpu, y la ram
if [ $# -ne 6 ]; then
    echo "Uso: $0 <nombre_vm> <tipo_os> <num_cpu> <ram_gb> <vram_mb> <hdd_size_gb>"
    exit 1
fi

# Argumentos
VM_NAME=$1        # Nombre de la Máquina Virtual
OS_TYPE=$2        # Tipo de Sistema Operativo
NUM_CPU=$3        # Número de CPUs
RAM_SIZE=$(( $4 * 1024 ))  # Convertir de GB a MB con esa operacion
VRAM_SIZE=$5      # Tamaño de la VRAM en MB
HDD_SIZE=$6       # Tamaño del disco duro en GB

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
VBoxManage createmedium disk --filename "$HDD_FILE" --size $(( $HDD_SIZE * 1024 )) --format VDI
echo "Disco duro virtual de $HDD_SIZE GB creado."

# Añadir y configurar el controlador SATA
VBoxManage storagectl "$VM_NAME" --name "$SATA_CONTROLLER" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "$SATA_CONTROLLER" --port 0 --device 0 --type hdd --medium "$HDD_FILE"
echo "Controlador SATA '$SATA_CONTROLLER' y disco duro '$HDD_FILE' asociados."

# Añadir y configurar el controlador IDE para CD/DVD
VBoxManage storagectl "$VM_NAME" --name "$IDE_CONTROLLER" --add ide
echo "Controlador IDE '$IDE_CONTROLLER' creado."

# Mostrar configuración final
VBoxManage showvminfo "$VM_NAME" --details
