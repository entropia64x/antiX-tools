#!/bin/bash

PROC="dropbox"

# Verificar si está corriendo
if ! pgrep -x "$PROC" > /dev/null; then
    notify-send "Dropbox" "Dropbox no está en ejecución."
    exit 0
fi

# Cierre limpio
if command -v dropbox >/dev/null 2>&1; then
    dropbox stop
else
    pkill -x dropbox
fi

sleep 2

# Confirmación
if pgrep -x "$PROC" > /dev/null; then
    notify-send "Dropbox" "No se pudo cerrar Dropbox."
else
    notify-send "Dropbox" "Dropbox detenido."
fi
