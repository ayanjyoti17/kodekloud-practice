#Day 7: Linux SSH Authentication
#The system admins team of xFusionCorp Industries has set up some scripts on jump host that run on regular intervals and perform operations on all app servers in Stratos Datacenter. To make these scripts work properly we need to make sure the thor user on jump host has password-less SSH access to all app servers through their respective sudo users (i.e tony for app server 1). Based on the requirements, perform the following:


#Set up a password-less authentication from user thor on jump host to all app servers through their respective sudo users.

#step 1 : Generate SSH Key Pair on Jump Host as User thor
ssh-keygen

#step 2 : Copy the Public Key to Each App Server for the sudo User
ssh-copy-id tony@app-server-1-hostname
Repeat for all app servers with their respective sudo users, changing user and hostname accordingly.

#step 3 : Verify Password-less SSH Access
From jump host as user thor, test SSH connection without a password prompt:
ssh tony@app-server-1-hostname
If it logs in without asking for a password, setup is successful.

