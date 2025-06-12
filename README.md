# RMC Docker Environment Setup

This repository provides a simple and complete starting point for working with ROS2 on a Raspberry Pi. By following the steps in this README, you will be able to:

- Install all required applications  
- Launch a Docker container with a pre-configured ROS2 environment  
- Follow a step-by-step guide starting from a fresh Raspberry Pi setup  

## Project Setup Guide

This project uses a Makefile to automate the setup and installation process. Below are the steps you can follow using the `make` command:

## Steps

1. **Run All Scripts**: Execute all setup scripts in the specified order.
   ```bash
   make
   ```

2. **Print Installation Details**: Display what will be installed by the setup scripts.
   ```bash
   make print
   ```

3. **Check Installation**: Verify that all components installed by the setup scripts are correctly installed.
   ```bash
   make check
   ```

4. **Build and Run Docker**: Build and run the Docker container for the project.
   ```bash
   make docker
   ```

## Scripts

- **what_i_installing.sh**: Lists the components that will be installed.
- **setup.sh**: Installs Git, Visual Studio, Docker, SSH enabling, and SSH key.
- **clone_roamio.sh**: Clones the Roamio branch and DOC.
- **setup_ros2_jazzy.sh**: Installs ROS 2 Jazzy, Python packages, and Arduino CLI.
- **check_install.sh**: Checks that everything installed by `setup_ros2_jazzy.sh` is installed.

## Docker

The Docker container is built and run using the following commands:
```bash
sudo docker build -t mariame42/ros2_jazzy_env:arm64 .
sudo docker run -it \
    --name ros2_container \
    -v /:/host \
    mariame42/ros2_jazzy_env:arm64 \
    /bin/bash
```

## VS Code Method (Dev Containers)

> ⚠️ Ensure the container is **not already running** before using this method.

1. Install the following VS Code extensions:
   - `Docker`
   - `Dev Containers`

2. Create your development directory:

```bash
mkdir ~/ros2_dev
cd ~/ros2_dev
```

3. Create and configure the Dev Container:

```bash
mkdir .devcontainer
cd .devcontainer
nano devcontainer.json
```

4. Paste the following content into the `devcontainer.json` file:

```json
{
  "name": "ROS2 Jazzy Dev",
  "image": "mariame42/ros2_jazzy_env:arm64",
  "runArgs": [
    "--name", "ros2_container",
    "-v", "/:/host"
  ],
  "settings": {
    "terminal.integrated.defaultProfile.linux": "bash"
  }
}
```

5. Open **VS Code**

6. Go to:  
   **File → Open Folder → Select `~/ros2_dev`**

7. Press `F1` (or `Ctrl+Shift+P`)

8. Type:  
   **Dev Containers: Reopen in Container**

9. Select that option from the dropdown

This README provides a clear and concise guide to using the Makefile for setting up and managing the project. 