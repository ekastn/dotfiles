#!/bin/bash

# Identifikasi user asli untuk mengeksekusi dbus notify-send
REAL_USER=${SUDO_USER:-$USER}
USER_ID=$(id -u $REAL_USER)

notify() {
    sudo -u $REAL_USER DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus notify-send "Keyboard Status" "$1"
}

# Ekstrak event ID spesifik untuk internal keyboard
EVENT_NODE=$(awk '/Name="AT Translated Set 2 keyboard"/ {flag=1} flag && /Handlers=/ {match($0, /event[0-9]+/); print substr($0, RSTART, RLENGTH); exit}' /proc/bus/input/devices)

if [ -z "$EVENT_NODE" ]; then
    notify "Error: Internal AT Keyboard node not found ⚠️"
    exit 1
fi

PID_FILE="/tmp/disable_kbd_evtest.pid"

if [ -f "$PID_FILE" ]; then
    # Hentikan process evtest untuk re-enable keyboard
    kill $(cat "$PID_FILE") 2>/dev/null
    rm -f "$PID_FILE"
    notify "Internal Keyboard ENABLED 🟢"
else
    # Lakukan exclusive grab pada device node di background
    evtest --grab /dev/input/$EVENT_NODE > /dev/null 2>&1 &
    echo $! > "$PID_FILE"
    notify "Internal Keyboard DISABLED 🛑"
fi
