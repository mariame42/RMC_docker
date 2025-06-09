#!/bin/bash

# --------------- install git
echo "🔧 Updating package list and installing Git..."
sudo apt update
sudo apt install -y git
echo "✅ Git installed."

# --------------- create SSH key
echo "🔐 Checking for existing SSH key..."
if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
    echo "✅ SSH key already exists at ~/.ssh/id_ed25519.pub"
else
    echo "🔐 Creating a new SSH key..."
    ssh-keygen -t ed25519 -C "roamioaaqil@gmail.com"
    echo "✅ SSH key created."
fi

echo "📋 Your public SSH key:"
cat ~/.ssh/id_ed25519.pub
echo "👉 Please copy the above key and paste it into your GitHub SSH settings."

# --------------- install VS Code (arm64)
echo "💻 Installing Visual Studio Code (for ARM64)..."
sudo apt update
sudo apt install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=arm64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
echo "✅ Visual Studio Code installed."

# --------------- install Docker
echo "🐳 Installing Docker..."
sudo apt update && sudo apt install -y docker.io
sudo usermod -aG docker $USER
echo "✅ Docker installed. Group updated for user: $USER"
echo "🌀 You may need to log out and back in or run 'newgrp docker' to apply group changes."
newgrp docker

# --------------- enable SSH
echo "🔗 Installing and enabling OpenSSH server..."
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
echo "✅ SSH server is running."

# --------------- install net-tools (ifconfig)
echo "🧰 Installing net-tools (for ifconfig)..."
sudo apt install -y net-tools
echo "✅ net-tools installed."

echo "🎉 All tasks completed successfully!"
