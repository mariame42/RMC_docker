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

$(pwd)/bin/arduino-cli core update-index && $(pwd)/bin/arduino-cli core install arduino:avr


setup.sh :-
git
Visual Stdio
Docker
SSH enableing
ssh key

clone_roamio.sh
clone roamio brean
clone DOC


setup_ros2_jazzy.sh
ros jazzy
python packages
arduino-cli


check install.sh
check that every thing this scrip installing is installed(setup_ros2_jazzy.sh)

you created not sure when to use it
cleanup_ros.sh
setup_apt.sh



in this file make a make file that if i will press make it will
run the scripts in this order:

what_i_installing.sh
setup.sh 

clone_roamio.sh

setup_ros2_jazzy.sh

a rule called print that will run this script:
what_i_installing.sh

another rule called check run :
check_install.sh

another rule called docker buld the docker:
sudo docker build -t mariame42/ros2_jazzy_env:arm64 .
sudo docker run -it \
    --name ros2_container \
    -v /:/host \
    mariame42/ros2_jazzy_env:arm64 \
    /bin/bash

dont forget to make the printing clear and easy to understand dont write a lot the scripts allready have

