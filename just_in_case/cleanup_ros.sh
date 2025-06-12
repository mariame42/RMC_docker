#!/bin/bash

echo "Cleaning up ROS-related sources and keys..."

# Backup sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Remove ROS sources
sudo rm -f /etc/apt/sources.list.d/ros2-latest.list
sudo rm -f /etc/apt/sources.list.d/ros-latest.list

# Create a new sources.list without ROS entries
sudo grep -v "ros" /etc/apt/sources.list > /tmp/sources.list
sudo mv /tmp/sources.list /etc/apt/sources.list

# Remove ROS keys
sudo rm -f /usr/share/keyrings/ros-archive-keyring.gpg
sudo rm -f /etc/apt/trusted.gpg.d/ros-archive-keyring.gpg
sudo rm -f /etc/apt/trusted.gpg.d/ros2-archive-keyring.gpg

# Clean apt cache
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean

# Update apt
sudo apt-get update

echo "Cleanup completed." 