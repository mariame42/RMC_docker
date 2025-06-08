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
    
