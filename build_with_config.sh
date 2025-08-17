#!/bin/bash

# Build script for Flutter app with button configuration injection

CONFIG_FILE="${1:-button_configs/default.json}"
PLATFORM="${2:-linux}"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file '$CONFIG_FILE' not found!"
    exit 1
fi

# Read and format the JSON for dart-define
CONFIG_JSON=$(cat "$CONFIG_FILE" | tr -d '\n' | tr -d ' ')

echo "Building with configuration from: $CONFIG_FILE"
echo "Target platform: $PLATFORM"

# Build command with configuration injection
if [ "$PLATFORM" == "linux" ]; then
    flutter run -d linux --dart-define="BUTTONS_CONFIG=$CONFIG_JSON"
elif [ "$PLATFORM" == "apk" ]; then
    flutter build apk --dart-define="BUTTONS_CONFIG=$CONFIG_JSON"
elif [ "$PLATFORM" == "appbundle" ]; then
    flutter build appbundle --dart-define="BUTTONS_CONFIG=$CONFIG_JSON"
else
    echo "Unsupported platform: $PLATFORM"
    echo "Supported platforms: linux, apk, appbundle"
    exit 1
fi