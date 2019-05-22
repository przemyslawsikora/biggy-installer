# Biggy Installer

### Prerequisites

1. Prepare server with Ubuntu
2. Type following commands
   ```bash
   sudo apt update
   sudo apt install python3-venv
   sudo apt install python3-pip

### How to build the installer?

Type following command
```bash
chmod u+x build_installer.sh
./build_installer.sh
```

### How to run the installer?

Type following command as root
```bash
./biggy_1.0.0.run single_machine.yml
```
