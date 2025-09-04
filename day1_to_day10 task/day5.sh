#Day 5: SElinux Installation and Configuration
#Following a security audit, the xFusionCorp Industries security team has opted to enhance application and server security with SELinux. To initiate testing, the following requirements have been established for App server 1 in the Stratos Datacenter:


#Install the required SELinux packages.
#Permanently disable SELinux for the time being; it will be re-enabled after necessary configuration changes.
#No need to reboot the server, as a scheduled maintenance reboot is already planned for tonight.
#Disregard the current status of SELinux via the command line; the final status after the reboot should be disabled.


#Step 1: Connect to App Server 1 
ssh <username>@<app-server-1-hostname>

#step 2: Install the Required SELinux Packages
sudo yum install selinux-policy selinux-policy-targeted policycoreutils

#step 3: Permanently Disable SELinux
sudo vi /etc/selinux/config   #Edit the main SELinux configuration file

Find the line:   SELINUX=enforcing

Change it to:    SELINUX=disabled

Save and exit the file

#step 4: No Reboot Required Now, as you mentioned a maintenance reboot is already scheduled.

After the reboot, SELinux will be disabled because of the config change

