# Day 19: Install and Configure Web Application
# xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. 
# The development of these websites is still in-progress, but we want to get the servers ready. 
# Please perform the following steps to accomplish the task:
a. Install httpd package and dependencies on app server 1.
b. Apache should serve on port 3002.
c. There are two websites backups /home/thor/news and /home/thor/cluster on jump_host. 
Set them up on Apache in a way that news should work on the link http://localhost:3002/news/ and
cluster should work on link http://localhost:3002/cluster/ on the mentioned app server.
d. Once configured you should be able to access the website using curl command on the respective app server, 
i.e curl http://localhost:3002/news/ and url http://localhost:3002/cluster/

# Step 1: Install and Configure Apache on App Server 1
# First, log in to app server 1 and set up the webserver.
sudo yum install -y httpd
sudo vi /etc/httpd/conf/httpd.conf   # Edit the main Apache configuration file to change the port from 80 to 3002
change Listen 80 ->> Listen 3002
sudo systemctl start httpd
sudo systemctl enable httpd

# Step 2: Copy Website Files
# Now, go to your jump host terminal to copy the website backup files over to app server 1.
# Copy the Website Directories
scp -r /home/thor/news tony@stapp01:/tmp/
scp -r /home/thor/cluster tony@stapp01:/tmp/

# Step 3: Deploy Websites on App Server 1
# Go back to your app server 1 terminal to move the files into the web directory.
# Move Files to DocumentRoot ->>>The default web directory for Apache is /var/www/html. 
# Move the directories you just copied from /tmp into this location
sudo mv /tmp/news /var/www/html/
sudo mv /tmp/cluster /var/www/html/
# Set Correct Permissions
sudo chown -R apache:apache /var/www/html/news
sudo chown -R apache:apache /var/www/html/cluster

# Step 4: Verification
# Test the /news site:
curl http://localhost:3002/news/

# Test the /cluster site:
curl http://localhost:3002/cluster/

# Both commands should return the HTML content of the respective index.html pages for each site. 
# If they do, your task is complete.