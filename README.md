# Biggy Installer

Biggy Installer allows you to install the Biggy system very easily without Internet access.  
Biggy system contains:
- Zookeeper
- Kafka (port 9093)
- Schema Registry (port 8085)
- Spark (http://localhost:8500)
- MongoDB  
  port: 27017  
  root username: mongoadmin (change it in vars/global.yml)  
  root password: mongo12345 (change it in vars/passwords)
- Elasticsearch (ports 9200, 9300)
- KafkaHQ (http://localhost:8080)
- NiFi (http://localhost:8081/nifi)
- ElasticHQ (http://localhost:5000)
- Kibana (http://localhost:5601)
- Glances (http://localhost:61208)

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
   **Note:** You should keep this file as secret file in Jenkins rather than create it by your own inside the repository.  
   Don't add this file to GIT control!
7. Build the installer by typing
   ```bash
   sudo chmod u+x build_installer.sh
   sudo bash build_installer.sh password.txt
   ```

To allow Jenkins to build the installer and publish it into Nexus, you must define following variables in Jenkins:

| Credential ID / Variable | Kind                                | Description                                              |
|--------------------------|-------------------------------------|----------------------------------------------------------|
| nexus_admin              | Credential / Username with password | Username and password to your Nexus                      |
| vault                    | Credential / Secret file            | File password.txt with vault password (default is 12345) |
| nexus_address            | Environment variable                | Address to your Nexus, e.g. https://nexus.example.com    |

### How to run the installer?

Installation on a single machine:
1. Prepare server with Ubuntu 18.04 LTS (Bionic Beaver)
2. Copy <code>biggy_1.0.0.run</code> and <code>single_machine.yml</code> files into target machine
3. Type following commands
   ```bash
   sudo chmod u+x biggy_1.0.0.run
   sudo bash biggy_1.0.0.run single_machine.yml
   ```
