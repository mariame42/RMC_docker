#!/bin/bash

echo "Setting up apt sources for ARM64..."

# Backup current sources
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup.$(date +%Y%m%d_%H%M%S)

# Remove all existing sources
sudo rm -f /etc/apt/sources.list.d/*.list
sudo rm -f /etc/apt/sources.list.d/*.sources

# Create new sources.list with correct ARM64 repositories
sudo bash -c 'cat > /etc/apt/sources.list << EOL
deb http://ports.ubuntu.com/ubuntu-ports noble main restricted universe multiverse
deb http://ports.ubuntu.com/ubuntu-ports noble-updates main restricted universe multiverse
deb http://ports.ubuntu.com/ubuntu-ports noble-security main restricted universe multiverse
deb http://ports.ubuntu.com/ubuntu-ports noble-backports main restricted universe multiverse
EOL'

# Clean apt cache
echo "Cleaning apt cache..."
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean

# Update package lists
echo "Updating package lists..."
sudo apt-get update

echo "Apt sources have been set up for ARM64." 