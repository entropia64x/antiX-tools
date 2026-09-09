#!/bin/bash

# Nombre del proceso
PROC="dropbox"

# Comprobar si Dropbox ya está corriendo
if pgrep -x "$PROC" > /dev/null; then
    notify-send "Dropbox" "Dropbox ya está en ejecución."
    exit 0
fi

# Iniciar Dropbox
if command -v dropbox >/dev/null 2>&1; then
    dropbox start >/dev/null 2>&1 &
else
    ~/.dropbox-dist/dropboxd >/dev/null 2>&1 &
fi

sleep 2

# Verificación final
if pgrep -x "$PROC" > /dev/null; then
    notify-send "Dropbox" "Dropbox iniciado correctamente."
else
    notify-send "Dropbox" "Error al iniciar Dropbox."
fi
