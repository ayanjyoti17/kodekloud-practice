# The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require 
# a nginx container deployment on Application Server 2. Complete the task with the following instructions:
On Application Server create a container named nginx_2 using the nginx image with the alpine tag. 
Ensure container is in a running state.


# solution ->>>>>>>>>>>>>>
First, ensure you are logged into Application Server 2.
# create and start the container
sudo docker run -d --name nginx_2 nginx:alpine
# To confirm that the container is running correctly :
sudo docker ps