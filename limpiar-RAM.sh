#!/bin/bash

clear
echo "========================================="
echo "   LIMPIEZA DE CACHE DE MEMORIA RAM"
echo "========================================="

# Función para mostrar secciones
section() {
    echo -e "\n\e[1;34m▶ $1\e[0m"
    echo "-----------------------------------------"
}

section "Limpiando RAM"
sudo sync && sudo sysctl -w vm.drop_caches=3

echo -e "\n\e[1;32m✅ ¡Limpieza completada!\e[0m"
echo -e "\e[3mLa ventana se cerrará en 2 segundos...\e[0m"

sleep 2
exit 0
