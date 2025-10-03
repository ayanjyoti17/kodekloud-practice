# One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running 
# on App Server 3 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we 
# need to finish his pending work ASAP. Please complete the remaining work as per details given below: 

a. Install apache2 in kkloud container using apt that is running on App Server 3 in Stratos Datacenter. 
b. Configure Apache to listen on port 3001 instead of default http port. Do not bind it to listen on specific 
   IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc. 
c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.


# solution ->>>>>>>

#  1. At first login on app server as per the task & switch to root user
ssh banner@stapp03
sudo su -

#  2. Run the Below command to check the existing docker container running 
docker ps

# 3. Login on docker container (ubuntu ) & install apache2
docker exec -it kkloud /bin/sh
apt install apache2 -y

# 4. go to the apache2 folder where all configuration files you will find 
cd /etc/apache2
ls -l

# 5. Since in this Container no Vi editor was installed, hence using sed commands.
sed -i 's/Listen 80/Listen 3001/g' ports.conf
sed -i 's/:80/:3001/g' apache2.conf
sed -i 's/#ServerName www.example.com/ServerName localhost/g' apache2.conf

# 6. Start apache2 service & confirm the running status 
service apache2 start
service apache2 status

# 7. Validate the task by Curl
curl -Ik localhost:3001