#!/bin/sh

MOUNTPOINT="$HOME/GoogleDrive-antiX"
REMOTE="GoogleDrive"

# Si no está montado, no hacer nada
if ! mountpoint -q "$MOUNTPOINT"; then
    notify-send "Google Drive" "No estaba montado"
    exit 0
fi

# Matar rclone y desmontar
pkill -f "rclone mount $REMOTE:" 2>/dev/null
fusermount -uz "$MOUNTPOINT"

sleep 1

# Confirmación
if ! mountpoint -q "$MOUNTPOINT"; then
    notify-send "Google Drive" "Desmontado correctamente ⏏️"
else
    notify-send "Google Drive" "No se pudo desmontar ❌"
fi
