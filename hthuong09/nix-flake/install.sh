#!/usr/bin/env bash
# Download file to /tmp
URL="https://github.com/xiamaz/YabaiIndicator/releases/download/0.3.4/YabaiIndicator-0.3.4.zip"
TMP_DIR="/tmp"
FILE_NAME="YabaiIndicator-0.3.4.zip"
EXTRACT_DIR="$TMP_DIR/YabaiIndicator-0.3.4"
DEST_DIR="/Applications"

# Download the file
curl -L $URL -o $TMP_DIR/$FILE_NAME

# Check if download was successful
if [ $? -ne 0 ]; then
  echo "Download failed!"
  exit 1
fi

# Extract the file
unzip $TMP_DIR/$FILE_NAME -d $TMP_DIR

# Check if extraction was successful
if [ $? -ne 0 ]; then
  echo "Extraction failed!"
  exit 1
fi

# Copy the extracted contents to /Applications
cp -R $EXTRACT_DIR/YabaiIndicator.app $DEST_DIR

# Check if copy was successful
if [ $? -ne 0 ]; then
  echo "Copy failed!"
  exit 1
fi

# Cleanup
rm $TMP_DIR/$FILE_NAME
rm -rf $EXTRACT_DIR

nix run nix-darwin -- switch --flake ~/hthuong09/nix-flake
