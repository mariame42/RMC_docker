build and run with ports

sudo docker build -t mariame42/ros2_jazzy_env:arm64 .

sudo docker run -it \
  --device=/dev/ttyUSB0 \
  --device=/dev/ttyACM0 \
  mariame42/ros2_jazzy_env:arm64

normail building and pushing to docker hub:

docker build -t ros2_jazzy_env .
docker run -it --name ros2_dev ros2_jazzy_env

docker login
docker tag ros2_jazzy_env mariame42/ros2_jazzy_env:latest
docker push mariame42/ros2_jazzy_env:latest

docker pull mariame42/ros2_jazzy_env:latest
docker run -it mariame42/ros2_jazzy_env:latest



install docker <note: already in the script>
sudo apt update
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
test:
    docker --version
    docker run hello-world

why the normal docker image cant work in my rassbary pi 
Your computer (like Raspberry Pi or Apple M1) uses a different type of processor called ARM (arm64).

But the Docker image you tried to run was made for Intel/AMD processors (amd64).

That's like trying to run a Windows app on a Mac — it won’t work unless you emulate it or rebuild it for your computer.


colcon build --packages-select motor_control
source install/setup.bash
ros2 run motor_control keyboard_control