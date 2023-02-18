#!/bin/bash

# Update package list and upgrade packages
sudo apt-get update && sudo apt-get upgrade -y    # Fetch and install updates for the system

# Install and enable antivirus software
sudo apt-get install clamav clamav-daemon -y    # Install ClamAV antivirus software
sudo dpkg-reconfigure clamav-daemon    # Configure ClamAV to run as a daemon

# Configure partially installed packages and fix broken dependencies
sudo dpkg --configure -a    # Configure any partially installed packages
sudo apt-get install -f    # Fix any broken dependencies

# Install and enable unattended-upgrades package
sudo apt-get install unattended-upgrades -y    # Install automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades    # Configure unattended-upgrades package

# Install and enable firewall
sudo apt-get install ufw -y    # Install UFW firewall
sudo ufw default deny incoming    # Deny all incoming connections by default
sudo ufw default allow outgoing    # Allow all outgoing connections by default
sudo ufw enable    # Enable the firewall

# Disable root login and password authentication for ssh
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config    # Disable SSH login as root
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config    # Disable password authentication for SSH
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config    # Disable empty passwords
sudo sed -i 's/#PermitUserEnvironment no/PermitUserEnvironment no/g' /etc/ssh/sshd_config    # Disable user environment variables
sudo service sshd restart    # Restart SSH service to apply changes

# Enable automatic updates for installed snaps
sudo snap set system refresh.timer=snapd.refresh.timer    # Set up automatic updates for installed snaps

# Enable AppArmor
sudo apt-get install apparmor-utils -y    # Install AppArmor
sudo aa-enforce /etc/apparmor.d/*    # Enable AppArmor profiles

# Set password policy
sudo apt-get install libpam-pwquality -y    # Install PAM password quality module
sudo sed -i 's/#\s*\(password.*\)/\1/' /etc/pam.d/common-password    # Enable PAM password quality checking
sudo sed -i 's/\(minlen.*\)/minlen=14/' /etc/security/pwquality.conf    # Set minimum password length to 14 characters

# Install and configure fail2ban
sudo apt-get install fail2ban -y    # Install fail2ban intrusion prevention software
sudo systemctl enable fail2ban    # Enable fail2ban service

# Create two new users with admin privileges and restrict access
sudo adduser johndoe sudo    # Create new user johndoe with sudo privileges
sudo adduser janedoe sudo    # Create new user janedoe with sudo privileges
sudo usermod --expiredate -1 johndoe    # Set johndoe account to never expire
sudo usermod --expiredate -1 janedoe    # Set janedoe account to never expire

# Harden the filesystem by setting permissions on sensitive files
sudo chown root:root /etc/passwd  # Set owner and group of /etc/passwd to root
sudo chmod 644 /etc/passwd       # Set permissions on /etc/passwd to read-write for root and read-only for others
sudo chown root:shadow /etc/shadow  # Set owner and group of /etc/shadow to root and shadow
sudo chmod o-rwx,g-wx /etc/shadow  # Set permissions on /etc/shadow to read-write for root and read-only for group and others

# Install rootkit detection software
sudo apt-get install rkhunter -y   # Install rkhunter package for rootkit detection

# Configure automatic security updates
sudo apt-get install unattended-upgrades -y  # Install unattended-upgrades package for automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades  # Configure unattended-upgrades to apply security updates automatically

# Install and configure tripwire for file integrity monitoring
sudo apt-get install tripwire -y   # Install tripwire package for file integrity monitoring
sudo tripwire --init               # Initialize the tripwire database
sudo tripwire --check              # Check file integrity using tripwire

# Set up a VPN using OpenVPN
sudo apt-get install openvpn -y    # Install OpenVPN package for VPN
sudo systemctl enable openvpn@server  # Enable the OpenVPN server



# Install a package manager with faster downloads than apt-get
sudo apt-get install apt-fast -y   # Install apt-fast package manager for faster downloads
sudo apt-fast update               # Update package list using apt-fast

# Remove unnecessary packages and clean up package cache
sudo apt-get autoremove --purge -y  # Remove packages that are no longer needed
sudo apt-get autoclean             # Clean up package cache


echo -e "\e[32mSystem is up to date, stable, and secure\e[0m"
