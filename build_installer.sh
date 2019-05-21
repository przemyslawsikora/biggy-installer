#!/usr/bin/env bash
cd installer
rm venv -Rf
python3 -m venv venv
source venv/bin/activate
pip install wheel
pip install ansible
ansible-galaxy install -r requirements.yml
deactivate
chmod u+x run_installer.sh
cd ..
chmod u+x makeself.sh
./makeself.sh --gzip installer biggy_1.0.0.run "Biggy 1.0.0" ./run_installer.sh
