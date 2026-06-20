#!/bin/bash

VIRTUAL_MIC="virtmic"
VIRTUAL_SINK="vsink"


load_modules() {
    echo "Loading virtual source (mic): '${VIRTUAL_MIC}'..."
    pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=${VIRTUAL_MIC} channel_map=front-left,front-right

    echo "Loading virtual sink: '${VIRTUAL_SINK}'..."
    pactl load-module module-null-sink sink_name=${VIRTUAL_SINK}

    echo ""
    echo "Virtual devices have been created."
}

unload_modules() {
    echo "Checking for existing modules..."

    MIC_ID=$(pactl list short modules | grep "sink_name=${VIRTUAL_MIC}" | awk '{print $1}' || true)
    if [[ -n "$MIC_ID" ]]; then
        echo "Unloading virtual source (mic) '${VIRTUAL_MIC}' with ID: $MIC_ID"
        pactl unload-module "$MIC_ID"
    else
        echo "-> Virtual source '${VIRTUAL_MIC}' not found, skipping."
    fi

    SINK_ID=$(pactl list short modules | grep "sink_name=${VIRTUAL_SINK}" | awk '{print $1}' || true)
    if [[ -n "$SINK_ID" ]]; then
        echo "Unloading virtual sink '${VIRTUAL_SINK}' with ID: $SINK_ID"
        pactl unload-module "$SINK_ID"
    else
        echo "-> Virtual sink '${VIRTUAL_SINK}' not found, skipping."
    fi

    echo ""
    echo "Virtual devices have been removed."
}

usage() {
    echo "Usage: $0 [load|unload]"
    echo "  load    : Creates the virtual audio source and sink."
    echo "  unload  : Removes the virtual audio source and sink."
    exit 1
}


if [ -z "$1" ]; then
    echo "Error: No argument provided."
    echo ""
    usage
fi

case "$1" in
    load)
        load_modules
        ;;
    unload)
        unload_modules
        ;;
    *)
        # Handle invalid arguments
        echo "Error: Invalid argument '$1'."
        echo ""
        usage
        ;;
esac

exit 0
