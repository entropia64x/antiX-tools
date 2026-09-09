#!/bin/bash

clear
echo "========================================="
echo "   REPARACIÓN DE LOCK DEL SISTEMA"
echo "========================================="
echo ""

# Obtener el PID de la terminal padre
TERM_PID=$(ps -o ppid= -p $$ | tr -d ' ')

# Función para mostrar secciones
section() {
    echo -e "\n\e[1;34m▶ $1\e[0m"
    echo "-----------------------------------------"
}

# Función para manejar errores
handle_error() {
    echo -e "\n\e[1;31m❌ Error en el paso: $1\e[0m"
    echo -e "\e[3mCerrando en 5 segundos...\e[0m"
    sleep 5
    kill -TERM $TERM_PID 2>/dev/null || exit 1
}

# Función para éxito
handle_success() {
    echo -e "\n\e[1;32m✅ ¡LOCK REPARADO!\e[0m"
    echo -e "\e[3mCerrando en 2 segundos...\e[0m"
    sleep 2
    kill -TERM $TERM_PID 2>/dev/null || exit 0
}

section "Borrando archivos de lock"
if sudo rm -rf /var/lib/dpkg/lock-frontend 2>/dev/null; then
    echo "✓ lock-frontend eliminado"
else
    echo "⚠ No se pudo eliminar lock-frontend (puede no existir)"
fi

if sudo rm -rf /var/lib/dpkg/lock 2>/dev/null; then
    echo "✓ lock eliminado"
else
    echo "⚠ No se pudo eliminar lock (puede no existir)"
fi

if sudo rm -rf /var/cache/apt/archives/lock 2>/dev/null; then
    echo "✓ lock de archives eliminado"
else
    echo "⚠ No se pudo eliminar lock de archives"
fi

section "Configurando dpkg"
if sudo dpkg --configure -a; then
    echo "✓ dpkg configurado correctamente"
else
    handle_error "Configuración de dpkg"
fi

section "Actualizando lista de paquetes"
if sudo apt update; then
    echo "✓ Lista de paquetes actualizada"
else
    handle_error "Actualización de paquetes"
fi

section "Verificando paquetes rotos"
if sudo apt install -f -y 2>/dev/null; then
    echo "✓ Paquetes rotos reparados"
else
    echo "ℹ No se encontraron paquetes rotos"
fi

handle_success
