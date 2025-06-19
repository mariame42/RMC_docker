#!/bin/bash

# Demo script for LiDAR system with motor control
# All commands should be run inside: ~/Desktop/roamio_brain/lidar

echo "Setting up LiDAR demo..."

# Change to the required directory
cd ~/Desktop/roamio_brain/lidar

# Make sure the two ports are open with proper permissions
echo "Setting up serial port permissions..."
sudo chmod 666 /dev/ttyACM0
sudo chmod 666 /dev/ttyUSB0

# Compile and upload Arduino code
echo "Compiling Arduino motor control code..."
arduino-cli compile --fqbn arduino:avr:mega arduino_scripts/motor_control_with_PID/

echo "Uploading Arduino code..."
arduino-cli upload --fqbn arduino:avr:mega -p /dev/ttyACM0 arduino_scripts/motor_control_with_PID/

# Run ROS2 nodes
echo "Starting LiDAR node..."
source install/setup.bash
ros2 run sllidar_ros2 sllidar_node --ros-args -p serial_port:=/dev/ttyUSB0 -p serial_baudrate:=256000 &

echo "Starting motor controller..."
source install/setup.bash
ros2 run lidar lidar_motor_controller