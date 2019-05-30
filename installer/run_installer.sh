#!/bin/bash

dpkg -i artifacts/python3-lib2to3_3.6.5-3_all.deb
dpkg -i artifacts/python3-distutils_3.6.5-3_all.deb
chmod u+x -R venv
source venv/bin/activate
ansible-playbook main.yml -i "$USER_PWD/$1" --ask-vault-pass --skip-tags "build_installer"
deactivate