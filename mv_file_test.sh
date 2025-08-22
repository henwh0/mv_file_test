#!/bin/bash

TARGET_DIRECTORY="$1"
DESTINATION_DIRECTORIES=( "Docs" "Pics" )

# Ensure target directory is provided and exists
if [[ -z "$TARGET_DIRECTORY" || ! -d "$TARGET_DIRECTORY" ]]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi
# Create destination directories if they don't exist
for directory in "${DESTINATION_DIRECTORIES[@]}"; do
    DEST_PATH="$HOME/$directory"
    if [ -e "$DEST_PATH" ]; then
        echo "$DEST_PATH already exists"
    else
        echo "$DEST_PATH does not exist. Creating now"
        mkdir -p "$DEST_PATH"
    fi
done
# Copy files based on extension
shopt -s nullglob
for file in "$TARGET_DIRECTORY"/*; do
    if [[ "$file" == *.pdf ]]; then
        echo "Copying $file to $HOME/Docs"
        cp "$file" "$HOME/Docs"
    elif [[ "$file" == *.jpg ]]; then
        echo "Copying $file to $HOME/Pics"
        cp "$file" "$HOME/Pics"
    else
        echo "Skipping $file"
    fi
done
echo "Done"
