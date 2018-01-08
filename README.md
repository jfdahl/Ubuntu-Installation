# Ubuntu-Installation
Scripts to install and configure a basic Ubuntu CORE system with options for gui and productivity apps

# Base Installation
1. Boot up the mini.iso disk, usb drive, or image file (for vm).
- Select install
- Select the appropriate items:
   - language
   - keyboard
   - network card
- Enter a hostname
- Select a mirror and set the proxy server
- Wait for additional components
- Set the default user information
- Set home directory encryption
- Set the timezone
- Setup HDD
    - Suggestion to create 1 primary ext4 partition
    - A swap file will be created by the post-install setup script
- Set the automatic update selection
    - Default: "No automatic udpates"
- Select software
    - Default: standard system utilities
    - Add: OpenSSH server
- Install Grub to master boot record
- Complete installation and shutdown the system.
- Remove the installation media and restart the system.

# Prepare to configure.
1. Login with the default user account.
- Install the SSH server if it was not installed during the base installation.
        apt install ssh
- Get the accessible IP Address of the target system.
        ip addr
- Set the root password temporarily. The script will reset it.
        sudo chpasswd root:root
- Add the following line to the /etc/ssh/sshd_config file:
        echo PermitRootLogin yes | sudo tee -a /etc/ssh/sshd_config
- Restart the SSH service:
        systemctl restart ssh

 NOTE: The next steps depend on whether you are using a drive on the target system or using ssh to access the target system remotely:
- Open a command prompt at the location of this start.sh file.
    - Run the start script from the target system (i.e. USB drive):
   start.sh local
    - Run the start script from another system with network access to the target:
   start.sh target_system_ip_address
- Use the root password determined in step 2 above to login.


# TODO List
1. Configure wifi detection and setup.
- Configure LibreOffice installation.
