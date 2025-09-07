# Day 14: Linux Process Troubleshooting
# The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools 
# to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems 
# reported about Apache service unavailability on one of the app servers in Stratos DC.

# Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. 
# They might not have hosted any code yet on these servers, so you don’t need to worry if Apache isn’t serving any pages. 
# Just make sure the service is up and running. Also, make sure Apache is running on port 3004 on all app servers.


# step 1 : At first identify the app server which has issue by running the below commands
thor@jump_host ~$ telnet stapp01 3004
thor@jump_host ~$ telnet stapp02 3004
thor@jump_host ~$ telnet stapp03 3004

# step 2 : login on app server which has connection refuse error & switch to root 
thor@jump_host ~$ ssh tony@stapp01
sudo su -

# step 3 : check the existing Apache HTTPd service
systemctl start httpd
systemctl status httpd

# step 4 : With the help of  netstat check which service is using your port and whats is PID.
netstat -tulnp

# step 5 : Confirm the PID as per  the netstat output 
ps -ef  |grep sendmail
kill 772
ps -ef  |grep sendmail # recheck

# step 6 : Start the httpd service & check the status.
systemctl start httpd
systemctl status  httpd

# step 7 : Validate Apache HTTPd running  as per the task request
thor@jump_host ~$ telnet stapp01 3004
# output ->>
Trying 172.16.238.10...

Connected to stapp01.

Escape character is '^]'.

#########################   The task successfully completed, you can check