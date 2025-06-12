#!/bin/bash

# List of system packages to check
SYSTEM_PACKAGES=(
    locales
    software-properties-common
    curl
    git
    python3
    python3-pip
    wget
    lsb-release
    gnupg
    python3-venv
    python3-serial
    python3-transforms3d
    terminator
)

# List of ROS 2 packages to check
ROS_PACKAGES=(
    ros-dev-tools
    ros-jazzy-desktop
    ros-jazzy-ros-base
    ros-jazzy-ros2-control
    ros-jazzy-ros2-controllers
    ros-jazzy-xacro
    ros-jazzy-joint-state-publisher-gui
    ros-jazzy-turtlesim
    ros-jazzy-robot-localization
    ros-jazzy-joy
    ros-jazzy-joy-teleop
    ros-jazzy-tf-transformations
)

# List of Python packages to check (in venv)
PYTHON_PACKAGES=(
    pyserial
)

# List of tools/commands to check
COMMANDS=(
    arduino-cli
)

INSTALLED=()
MISSING=()

# Check system packages
for pkg in "${SYSTEM_PACKAGES[@]}"; do
    if dpkg -l | grep -qw "$pkg"; then
        INSTALLED+=("$pkg (system)")
    else
        MISSING+=("$pkg (system)")
    fi
done

# Check ROS 2 packages
for pkg in "${ROS_PACKAGES[@]}"; do
    if dpkg -l | grep -qw "$pkg"; then
        INSTALLED+=("$pkg (ros)")
    else
        MISSING+=("$pkg (ros)")
    fi
done

# Check commands
for cmd in "${COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        INSTALLED+=("$cmd (command)")
    else
        MISSING+=("$cmd (command)")
    fi
done

# Check Python packages in venv if exists
if [ -d "/opt/venv" ]; then
    source /opt/venv/bin/activate
    for pkg in "${PYTHON_PACKAGES[@]}"; do
        if pip show "$pkg" >/dev/null 2>&1; then
            INSTALLED+=("$pkg (python/venv)")
        else
            MISSING+=("$pkg (python/venv)")
        fi
    done
    deactivate
else
    for pkg in "${PYTHON_PACKAGES[@]}"; do
        MISSING+=("$pkg (python/venv)")
    done
fi

# Print results

echo "\n===== INSTALLED ====="
for i in "${INSTALLED[@]}"; do
    echo "$i"
done

echo "\n===== MISSING ====="
for i in "${MISSING[@]}"; do
    echo "$i"
done 