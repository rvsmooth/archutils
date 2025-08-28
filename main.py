from json import load
from subprocess import run
from requests import get
import os
import dots
import prompt


def rvstall(install=None, remove=None, pkg_list=None, pkg=None):
    install_cmd = ["sudo", "pacman", "--noconfirm", "-S"]
    remove_cmd = ["sudo", "pacman", "-R", "--no-confirm"]
    check_cmd = ["sudo", "pacman", "-Qq"]

    if install and pkg_list:
        for package in app_list[pkg_list]:
            check_cmd = check_cmd[:3]
            check_cmd.append(package)
            is_available = run(check_cmd, capture_output=True)
            if is_available.returncode == 0:
                print(package, "is already installed")
            else:
                print("Installing", package)
                install_cmd = install_cmd[:4]
                install_cmd.append(package)
                install = run(install_cmd, capture_output=True)
                with open(r"error.txt", "a") as file_object:
                    print(install.stderr, file=file_object)

    elif install and pkg:
        check_cmd = check_cmd[:3]
        check_cmd.append(pkg)
        is_available = run(check_cmd, capture_output=True)
        print(is_available.returncode)
        if is_available.returncode == 0:
            print(pkg, "is already installed")
        else:
            print("Installing", pkg)
            install_cmd = install_cmd[:4]
            install_cmd.append(pkg)
            install = run(install_cmd, capture_output=True)
            with open(r"error.txt", "a") as file_object:
                print(install.stderr, file=file_object)

    elif remove and pkg_list:
        for package in app_list[pkg_list]:
            check_cmd = check_cmd[:3]
            check_cmd.append(package)
            is_available = run(check_cmd, capture_output=True)
            if is_available.returncode == 0:
                print(package, "is found")
                remove_cmd = remove_cmd[:4]
                remove_cmd.append(package)
                remove = run(remove_cmd, capture_output=True)
                with open(r"error.txt", "a") as file_object:
                    print(remove.stderr, file=file_object)
            else:
                print(package, "not found")

    elif remove and pkg:
        check_cmd = check_cmd[:3]
        check_cmd.append(pkg)
        is_available = run(check_cmd, capture_output=True)
        print(is_available.returncode)
        if is_available.returncode == 0:
            remove_cmd = remove_cmd[:4]
            remove_cmd.append(pkg)
            print(pkg, "is found")
            remove = run(remove_cmd, capture_output=True)
            with open(r"error.txt", "a") as file_object:
                print(remove.stderr, file=file_object)
        else:
            print(pkg, "not found")


def get_pkgs(url):
    x = get(url)
    # Save the file that is read as /tmp/packages.json
    with open(r"/tmp/packages.json", "w") as file_object:
        print(x.text, file=file_object)


# Check for the existence of packages.json
# Download if it doesn't exist
if os.path.exists("/tmp/packages.json"):
    with open("/tmp/packages.json", "r") as applist:
        app_list = load(applist)
else:
    get_pkgs(
        "https://raw.githubusercontent.com/rvsmooth/archutils/refs/heads/staging/packages.json"
    )
    with open("/tmp/packages.json", "r") as applist:
        app_list = load(applist)

# start the prompt
#
result = prompt.main()

# Install softwares based on the initial selection
# perfomed with a prompt
if result[0]:
    for i in result[0]:
        rvstall(install=True, pkg_list=i)

# Install dots conditionally
if result[1]:
    print("Dotfiles will be installed.")
    dots.main()
else:
    print("Dotfiles won't be installed.")

# Removes all the packages under remove-list in packages.json
# It's to be used to remove unneeded packages
# Or packages creating conflicts
rvstall(remove=True, pkg_list="remove-list")

# Install common packages
options = ["multimedia", "utilities", "user"]
for i in options:
    rvstall(install=True, pkg_list=i)

# Error check message
print("Check error.txt for any errors, before logging into ur system")
