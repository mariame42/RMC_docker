# RMC Docker Environment Setup

This repository provides a simple and complete starting point for working with ROS2 on a Raspberry Pi. By following the steps in this README, you will be able to:

- Install all required applications  
- Launch a Docker container with a pre-configured ROS2 environment  
- Follow a step-by-step guide starting from a fresh Raspberry Pi setup  

---

## 📥 Step 1: Clone the Repository

> **Note**: If you do not have `git` installed yet, download the repository manually from the following link:  
> https://github.com/mariame42/RMC_docker

Once downloaded, you will find the following files and folders:

- `README.md`: This guide  
- `Dockerfile`: Defines the ROS2 environment used inside the Docker container  
- `setup.sh`: Installs necessary software on the local machine  
- `clone_roamio.sh`: clone the main repos for roamio
- `notes/`  
  - `docker/`: Items or additions related to the Docker setup  
  - `script/`: Items or additions related to the setup script  

---

## ⚙️ Step 2: Run the Setup Script

Navigate to the folder where you saved the repository and run the setup script:

```bash
cd /path/to/RMC_docker
chmod +x setup.sh
./setup.sh
```

---

## 🐳 Step 3: Build and Run the Docker Container

### Terminal Method

Use the following commands to build and run the Docker container:

```bash
cd /path/to/RMC_docker
sudo docker build -t mariame42/ros2_jazzy_env:arm64 .
sudo docker run -it \
    --name ros2_container \
    -v /:/host \
    mariame42/ros2_jazzy_env:arm64 \
    /bin/bash
```

---

---

## 🔁 Step 4 Clone Roamio Repositories (Optional)

To get the Roamio robot code and documentation, run the following script:

```bash
chmod +x clone_roamio.sh
./clone_roamio.sh
```

### VS Code Method (Dev Containers)

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

---

## 🧩 Step 3: Open It in VS Code

1. Open **VS Code**

2. Go to:  
   **File → Open Folder → Select `~/ros2_dev`**

3. Press `F1` (or `Ctrl+Shift+P`)

4. Type:  
   **Dev Containers: Reopen in Container**

5. Select that option from the dropdown


Save the file and open the folder in VS Code. You will be prompted to reopen in the container.

---


You're all set! This environment should give you a stable ROS2 setup tailored for your robot development needs on Raspberry Pi.