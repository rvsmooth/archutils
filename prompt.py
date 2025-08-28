#!/usr/bin/env python
from InquirerPy import prompt
from sys import exit

question = [
    {
        "type": "checkbox",
        "message": "What do you want?",
        "choices": ["hyprland", "niri", "qtile"],
    },
    {
        "type": "confirm",
        "message": "Do you want to install dotfiles?",
        "confirm_letter": "y",
        "reject_letter": "n",
    },
]


def main():
    selection = prompt(question)
    if len(selection[0]) < 1:
        print("No window manager's selection \naborting")
        exit(1)
    return selection
