#Day 4: Script Execution Permissions
#In a bid to automate backup processes, the xFusionCorp Industries sysadmin team has developed a new bash script named xfusioncorp.sh. While the script has been distributed to all necessary servers, it lacks executable permissions on App Server 3 within the Stratos Datacenter.

#Your task is to grant executable permissions to the /tmp/xfusioncorp.sh script on App Server 3. Additionally, ensure that all users have the capability to execute it.

#step 1 : Login to App Server 3
ssh <your-username>@<App-Server-3-hostname>

#step 2 : Grant Execute Permission to Everyone
sudo chmod a+x /tmp/xfusioncorp.sh # This command adds (the + sign) execute permission (x) for all users (a stands for all users: owner, group, and others.)

#step 3 : Give Read Permission Alongside Execute
sudo chmod 755 /tmp/xfusioncorp.sh

#step 4 : Verify Permissions
ls -l /tmp/xfusioncorp.sh

#The output should look like this: -rwxr-xr-x 1 root root ... /tmp/xfusioncorp.sh
#This means the owner can read/write/execute, others can read and execute.

