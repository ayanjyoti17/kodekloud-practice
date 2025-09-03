# Day 10: Linux Bash Scripts
'''The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks.
One is to create a bash script for taking websites backup. They have a static website running on App Server 3 in Stratos Datacenter, 
and they need to create a bash script named media_backup.sh which should accomplish the following tasks.
(Also remember to place the script under /scripts directory on App Server 3).

a. Create a zip archive named xfusioncorp_media.zip of /var/www/html/media directory.

b. Save the archive in /backup/ on App Server 3. This is a temporary storage, as backups from this location will be clean on weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.

c. Copy the created archive to Nautilus Backup Server server in /backup/ location.

d. Please make sure script wont ask for password while copying the archive file.
Additionally, the respective server user (for example, tony in case of App Server 1) must be able to run it.

e. Do not use sudo inside the script.
Note:
The zip package must be installed on given App Server before executing the script. 
This package is essential for creating the zip archive of the website files. Install it manually outside the script.'''

# Step 1: Install the zip package
Before writing and running the script, ensure the zip utility is installed on App Server 3.
sudo yum install zip -y

# Step 2: Configure passwordless SSH to Nautilus Backup Server
To copy the backup file without a password prompt, you need to generate an SSH key pair on App Server 3 and copy the public key to the Nautilus Backup Server.
Log in to App Server 3 as the user who will be running the script (e.g., banner@stapp03).
#Generate an SSH key pair ->  
ssh-keygen -t rsa

#Copy the public key to the Nautilus Backup Server (stbkp01). 
ssh-copy-id clint@stbkp01

#Verify the passwordless connection by trying to SSH or SCP to the backup server.
scp /etc/hosts clint@stbkp01:/tmp/
If successful, you will not be prompted for a password.

# Step 3: Create the backup script
Navigate to the /scripts directory and create the media_backup.sh script using a text editor like vi or nano.
mkdir -p /scripts
vi /scripts/media_backup.sh

Add the following content to the script. 

#!/bin/bash

# Define variables
BACKUP_DIR="/backup"
SOURCE_DIR="/var/www/html/media"
ARCHIVE_NAME="xfusioncorp_media.zip"
BACKUP_SERVER_USER="clint"
BACKUP_SERVER_HOST="stbkp01"
BACKUP_SERVER_PATH="/backup"

# Create the zip archive
zip -r ${BACKUP_DIR}/${ARCHIVE_NAME} ${SOURCE_DIR}

# Copy the archive to the Nautilus Backup Server
scp ${BACKUP_DIR}/${ARCHIVE_NAME} ${BACKUP_SERVER_USER}@${BACKUP_SERVER_HOST}:${BACKUP_SERVER_PATH}

echo "Backup completed successfully."

Save and exit the editor (:wq in vi).

# Step 4: Set script permissions and execute
chmod +x /scripts/media_backup.sh

# Execute the script as the relevant user (e.g., banner).
/scripts/media_backup.sh

# Step 5: Verify the backup file
To confirm the process worked correctly, you can check for the zip archive on both App Server 3 and the Nautilus Backup Server.
On App Server 3:
ls -l /backup/xfusioncorp_media.zip

On the Nautilus Backup Server:
ssh clint@stbkp01 'ls -l /backup/xfusioncorp_media.zip'