#!/bin/bash

# --------------- install git
echo "🔧 Checking for Git..."
if ! command -v git &>/dev/null; then
    echo "📦 Installing Git..."
    sudo apt update
    sudo apt install -y git
    echo "✅ Git installed."
else
    echo "✅ Git is already installed."
fi

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
echo "💻 Checking for Visual Studio Code..."
if ! command -v code &>/dev/null; then
    echo "📦 Installing Visual Studio Code (for ARM64)..."
    sudo apt update
    sudo apt install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=arm64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
    echo "✅ Visual Studio Code installed."
else
    echo "✅ Visual Studio Code is already installed."
fi

# --------------- install Docker
echo "🐳 Checking for Docker..."
if ! command -v docker &>/dev/null; then
    echo "📦 Installing Docker..."
    sudo apt update && sudo apt install -y docker.io
    sudo usermod -aG docker $USER
    echo "✅ Docker installed. Group updated for user: $USER"
    echo "🌀 You may need to log out and back in or run 'newgrp docker' to apply group changes."
else
    echo "✅ Docker is already installed."
fi

# --------------- enable SSH
echo "🔗 Checking for SSH server..."
if ! systemctl is-active --quiet ssh; then
    echo "📦 Installing and starting OpenSSH server..."
    sudo apt update
    sudo apt install -y openssh-server
    sudo systemctl enable ssh
    sudo systemctl start ssh
    echo "✅ SSH server is running."
else
    echo "✅ SSH server is already active."
fi

# --------------- install net-tools (ifconfig)
echo "🧰 Checking for net-tools (ifconfig)..."
if ! command -v ifconfig &>/dev/null; then
    echo "📦 Installing net-tools..."
    sudo apt install -y net-tools
    echo "✅ net-tools installed."
else
    echo "✅ net-tools already installed."
fi

echo "🎉 All tasks completed successfully!"