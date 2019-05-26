# Biggy Installer

### How to build the installer?

1. Prepare server with Ubuntu 18.04 LTS (Bionic Beaver)
2. Install Docker
   ```bash
   sudo apt-get remove docker docker-engine docker.io containerd runc
   sudo apt-get update
   sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io
   ```
3. Install python-venv and python-pip packages
   ```bash
   sudo apt update
   sudo apt install python3-venv python3-pip
   ```
4. Clone the repository (branch master)
5. Optional but recommended - change the default passwords in the file <code>passwords</code>  
   Default vault password used to open and edit the file is <code>12345</code>
   ```bash
   ansible-vault edit installer/vars/passwords
   ```
   Change also the vault password
   ```bash
   ansible-vault rekey installer/vars/passwords
   ```
   Note: vault password is used in both building and running the installer
6. Create a file <code>password.txt</code> with the vault password  
   To do this with default password <code>12345</code> just type:
   ```bash
   echo "12345" > password.txt
   ```
7. Build the installer by typing
   ```bash
   chmod u+x build_installer.sh
   sudo sh build_installer.sh
   ```

### How to run the installer?

Installation on the single machine:
1. Prepare server with Ubuntu 18.04 LTS (Bionic Beaver)
2. Copy <code>biggy_1.0.0.run</code> and <code>single_machine.yml</code> files into target machine
3. Type following command
   ```bash
   sudo sh biggy_1.0.0.run single_machine.yml
   ```
