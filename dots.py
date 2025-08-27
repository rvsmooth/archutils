from git import Repo
import os
import subprocess

home = os.path.expanduser("~")
clone_path = "/tmp/dotfiles"
dot_git_path = os.path.join(clone_path, ".git")
dot_git_dest_path = os.path.join(clone_path, ".dotfiles")
dotfiles_repo_url = "https://github.com/rvsmooth/dotfiles"
backup_dir = os.path.join(home, "backup")


def cp_cmd(target, dest):
    if target and dest:
        cmd = ["cp", "-rf", target, dest]
        subprocess.run(cmd)


def rm_cmd(target):
    if target:
        cmd = ["rm", "-rf", target]
        subprocess.run(cmd)


def main():
    if os.path.exists(clone_path):
        rm_cmd(clone_path)
    if not os.path.exists(backup_dir):
        os.mkdir(backup_dir)

    Repo.clone_from(dotfiles_repo_url, clone_path, branch="staging")

    if not os.path.exists(dot_git_dest_path):
        os.rename(dot_git_path, dot_git_dest_path)

    repo_objects = os.listdir(clone_path)
    for i in repo_objects:
        object = os.path.join(home, i)
        cp_cmd(target=object, dest=backup_dir)
    for i in repo_objects:
        object = os.path.join(clone_path, i)
        cp_cmd(target=object, dest=home)
