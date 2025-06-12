#!/bin/bash

# Check if a package is installed
is_installed() {
    dpkg -l | grep -qw "$1"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if a Python package is installed in venv
is_python_installed() {
    if [ -d "/opt/venv" ]; then
        source /opt/venv/bin/activate
        pip show "$1" >/dev/null 2>&1
        local result=$?
        deactivate
        return $result
    else
        return 1
    fi
}

# Install a package if not already installed
install_if_missing() {
    if ! is_installed "$1"; then
        echo "Installing $1..."
        apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Install a Python package if not already installed
install_python_if_missing() {
    if ! is_python_installed "$1"; then
        echo "Installing $1..."
        source /opt/venv/bin/activate
        pip install "$1"
        deactivate
    else
        echo "$1 is already installed."
    fi
}

# Install a command if not already installed
install_command_if_missing() {
    if ! command_exists "$1"; then
        echo "Installing $1..."
        if [ "$1" = "arduino-cli" ]; then
            cd /root
            curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
            export PATH="/root/bin:$PATH"
            echo 'export PATH="/root/bin:$PATH"' >> ~/.bashrc
            /root/bin/arduino-cli core update-index
            /root/bin/arduino-cli core install arduino:avr
            cd -
        fi
    else
        echo "$1 is already installed."
    fi
}

# Install ROS 2 packages if not already installed
install_ros_if_missing() {
    if ! is_installed "$1"; then
        echo "Installing $1..."
        apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Install system packages
install_if_missing locales
install_if_missing software-properties-common
install_if_missing curl
install_if_missing git
install_if_missing python3
install_if_missing python3-pip
install_if_missing wget
install_if_missing lsb-release
install_if_missing gnupg
install_if_missing python3-venv
install_if_missing python3-serial
install_if_missing python3-transforms3d
install_if_missing terminator

# Install ROS 2 packages
install_ros_if_missing ros-dev-tools
install_ros_if_missing ros-jazzy-desktop
install_ros_if_missing ros-jazzy-ros-base
install_ros_if_missing ros-jazzy-ros2-control
install_ros_if_missing ros-jazzy-ros2-controllers
install_ros_if_missing ros-jazzy-xacro
install_ros_if_missing ros-jazzy-joint-state-publisher-gui
install_ros_if_missing ros-jazzy-turtlesim
install_ros_if_missing ros-jazzy-robot-localization
install_ros_if_missing ros-jazzy-joy
install_ros_if_missing ros-jazzy-joy-teleop
install_ros_if_missing ros-jazzy-tf-transformations

# Install Python packages
install_python_if_missing pyserial

# Install commands
install_command_if_missing arduino-cli

# Remove old setup scripts
rm -f setup_ros2_jazzy_official.sh setup_ros2_jazzy.sh

echo "Setup completed."