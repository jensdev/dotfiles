#!/bin/bash

set -euo pipefail

# Variables
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.1.1.0/android-studio-2024.1.1.0-linux.tar.gz"
INSTALL_DIR="/opt/android-studio"
SYMLINK_DIR="/usr/local/bin"
DESKTOP_FILE_DIR="/usr/share/applications"
DOWNLOAD_DIR=$(mktemp -d)

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check if Android Studio is already installed
if [ -d "$INSTALL_DIR" ]; then
  echo "Android Studio is already installed in $INSTALL_DIR. Skipping installation."
  exit 0
fi

echo "Downloading Android Studio..."
wget -q --show-progress -O "${DOWNLOAD_DIR}/android-studio.tar.gz" "$ANDROID_STUDIO_URL"

echo "Installing Android Studio to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
tar -xzf "${DOWNLOAD_DIR}/android-studio.tar.gz" -C "$INSTALL_DIR" --strip-components=1

echo "Creating symlink..."
ln -sf "${INSTALL_DIR}/bin/studio.sh" "${SYMLINK_DIR}/android-studio"

echo "Creating desktop entry..."
cat <<EOF > "${DESKTOP_FILE_DIR}/android-studio.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Icon=${INSTALL_DIR}/bin/studio.svg
Exec="${INSTALL_DIR}/bin/studio.sh" %f
Comment=The official IDE for Android app development
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-studio
EOF

echo "Cleaning up..."
rm -rf "$DOWNLOAD_DIR"

echo "Android Studio installation complete."
