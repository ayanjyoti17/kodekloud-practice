#Day 3: Secure Root SSH Access
#Following security audits, the xFusionCorp Industries security team has rolled out new protocols, including the restriction of direct root SSH login.

#Your task is to disable direct SSH root login on all app servers within the Stratos Datacenter.

#step 1 : Login to Each App Server
Open Three Terminal and ssh on all App server
#on Terminal one
ssh tony@stapp01
#on Terminal Two
ssh steve@stapp02
#on Terminal three
ssh banner@stapp03

#step 2 : Edit the SSH Configuration File
sudo vi /etc/ssh/sshd_config

#step 3 : Find and Modify the Parameter
Look for the line containing:
PermitRootLogin

If it’s commented out (starts with '#'), remove the '#'. Set it to:
PermitRootLogin no

This setting disables SSH login as root.

#step 4 : Save and Close the File

#step 5 : Restart the SSH service
sudo systemctl restart sshd

#step 6 : Test the Change
Attempt SSH login as root from a different terminal to confirm it’s now denied.
