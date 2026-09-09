#!/bin/sh

MOUNTPOINT="$HOME/GoogleDrive-antiX"
REMOTE="GoogleDrive"

# Si ya está montado, no hacer nada
if mountpoint -q "$MOUNTPOINT"; then
    notify-send "Google Drive" "Ya está montado ✔"
    exit 0
fi

# Limpieza preventiva (por si quedó algo colgado)
pkill -f "rclone mount $REMOTE:" 2>/dev/null
fusermount -uz "$MOUNTPOINT" 2>/dev/null

sleep 1

# Montaje
rclone mount "$REMOTE:" "$MOUNTPOINT" \
  --vfs-cache-mode full \
  --dir-cache-time 72h \
  --poll-interval 1m \
  --daemon

# Confirmación
sleep 1
if mountpoint -q "$MOUNTPOINT"; then
    notify-send "Google Drive" "Montado correctamente ☁️"
else
    notify-send "Google Drive" "Error al montar ❌"
fi
