#!/bin/bash


# Manually install docker compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
docker compose version


# # Remove conflicting Docker packages
# for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Update package list and install necessary packages
# sudo apt-get update
# sudo apt-get install -y docker-compose-plugin

# # Add Docker's official GPG key
# sudo install -m 0755 -d /etc/apt/keyrings
# sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
# sudo chmod a+r /etc/apt/keyrings/docker.asc

# # Add Docker repository to Apt sources
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# # # Update package list and install Docker packages
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# # Make the NVIDIA Container Toolkit installer script executable
# chmod +x scripts/nvidia-ctk.sh

# # Run the NVIDIA Container Toolkit installer script
# scripts/nvidia-ctk.sh

# # Install Nvidia Docker package 
## Note: The primary issue has to do with the GPU driver. The GPU driver has components that run in kernel space and other components that run in user space. 
## The implication of this is that for successful usage in docker, these components (user-space: inside the container, kernel space: outside the container) must match.
## That is a key function for the NVIDIA container toolkit/container runtime that augments docker: 
## To make whatever is inside the container pertaining to the GPU driver match whatever is outside the container.
# sudo apt install -y nvidia-docker2

# # Reload daemon and restart Docker
# sudo systemctl daemon-reload
# sudo systemctl restart docker

# Disable NVLink within the NVIDIA kernel module
echo "options nvidia NVreg_NvLinkDisable=1" | sudo tee /etc/modprobe.d/nvidia-disablenvlink.conf

# Update the RAM disk to apply the change
sudo update-initramfs -u

# Reboot the system to apply the changes
sudo reboot