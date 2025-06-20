# Start from Ubuntu 24.04 (recommended for ROS 2 Jazzy)
FROM ubuntu:24.04

######################            Jazzy            ###################### 
# Set environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    locales \
    software-properties-common \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Add universe repository
RUN add-apt-repository universe

# Install ROS 2 apt source
RUN curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | \
    grep -F "tag_name" | awk -F\" '{print $4}' > /tmp/ros_apt_version && \
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/$(cat /tmp/ros_apt_version)/ros2-apt-source_$(cat /tmp/ros_apt_version).$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" && \
    apt-get update && \
    apt-get install -y /tmp/ros2-apt-source.deb && \
    rm /tmp/ros2-apt-source.deb /tmp/ros_apt_version

# Install ROS 2 Jazzy
RUN apt-get update && \
    apt-get install -y \
    ros-dev-tools \
    ros-jazzy-desktop \
    ros-jazzy-ros-base && \
    rm -rf /var/lib/apt/lists/*

# Source ROS 2 setup
RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc

# Set the default command
CMD ["/bin/bash"]

######################  git + motor control  + gazebo1   ######################

ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt update && apt install -y \
    curl \
    git \
    python3 \
    python3-pip \
    wget \
    software-properties-common \
    lsb-release \
    gnupg \
    && apt clean

# -------------------------------
# Install Gazebo (classic, not ROS version)
# -------------------------------


# -------------------------------
# Install Arduino CLI
# -------------------------------
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

# Add Arduino CLI to PATH
ENV PATH="${PATH}:/root/bin"

# Update Arduino core and install AVR support
RUN arduino-cli core update-index && arduino-cli core install arduino:avr

# -------------------------------
# Python Serial Communication
# -------------------------------
# Create a Python virtual environment and install pyserial inside it
RUN apt-get update && apt-get install -y python3-venv && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install pyserial

# Add the venv to PATH and environment variables
ENV PATH="/opt/venv/bin:$PATH"
ENV VIRTUAL_ENV="/opt/venv"

# -----new------
RUN apt update && \
    apt upgrade -y && \
    apt install -y python3-serial python3-pip python3-transforms3d terminator \
    ros-jazzy-ros2-control \
    ros-jazzy-ros2-controllers \
    ros-jazzy-xacro \
    ros-jazzy-ros-gz-*\
    ros-jazzy-*-ros2-control\
    ros-jazzy-joint-state-publisher-gui \
    ros-jazzy-turtlesim \
    ros-jazzy-robot-localization \
    ros-jazzy-joy \
    ros-jazzy-joy-teleop \
    ros-jazzy-tf-transformations