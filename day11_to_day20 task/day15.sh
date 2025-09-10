# Day 15: Setup SSL for Nginx
# The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 2 in Stratos Datacenter. 
# They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:
# 1. Install and configure nginx on App Server 2.
# 2. On App Server 2 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key.
#    Move them to some appropriate location and deploy the same in Nginx.
# 3. Create an index.html file with content Welcome! under Nginx document root.
# 4. For final testing try to access the App Server 2 link (either hostname or IP) from jump host using curl command. 
#    For example curl -Ik https://<app-server-ip>/.


# step 1 : Connect to App Server 2
# First, you need to connect to the target application server from the jump host.
ssh steve@stapp02 

# step 2 : Install and Start Nginx
sudo yum install -y nginx  # Install nginx

sudo systemctl enable nginx  # Enable the nginx service to start on boot

sudo systemctl start nginx  # Start the nginx service

# step 3 : Secure the SSL Certificates
sudo mkdir -p /etc/nginx/ssl  # Create a dedicated directory for SSL files inside /etc/nginx

sudo mv /tmp/nautilus.crt /etc/nginx/ssl/  # Move the certificate to the new location
sudo mv /tmp/nautilus.key /etc/nginx/ssl/  # Move the key to the new location

sudo chmod 600 /etc/nginx/ssl/nautilus.key  # Set restrictive permissions on the private key for security

# step 4 : Configure Nginx for SSL
sudo vi /etc/nginx/nginx.conf  # Open the configuration file with a text editor like vi
# Find the default server block (the one listening on port 80) and modify it to look like the following. 
# This configuration will enable HTTPS on port 443.
ssl_certificate "/etc/nginx/ssl/nautilus.crt";
ssl_certificate_key "/etc/nginx/ssl/nautilus.key";

# step 5 : Create the Index File
# Create a simple index.html file in the Nginx document root (/usr/share/nginx/html) so that there is content to display.
echo "Welcome!" | sudo tee /usr/share/nginx/html/index.html  
#The tee command takes the input it receives (the text "Welcome!") and writes it to the specified file

#step 6 : Test and Restart Nginx
sudo nginx -t  # Test the Nginx configuration for syntax errors

sudo systemctl restart nginx  # If the test is successful, restart nginx to apply changes

# step 7 : Final Verification
exit  # Exit the ssh session from App Server 2

curl -Ik https://stapp02  # Run the curl command from the jump host
# You should see an HTTP/2 200 status code in the output, which confirms your setup is successful! 