# As per recent requirements shared by the Nautilus application development team, they need custom images 
# created for one of their projects. Several of the initial testing requirements are already been shared 
# with DevOps team. Therefore, create a docker file /opt/docker/Dockerfile (please keep D capital of Dockerfile) 
# on App server 2 in Stratos DC and configure to build an image with the following requirements:

a. Use ubuntu:24.04 as the base image.
b. Install apache2 and configure it to work on 8086 port. 
   (do not update any other Apache configuration settings like document root etc).


# Solution ->>>>>>>>>>>>>
first ssh into App Server 2.

create a file named Dockerfile in the /opt/docker/ directory on App Server 2 and add the following content :
# Dockerfile :->

# a. Use ubuntu:24.04 as the base image.
FROM ubuntu:24.04

# Update the package index and install apache2 in a single layer
# Also, clean up apt cache to keep the image size small
RUN apt-get update && \
    apt-get install -y apache2 && \
    rm -rf /var/lib/apt/lists/*

# b. Configure apache2 to work on port 8086.
# Use sed to find and replace the default "Listen 80" directive in the ports configuration file.
RUN sed -i 's/Listen 80/Listen 8086/' /etc/apache2/ports.conf

# Inform Docker that the container listens on port 8086 at runtime.
EXPOSE 8086

# Start Apache in the foreground. This is the recommended way to run services in containers.
CMD ["apache2ctl", "-D", "FOREGROUND"]