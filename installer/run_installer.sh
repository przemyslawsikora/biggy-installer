#!/usr/bin/env bash
source venv/bin/activate
ansible-playbook main.yml -i "$USER_PWD/$1" --skip-tags "build_installer"
deactivate