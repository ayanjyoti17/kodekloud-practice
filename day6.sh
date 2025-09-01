#Day 6: Create a Cron Job
#The Nautilus system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in Stratos DC on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:


#a. Install cronie package on all Nautilus app servers and start crond service.

#b. Add a cron */5 * * * * echo hello > /tmp/cron_text for root user. 


# step 1 : Log in to each app server:
ssh <username>@<server-hostname>

# step 2 : Install the cronie package:
sudo yum install cronie -y    # -y automatically confirms any prompts during installation

#step 3 : Start the crond service:
sudo systemctl start crond

#step 4 : Enable crond to start on boot: To ensure crond automatically starts if the server is restarted, enable it.
sudo systemctl enable crond

#step 5: Add a cron job for the root user:
sudo crontab -e
Add the cron entry: In the editor that opens (often vi or nano), add the following line at the end->
*/5 * * * * echo hello > /tmp/cron_text

# step 6 : Save and exit the crontab editor:
If using vi, press Esc, then type :wq and press Enter.
If using nano, press Ctrl+X, then Y to confirm saving, and Enter.
