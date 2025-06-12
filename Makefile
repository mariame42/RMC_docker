all:
	@echo "Setting up permissions..."
	@chmod +x scripts/*.sh
	@echo "Running scripts in order..."
	@./scripts/what_i_installing.sh
	@./scripts/setup.sh
	@./scripts/clone_roamio.sh
	@./scripts/setup_ros2_jazzy.sh

print:
	@echo "Setting up permissions..."
	@chmod +x scripts/*.sh
	@echo "Printing installation details..."
	@./scripts/what_i_installing.sh

check:
	@echo "Setting up permissions..."
	@chmod +x scripts/*.sh
	@echo "Checking installation..."
	@./scripts/check_install.sh

docker:
	@echo "Building and running Docker container..."
	sudo docker build -t mariame42/ros2_jazzy_env:arm64 .
	sudo docker run -it \
		--name ros2_container \
		-v /:/host \
		mariame42/ros2_jazzy_env:arm64 \
		/bin/bash




