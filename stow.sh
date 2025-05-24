#!/bin/bash

# Define the target base directory (something/)
target_base_dir="$HOME/personal/dotfiles"

# List all directories in ~/.config
for dir in "$HOME/personal/dotfiles/.config"/*; do
  if [ -d "$dir" ]; then
    # Get the directory name without the full path
    dir_name=$(basename "$dir")
    
    # Define the target directory path
    target_dir="$target_base_dir/$dir_name/.config/$dir_name"
    
    # Create the target directory if it doesn't exist
    mkdir -p "$(dirname "$target_dir")"
    
    # Move the directory
    mv "$dir" "$target_dir"
    
    
    echo "Moved and set up $dir_name with Stow."
  fi
done

