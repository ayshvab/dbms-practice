#!/bin/bash

# Download URL
download_url="https://edu.postgrespro.ru/demo-big.zip"

# Check if wget is installed
if ! command -v wget &> /dev/null; then
  echo "Error: wget is not installed. Please install wget before running this script."
  exit 1
fi

# Download the ZIP file
wget "$download_url"

unzip demo-big.zip

patch -u ./demo-big-20170815.sql ./fix_drop.patch

rm ./demo-big.zip

# Print success message
echo "Done"
