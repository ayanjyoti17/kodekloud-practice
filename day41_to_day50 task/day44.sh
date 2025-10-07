# The Nautilus application development team shared static website content that needs to be hosted on the 
# httpd web server using a containerised platform. The team has shared details with the DevOps team, and 
# we need to set up an environment according to those guidelines. Below are the details:
a. On App Server 2 in Stratos DC create a container named httpd using a docker compose file /opt/docker/docker-compose.yml 
   (please use the exact name for file).

b. Use httpd (preferably latest tag) image for container and make sure container is named as httpd; 
   you can use any name for service.

c. Map 80 number port of container with port 6200 of docker host.

d. Map containers /usr/local/apache2/htdocs volume with /opt/finance volume of docker host which is already there. 
   (please do not modify any data within these locations).


# Solution ->>>>>>>>>>>>>>>
first ssh into App Server 2.
# create a docker-compose.yml file with the specified configurations for the httpd service.
Create the file /opt/docker/docker-compose.yml on App Server 2 and add the following content --

version: '3.8'

services:
  webserver:
    image: httpd:latest
    container_name: httpd
    ports:
      - "6200:80"
    volumes:
      - "/opt/finance:/usr/local/apache2/htdocs"

# Navigate and Run
cd /opt/docker
docker compose up -d

# Verify the Container 
docker ps