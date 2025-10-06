# The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of 
# tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container 
# on Application Server 3 in Stratos Datacenter. Please perform the task as per details mentioned below:

a. Pull nginx:alpine-perl docker image on Application Server 3.
b. Create a container named media using the image you pulled.
c. Map host port 8085 to container port 80. Please keep the container in running state.


# Solution ->>>>>>
first ssh into App Server 3.

# Step 1: Pull the Docker Image
docker pull nginx:alpine-perl

# Step 2: Create and Run the Container 
docker run -d --name media -p 8085:80 nginx:alpine-perl

# Step 3: Verification
docker ps