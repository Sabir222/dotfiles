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

def add_to_git(target_path):
    subprocess.run(["git", "-C", target_path, "add", "."])
    subprocess.run(["git", "-C", target_path, "commit", "-m", "update: update dotfiles"])
    subprocess.run(["git", "-C", target_path, "push"])

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
            else:
                shutil.copy(source, target)
                print(f"Copied file '{source}' to '{target}'")
        else:
            print(f"File or directory '{source}' does not exist.")

        add_to_git(os.path.dirname(target))

if __name__ == "__main__":
    main()
# import os
# import shutil
#
# def copy_to_dotfiles(source_path, target_path):
#     if os.path.exists(target_path):
#         if os.path.isdir(target_path):
#             shutil.rmtree(target_path)  # Remove existing directory and its contents
#         else:
#             os.remove(target_path)  # Remove existing file
#     shutil.copytree(source_path, target_path)  # Copy entire directory recursively
#
# def main():
#     # Define the files and directories to check for
#     files_and_directories = {
#         "~/.zshrc": "~/dotfiles/.zshrc",
#         "~/.bashrc": "~/dotfiles/.bashrc",
#         "~/.tmux.conf": "~/dotfiles/.tmux.conf",
#         "~/.config/nvim/": "~/dotfiles/nvim",
#         "~/.config/bspwm/": "~/dotfiles/bspwm",
#         "~/.config/sxhkd/": "~/dotfiles/sxhkd",
#         "~/.config/polybar/": "~/dotfiles/polybar"
#     }
#
#     for source, target in files_and_directories.items():
#         source = os.path.expanduser(source)  # Expand ~ in paths
#         target = os.path.expanduser(target)
#
#         if os.path.exists(source):
#             if os.path.isdir(source):
#                 copy_to_dotfiles(source, target)
#                 print(f"Copied directory '{source}' to '{target}'")
#             else:
#                 shutil.copy(source, target)
#                 print(f"Copied file '{source}' to '{target}'")
#         else:
#             print(f"File or directory '{source}' does not exist.")
#
# if __name__ == "__main__":
#     main()
