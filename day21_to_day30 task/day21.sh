# Day 21: Set Up Git Repository on Storage Server
# The Nautilus development team has provided requirements to the DevOps team for a new application 
# development project, specifically requesting the establishment of a Git repository. 
# Follow the instructions below to create the Git repository on the Storage server in the Stratos DC:

1. Utilize yum to install the git package on the Storage Server.
2. Create a bare repository named /opt/media.git (ensure exact name usage).

ssh into Storage server first.
# step 1 : Install the git package 
sudo yum install -y git

# step 2 : Create a bare repository named /opt/media.git
sudo git init --bare /opt/media.git