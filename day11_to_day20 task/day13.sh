# Day 13: IPtables Installation And Configuration
# We have one of our websites up and running on our Nautilus infrastructure in Stratos DC.
# Our security team has raised a concern that right now Apache’s port i.e 6300 is open for all 
# since there is no firewall installed on these hosts. So we have decided to add some security 
# layer for these hosts and after discussions and recommendations we have come up with the following requirements:
# 1. Install iptables and all its dependencies on each app host.
# 2. Block incoming port 6300 on all apps for everyone except for LBR host.
# 3. Make sure the rules remain, even after system reboot.

#SOLUTION ->>>>

# Step 1: Connect to Each App Server
# First, you Will need to SSH into each application server. You will likely connect from the jump_host.
# For example, to connect to stapp01:
ssh tony@stapp01.stratos.xfusioncorp.com
# You will be prompted for the password, which is lr0nM@n.
# Repeat this process for the other app servers using their respective credentials:
stapp02: ssh steve@stapp02.stratos.xfusioncorp.com
stapp03: ssh banner@stapp03.stratos.xfusioncorp.com

# Step 2: Run the Firewall Configuration Script
# 1. Ensure the necessary service is installed and running
sudo yum install -y iptables-services
sudo systemctl enable --now iptables

# 2. Flush all existing rules to guarantee a clean slate
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -X

# 3. Set a default policy to DROP incoming traffic
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

# 4. Add essential ACCEPT rules to the INPUT chain
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 5. Add the critical rule for the LBR on the NEW port 6300
sudo iptables -A INPUT -p tcp -s 172.16.238.14 --dport 6300 -j ACCEPT

# 6. Save the rules and restart Docker
sudo service iptables save
sudo systemctl restart docker

echo "Firewall configured for port 6300 and saved."

---->>>> Run this script on all three of your app servers (stapp01, stapp02, stapp03).

# Step 3: Verify the Configuration
# Check Active Rules: Run 
sudo iptables -L INPUT -v -n --line-numbers
# You should see the (policy DROP) and an ACCEPT rule for dpt:6300 from the LBR's IP.

# Check Saved Rules: Run 
sudo cat /etc/sysconfig/iptables
# Make sure the file contains the line :INPUT DROP and the rule for port 6300.