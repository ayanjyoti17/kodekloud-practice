# The Nautilus DevOps team aims to containerize various applications following a recent meeting with the 
# application development team. They intend to conduct testing with the following steps:
1. Install docker-ce and docker compose packages on App Server 2.
2. Initiate the docker service.


# solution ->>>>>>>>
# Update your package manager's index:
sudo yum update
# Install prerequisites:
sudo yum install -y yum-utils
# Add the Docker repository:
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker CE (Community Edition):
sudo yum install -y docker-ce docker-ce-cli containerd.io
# Install Docker Compose:
sudo yum install -y docker-compose
# if it not works then do this :->
    # Download the Docker Compose binary
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # Make the binary executable
    sudo chmod +x /usr/local/bin/docker-compose
    # verify installation
    docker-compose --version

# Start the Docker Service
sudo systemctl start docker
sudo systemctl enable docker