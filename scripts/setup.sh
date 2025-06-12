#!/bin/bash

print_red() {
  echo -e "\033[0;31m$1\033[0m"
}

# --------------- install git
echo "🔧 Checking for Git..."
if ! command -v git &>/dev/null; then
    echo "📦 Installing Git..."
    sudo apt-get update
    sudo apt-get install -y git
    echo "✅ Git installed."
else
    echo "✅ Git is already installed."
fi

# --------------- install VS Code (arm64)
echo "💻 Checking for Visual Studio Code..."
if ! command -v code &>/dev/null; then
    echo "📦 Installing Visual Studio Code (for ARM64)..."
    sudo snap install --classic code
    echo "✅ Visual Studio Code installed."
else
    echo "✅ Visual Studio Code is already installed."
fi

# --------------- install Docker
echo "🐳 Checking for Docker..."
if ! command -v docker &>/dev/null; then
    echo "📦 Installing Docker..."
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
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
print_red "👉 Please copy the above key and paste it into your GitHub SSH settings."

echo "🎉 All tasks completed successfully!"