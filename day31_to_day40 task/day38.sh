# Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, 
# they want to test containerized environment application features. As per details shared with DevOps team, 
# we need to accomplish the following task:

a. Pull busybox:musl image on App Server 3 in Stratos DC and re-tag (create new tag) this image as busybox:news.


# solution ->>>>>>>>
first SSH into the Server.

# Pull the Docker Image
docker pull busybox:musl

# verify
docker images

# Re-tag the Image
docker tag busybox:musl busybox:news

# verify
docker images