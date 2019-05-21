#!/usr/bin/env bash
source venv/bin/activate
ansible-playbook main.yml -i production --ask-vault-pass