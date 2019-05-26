#!/bin/sh

. venv/bin/activate
ansible-playbook main.yml -i "$USER_PWD/$1" --ask-vault-pass --skip-tags "build_installer"
deactivate