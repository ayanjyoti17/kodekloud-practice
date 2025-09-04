#Day 8: Install Ansible
#During the weekly meeting, the Nautilus DevOps team discussed about the automation and configuration management solutions that they want to implement. While considering several options, the team has decided to go with Ansible for now due to its simple setup and minimal pre-requisites. The team wanted to start testing using Ansible, so they have decided to use jump host as an Ansible controller to test different kind of tasks on rest of the servers.

# Install ansible version 4.10.0 on Jump host using pip3 only. Make sure Ansible binary is available globally on this system, i.e all users on this system are able to run Ansible commands.

#step 1 : Connect to the Jump Host
SSH into the jump host where Ansible will be installed:
ssh <username>@<jump-host>

#step 2: Ensure Python3 and pip3 Are Installed
python3 --version
pip3 --version

If not installed, install Python3 and pip3:

For CentOS/RHEL:
sudo yum install python3 python3-pip

#Step 3: Install Ansible 4.10.0 Using pip3 Globally
sudo pip3 install ansible==4.10.0

#Step 4: Verify Installation
ansible --version  # It should display version 4.10.0 and the installation path.
