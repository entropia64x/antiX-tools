#!/bin/bash

clear
echo "========================================="
echo "   ACTUALIZACIÓN DEL SISTEMA antiX"
echo "========================================="

# Función para mostrar secciones
section() {
    echo -e "\n\e[1;34m▶ $1\e[0m"
    echo "-----------------------------------------"
}

section "Actualizando lista de paquetes"
sudo apt update

section "Actualizando paquetes"
sudo apt upgrade -y

section "Actualizando distribución"
sudo apt dist-upgrade -y

section "Eliminando paquetes innecesarios"
sudo apt autoremove -y

section "Limpiando cache"
sudo apt autoclean -y

echo -e "\n\e[1;32m✅ ¡Actualización completada!\e[0m"
echo -e "\e[3mLa ventana se cerrará en 2 segundos...\e[0m"

sleep 2
exit 0
