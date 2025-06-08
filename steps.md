docker build -t ros2-jazzy .
docker run -it ros2-jazzy

ros2 - jazzy

colcon, python3-colcon-common-extensions, or build-essential, which are needed to build ROS packages.

python3-vcstool is not installed. It’s needed for .repos file cloning.

Git is not installed.

python tools:
python3-pip, setuptools, and wheel

6. Networking Setup
❌ No ROS_DOMAIN_ID or other environment variables like:

ROS_LOCALHOST_ONLY

ROS_NAMESPACE

RMW_IMPLEMENTATION

👉 These are important for managing multiple nodes and networks.

GUI:
rviz2 or gazebo
👉 GUI needs extra setup: x11, libgl1, shared volumes, and DISPLAY config.


motor control:

arduino:
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
export PATH=$PATH:$HOME/bin
arduino-cli core update-index
arduino-cli core install arduino:avr

pip3 install pyserial