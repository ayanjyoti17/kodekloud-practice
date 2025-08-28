#Day 2: Temporary User Setup with Expiry
#Create a user named mariyam on App Server 1 in Stratos Datacenter. Set the expiry date to 2024-03-28, ensuring the user is created in lowercase as per standard protocol.

#step 1 : Connect to App Server 1
ssh username@<app-server-1-ip-address>

#step 2 : Create the User with Expiry Date
sudo useradd mariyam -e 2024-03-28 # -e specifies the account expiry date in YYYY-MM-DD format.

#step 3 : Verify User Creation and Expiry
sudo chage -l mariyam # chage command used to manage and view user password expiration and account aging information. It stands for "change age" . 
# Using the -l option, you can list the current password aging settings for a specific user

