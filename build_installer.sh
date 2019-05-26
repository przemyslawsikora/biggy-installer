#!/bin/sh

APP_REF="biggy"
APP_NAME="Biggy"
APP_VERSION="1.0.0"

rm ${APP_REF}_${APP_VERSION}.run -f
cd installer
rm venv -Rf
rm artifacts -Rf
mkdir artifacts
python3 -m venv venv
. venv/bin/activate
pip install -r python_requirements.txt
#ansible-galaxy install -r ansible_requirements.yml
ansible-playbook main.yml -i localhost --vault-password-file ../password.txt --tags "build_installer" || exit 1
deactivate
chmod u+x run_installer.sh
cd ..
chmod u+x makeself.sh
./makeself.sh --gzip installer ${APP_REF}_${APP_VERSION}.run "$APP_NAME $APP_VERSION" ./run_installer.sh
