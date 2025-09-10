# Day 16: Install and Configure Nginx as an LBR
# Day by day traffic is increasing on one of the websites managed by the Nautilus production support team. 
# Therefore, the team has observed a degradation in website performance. Following discussions about this issue, 
# the team has decided to deploy this application on a high availability stack i.e on Nautilus infra in Stratos DC. 
# They started the migration last month and it is almost done, as only the LBR server configuration is pending. 
# Configure LBR server as per the information given below:

# a. Install nginx on LBR (load balancer) server.

# b. Configure load-balancing with the an http context making use of all App Servers. 
#   Ensure that you update only the main Nginx configuration file located at /etc/nginx/nginx.conf.

# c. Make sure you do not update the apache port that is already defined in the apache configuration on all app servers, 
#   also make sure apache service is up and running on all app servers.

# d. Once done, you can access the website using StaticApp button on the top bar. now do this task step by step


# step 1 : Connect to the LBR Server
ssh clint@stlb01

# step 2 : Install and Started Nginx
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# step 3 : Confirmed the port which Apache was running on the App servers
I SSH into the app server and verified Apache status and its listening port, I discovered the listening port was “8088”:

sudo systemctl status httpd
sudo ss -tulnp | grep httpd

# step 4 : Configure the Load Balancer
sudo vi /etc/nginx/nginx.conf  # Open the configuration file
# Define the upstream servers and Configure the proxy_pass and your nginx.conf should look like this:
upstream app_servers {
server stapp01.stratos.xfusioncorp.com:8088;
server stapp02.stratos.xfusioncorp.com:8088;
server stapp03.stratos.xfusioncorp.com:8088;
}
server {
listen 80;
listen [::]:80;
server_name _;
location / {
proxy_pass http://app_servers;
}
error_page 404 /404.html;
location = /404.html {}
error_page 500 502 503 504 /50x.html;
location = /50x.html {}
}

# step 5 : Validated and Reloaded Nginx
sudo nginx -t
sudo systemctl reload nginx

# step 6 : Result
After configuring the setup, I tested it using the platform’s StaticApp button. 
The traffic was successfully being routed across all app servers, confirming that load balancing worked as expected!