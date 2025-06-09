docker build -t ros2_jazzy_env .
docker run -it --name ros2_dev ros2_jazzy_env


-to push
docker login
docker tag ros2_jazzy_env mariame42/ros2_jazzy_env:latest
docker push mariame42/ros2_jazzy_env:latest

docker pull mariame42/ros2_jazzy_env:latest
docker run -it mariame42/ros2_jazzy_env:latest


in roamio:
sudo apt update
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
test:
    docker --version
    docker run hello-world
    
<the pushing did not work because>
Your computer (like Raspberry Pi or Apple M1) uses a different type of processor called ARM (arm64).

But the Docker image you tried to run was made for Intel/AMD processors (amd64).

That's like trying to run a Windows app on a Mac — it won’t work unless you emulate it or rebuild it for your computer.

<way num 02>
do it localy in roamio
sudo docker build -t mariame42/ros2_jazzy_env:arm64 .
sudo docker run -it mariame42/ros2_jazzy_env:arm64

sudo docker run -it \
  --device=/dev/ttyUSB0 \
  --device=/dev/ttyACM0 \
  mariame42/ros2_jazzy_env:arm64


<things i need to chnage>
- in the upload of the arduino change the (sketch_path)
- install vim <apt install vim>

keybourd:

apt update
apt install python3-serial -y
ros2 run motor_control keyboard_control




colcon build --packages-select motor_control
source install/setup.bash
ros2 run motor_control keyboard_control


