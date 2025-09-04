# Day 9: MariaDB Troubleshooting
# There is a critical issue going on with the Nautilus application in Stratos DC. 
# The production support team identified that the application is unable to connect to the database. 
# After digging into the issue, the team found that mariadb service is down on the database server.
# Look into the issue and fix the same.


# Step 1 — SSH and Verify the Obvious
SSH into the database server, switched to the root user, and ran:
sudo systemctl start mariadb
# It failed. So I checked the reason for the failure with:
sudo systemctl status mariadb
# I got the Exit status: 1 (FAILURE), which usually means something’s wrong with permissions or missing directories.


# Step 2 — Permission Check on Data Directory
check and confirm that the data directory /var/lib/mysql existed and had the correct permissions with:
ls -ld /var/lib/mysql
# output was clean with the response “drwxr-xr-x mysql” which means mysql has read, write, and execute permissions, so no issues there.


# Step 3 — Deep Dive Into Error Logs
I dug deeper using the MariaDB error log with:

sudo cat /var/log/mariadb/mariadb.log | tail -30
# This simply asking to see the last 30 lines of the MariaDB error log located at /var/log/mariadb/mariadb.log


# Step 4 — Fixing the Root Cause
# Fix ownership of /var/lib/mysql recursively to mysql user and group
sudo chown -R mysql:mysql /var/lib/mysql

# Fix permissions of /var/lib/mysql directory to 700
sudo chmod 700 /var/lib/mysql

# Fix ownership and permissions of /run/mariadb directory
sudo chown -R mysql:mysql /run/mariadb
sudo chmod 755 /run/mariadb

# Restart MariaDB service
sudo systemctl restart mariadb

# Check status of MariaDB service
sudo systemctl status mariadb

