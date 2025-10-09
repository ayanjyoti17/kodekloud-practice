# The Nautilus Application development team recently finished development of one of the apps that they want 
# to deploy on a containerized platform. The Nautilus Application development and DevOps teams met to discuss 
# some of the basic pre-requisites and requirements to complete the deployment. The team wants to test the 
#deployment on one of the app servers before going live and set up a complete containerized stack using a 
# docker compose fie. Below are the details of the task:

'''On App Server 1 in Stratos Datacenter create a docker compose file /opt/data/docker-compose.yml (should be named exactly).
The compose should deploy two services (web and DB), and each service should deploy a container as per details below:

For web service:
a. Container name must be php_apache.
b. Use image php with any apache tag. Check here for more details.
c. Map php_apache container s port 80 with host port 5000
d. Map php_apache containers /var/www/html volume with host volume /var/www/html.

For DB service:
a. Container name must be mysql_apache.
b. Use image mariadb with any tag (preferably latest). Check here for more details.
c. Map mysql_apache containers port 3306 with host port 3306
d. Map mysql_apache containers /var/lib/mysql volume with host volume /var/lib/mysql.
e. Set MYSQL_DATABASE=database_apache and use any custom user ( except root ) with some complex password for DB connections.

After running docker-compose up you can access the app with curl command curl <server-ip or hostname>:5000/

Note: Once you click on FINISH button, all currently running/stopped containers will be destroyed and stack 
will be deployed again using your compose file.'''


# Solution ->>>>>>>>>>>
first ssh into App Server 1.
cd /opt/data
create a docker-compose.yml file(sudo vi docker-compose.yml) add the following content :-

version: '3.8'

services:
  web:
    image: php:apache
    container_name: php_apache
    ports:
      - "5000:80"
    volumes:
      - /var/www/html:/var/www/html

  db:
    image: mariadb:latest
    container_name: mysql_apache
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_DATABASE: database_apache
      MYSQL_USER: db_user
      MYSQL_PASSWORD: StrongPassword!
      MYSQL_ROOT_PASSWORD: SuperStrongRootPassword!

# Deploy
sudo docker compose up -d
# Check the containers
sudo docker compose ps
# Test the web service
curl http://localhost:5000/