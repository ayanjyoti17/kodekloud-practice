# Day 12: Linux Network Services
# Our monitoring tool has reported an issue in Stratos Datacenter.One of our app servers has an issue, as its 
# Apache service is not reachable on port 5002 (which is the Apache port). The service itself could be down, 
# the firewall could be at fault, or something else could be causing the issue. Use tools like telnet, netstat, etc. 
# to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings. 
# Once fixed, you can test the same using command curl http://stapp01:5002 command from jump host. 
# Note: Please do not try to alter the existing index.html code, as it will lead to task failure.


# step 1 : From jump host: confirm the issue
curl -v http://stapp01:5002
# To confirm Apache on port 5002 isn’t reachable yet.

# step 2 : SSH to app server
ssh tony@stapp01
sudo su 
# Log in to the target server and get root to manage services and firewall rules.

# step 3 : Check Apache service status
systemctl status httpd
# Verify Apache is running and see status messages (e.g., “listening on: port 5002”).

# step 4 : Apache was not running, so I started it: 
systemctl start httpd

# step 5 : Check Apache is listening on port 5002
netstat -tulpn | grep ':5002' 
# Confirms a process (httpd) is actually bound to 0.0.0.0:5002 or :::5002 so remote hosts can connect.

# step 6 : Terminate the Conflicting Process 
kill 451 
#The output revealed that another process (sendm, PID 451) was using port 5004, causing Apache to fail with the error ‘Address already in use’.

# step 5 : Open the firewall (iptables path)
iptables -L -n -v
#Review current INPUT rules; many lab images have a REJECT near the end blocking non-standard ports by default.

iptables -I INPUT -p tcp --dport 5002 -j ACCEPT
# Insert an allow rule for TCP port 5002 so inbound HTTP to Apache is permitted by the host firewall.

iptables-save > /etc/sysconfig/iptables
# Persist the change so it survives reboot on RHEL/CentOS-based systems used in the lab.

# step 6 : Re-test from jump host
curl -v http://stapp01:5002
# Confirms end-to-end connectivity and matches the lab’s validation method.
