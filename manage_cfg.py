import os
import shutil
import subprocess

def copy_to_dotfiles(source_path, target_path):
    if os.path.exists(target_path):
        if os.path.isdir(target_path):
            shutil.rmtree(target_path)  # Remove existing directory and its contents
        else:
            os.remove(target_path)  # Remove existing file
    shutil.copytree(source_path, target_path)  # Copy entire directory recursively

def remove_git_dir(directory):
    git_dir = os.path.join(directory, ".git")
    if os.path.exists(git_dir):
        shutil.rmtree(git_dir)
        print(f"Removed .git directory from {directory}")

def main():
    # Define the files and directories to check for
    files_and_directories = {
        "~/.zshrc": "~/dotfiles/.zshrc",
        "~/.bashrc": "~/dotfiles/.bashrc",
        "~/.tmux.conf": "~/dotfiles/.tmux.conf",
        "~/.config/nvim/": "~/dotfiles/nvim",
        "~/.config/bspwm/": "~/dotfiles/bspwm",
        "~/.config/sxhkd/": "~/dotfiles/sxhkd",
        "~/.config/polybar/": "~/dotfiles/polybar"
    }

    for source, target in files_and_directories.items():
        source = os.path.expanduser(source)  # Expand ~ in paths
        target = os.path.expanduser(target)

        if os.path.exists(source):
            if os.path.isdir(source):
                copy_to_dotfiles(source, target)
                print(f"Copied directory '{source}' to '{target}'")
                if "nvim" in target:  # Check if the target is the Neovim configuration directory
                    remove_git_dir(target)  # Remove .git directory from the copied Neovim configuration
            else:
                shutil.copy(source, target)
                print(f"Copied file '{source}' to '{target}'")
        else:
            print(f"File or directory '{source}' does not exist.")
    
    # Add, commit, and push changes to GitHub
    dotfiles_dir = os.path.expanduser("~/dotfiles")
    subprocess.run(["git", "-C", dotfiles_dir, "add", "."])
    subprocess.run(["git", "-C", dotfiles_dir, "commit", "-m", "Update dotfiles"])
    subprocess.run(["git", "-C", dotfiles_dir, "push"])

if __name__ == "__main__":
    main()
