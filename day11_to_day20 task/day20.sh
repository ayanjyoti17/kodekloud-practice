# Day 20: Configure Nginx + PHP-FPM Using Unix Sock
# The Nautilus application development team is planning to launch a new PHP-based application, 
# which they want to deploy on Nautilus infra in Stratos DC. The development team had a meeting 
# with the production support team and they have shared some requirements regarding the infrastructure. 
# Below are the requirements they shared:
a. Install nginx on app server 3 , configure it to use port 8095 and its document root should be /var/www/html.
b. Install php-fpm version 8.1 on app server 3, it must use the unix socket /var/run/php-fpm/default.sock 
(create the parent directories if dont exist).
c. Configure php-fpm and nginx to work together.
d. Once configured correctly, you can test the website using curl http://stapp03:8095/index.php command from jump host.
NOTE: We have copied two files, index.php and info.php, under /var/www/html as part of the PHP-based application setup. 
Please do not modify these files.

# All the following commands should be run on app server 3 (stapp03) 
# step 1 : # install nginx
sudo yum install -y nginx

# Enable and start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

sudo vi /etc/nginx/nginx.conf
'''
server {
        listen       8095;
        listen       [::]:8095;
        server_name  stapp01;
        root         /var/www/html;
        index        index.php info.php;

        # Add the new block here
        location ~ \.php$ {
            fastcgi_pass   unix:/var/run/php-fpm/default.sock;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    } 
'''

# step 2 : Install php-fpm version 8.1
[tony@stapp01 ~]$ cat /etc/redhat-release
CentOS Stream release 9
# PHP 8.3 is available via the AppStream modules, so we can install it natively.
# Enable PHP 8.3 module
sudo dnf module enable php:8.3 -y
#Install PHP 8.3 and PHP-FPM
sudo dnf install php php-cli php-fpm php-mysqlnd -y

php -v

# Create socket directory
sudo mkdir -p /var/run/php-fpm
sudo chown -R nginx:nginx /var/run/php-fpm
sudo chmod -R 755 /var/run/php-fpm

# step 3 : Configure php-fpm and nginx
# Configure PHP-FPM pool
sudo vi /etc/php-fpm.d/www.conf

''' 
;   '/path/to/unix/socket' - to listen on a unix socket.
; Note: This value is mandatory.
listen = /var/run/php-fpm/default.sock

; Set listen(2) backlog.
; Default Value: 511
;listen.backlog = 511

; Set permissions for unix socket, if one is used. In Linux, read/write
; permissions must be set in order to allow connections from a web server.
; Default Values: user and group are set as the running user
;                 mode is set to 0660
listen.owner = nginx
listen.group = nginx
listen.mode = 0660

; When POSIX Access Control Lists are supported you can set them using
; these options, value is a comma separated list of user/group names.
-- INSERT -- 
'''

# Start PHP-FPM
sudo systemctl start php-fpm
sudo systemctl enable php-fpm

# Start Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Check services status
sudo systemctl status php-fpm
sudo systemctl status nginx
# Verify Socket Creation

# Check if socket was created
ls -la /var/run/php-fpm/default.sock

# If socket doesn't exist, restart PHP-FPM
sudo systemctl restart php-fpm
ls -la /var/run/php-fpm/default.sock
# Test Nginx configuration
sudo nginx -t

# step 4 : verification
# Test from local server
curl http://localhost:8095/index.php
curl http://localhost:8095/info.php