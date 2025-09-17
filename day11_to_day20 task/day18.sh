# Day 18: Configure LAMP server
# solve this task step by step ....... xFusionCorp Industries is planning to host a WordPress website on their infra 
# in Stratos Datacenter. They have already done infrastructure configuration—for example, on the storage server they 
# already have a shared directory /vaw/www/html that is mounted on each app host under /var/www/html directory. 
# Please perform the following steps to accomplish the task:
a. Install httpd, php and its dependencies on all app hosts.
b. Apache should serve on port 3002 within the apps.
c. Install/Configure MariaDB server on DB Server.
d. Create a database named kodekloud_db4 and create a database user named kodekloud_joy identified as password YchZHRcLkL. 
Further make sure this newly created user is able to perform all operation on the database you created.
e. Finally you should be able to access the website on LBR link, by clicking on the App button on the top bar. 
You should see a message like App is able to connect to the database using user kodekloud_joy


# Step 1: Install Apache and PHP on App Servers
# You need to perform these actions on all application servers.
# SSH into your app server
sudo yum install -y httpd php php-mysqlnd
#Repeat these installation commands on all other app servers.

# Step 2: Configure Apache to Use Port 3002
# This also needs to be done on all application servers.
# On each app server, edit the Apache configuration file.
sudo vi /etc/httpd/conf/httpd.conf
Find the line that says Listen 80 and change it to Listen 3002.
Save and close the file.

sudo systemctl start httpd
sudo systemctl enable httpd
# Repeat this configuration on all other app servers.

# Step 3: Install and Configure MariaDB on the DB Server
# Now, switch to the database server (stdb01).
# SSH into the database server.
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Step 4: Create the Database and User
# Perform these actions on the database server (stdb01).
sudo mysql -u root  # Log in to the MariaDB shell as the root user.
CREATE DATABASE kodekloud_db4;
CREATE USER 'kodekloud_joy'@'%' IDENTIFIED BY 'YchZHRcLkL';
GRANT ALL PRIVILEGES ON kodekloud_db4.* TO 'kodekloud_joy'@'%';
FLUSH PRIVILEGES;
EXIT;

# Step 5: Deploy the Test Application File
# This step is performed on the storage server (ststor01). Because /vaw/www/html is shared with all app servers, 
# creating the file here makes it available everywhere.

SSH into the storage server.
# Create an index.php file in the shared directory.
sudo vi /vaw/www/html/index.php
# Add the following PHP code to the file. This code will test the connection to the database you just created.

<?php
$dbname = 'kodekloud_db4';
$dbuser = 'kodekloud_joy';
$dbpass = 'YchZHRcLkL';
$dbhost = 'stdb01';

$link = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

if ($link) {
    echo "<h1>App is able to connect to the database using user $dbuser</h1>";
} else {
    die("Error: Unable to connect to database.");
}

mysqli_close($link);
?>

# Save and close the file.

# Final Verification
Click the App button on the Load Balancer (LBR) link. 
You should now see the success message: App is able to connect to the database using user kodekloud_joy.