#!/usr/bin/env python3

import os
import shutil
import subprocess

# Directory where your dotfiles are stored
DOTFILES_DIR = os.path.expanduser("~/dotfiles")

# List of configuration files and directories to copy
CONFIG_ITEMS = [
    "~/test.ts"
    "~/test/"
    # "~/.zshrc",
    # "~/.bashrc",
    # "~/.tmux.conf",
    # "~/.gitconfig",
    # "~/.config/nvim/",
    # "~/.config/bspwm/",
    # "~/.config/sxhkd/",
    # "~/.config/polybar/",

]

# Expand user directories in CONFIG_ITEMS
CONFIG_ITEMS = [os.path.expanduser(item) for item in CONFIG_ITEMS]

# Loop through each configuration item and copy it to the dotfiles directory
for item in CONFIG_ITEMS:
    if os.path.exists(item):
        if os.path.isfile(item):
            # Copy files
            filename = os.path.basename(item)
            shutil.copy(item, os.path.join(DOTFILES_DIR, filename))
            print(f"Copied {item} to {os.path.join(DOTFILES_DIR, filename)}")
        elif os.path.isdir(item):
            # Copy directories
            dirname = os.path.basename(item)
            dst_dir = os.path.join(DOTFILES_DIR, dirname)
            if os.path.exists(dst_dir):
                shutil.rmtree(dst_dir)  # Remove existing directory
            shutil.copytree(item, dst_dir)
            print(f"Copied {item} to {dst_dir}")
    else:
        print(f"Skipping {item}: Not found or not a regular file/directory")
# Commit and push changes to GitHub
commit_message = "Update dotfiles"
try:
    subprocess.run(["git", "add", "."], cwd=DOTFILES_DIR, check=True)
    subprocess.run(["git", "commit", "-m", commit_message], cwd=DOTFILES_DIR, check=True)
    subprocess.run(["git", "push"], cwd=DOTFILES_DIR, check=True)
    print("Changes committed and pushed to GitHub successfully!")
except subprocess.CalledProcessError as e:
    print(f"Error: {e}")
