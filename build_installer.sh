#!/bin/bash

APP_REF="biggy"
APP_NAME="Biggy"
APP_VERSION="1.0.0"

rm ${APP_REF}_${APP_VERSION}.run -f
cd installer
rm venv -Rf
rm artifacts -Rf
mkdir artifacts
wget http://archive.ubuntu.com/ubuntu/pool/main/p/python3-stdlib-extensions/python3-lib2to3_3.6.5-3_all.deb  -P artifacts || exit 1
wget http://archive.ubuntu.com/ubuntu/pool/main/p/python3-stdlib-extensions/python3-distutils_3.6.5-3_all.deb  -P artifacts || exit 1
python3 -m venv venv
source venv/bin/activate
pip install -r python_requirements.txt
#ansible-galaxy install -r ansible_requirements.yml
cd ..
ansible-playbook installer/main.yml -i installer/localhost --vault-password-file $1 --tags "build_installer" || exit 1
deactivate
cd installer
sed -i 's/VIRTUAL_ENV=.*/VIRTUAL_ENV="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}" )")" \&\& pwd)"/' venv/bin/activate
sed -i '1s/.*python.*/#!\/usr\/bin\/env python/' venv/bin/[a-zA-Z0-9]*
chmod u+x run_installer.sh
cd ..
chmod u+x makeself.sh
./makeself.sh --gzip installer ${APP_REF}_${APP_VERSION}.run "$APP_NAME $APP_VERSION" ./run_installer.sh