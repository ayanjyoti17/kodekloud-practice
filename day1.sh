#Day 1: Linux User Setup with Non-Interactive Shell
#create a user named yousuf with a non-interactive shell on App Server 1

#step 1 : Login to App Server 1
ssh <username>@<app-server-1-hostname>

#step 2 : Create the User with a Non-Interactive Shell
sudo useradd -s /sbin/nologin yousuf # -s sets the  shell to /sbin/nologin. This means the user cannot open a command-line session/run commands interactively.

#step3 : Check the User Was Created
id yousuf 
or
cat /etc/passwd | grep yousuf

