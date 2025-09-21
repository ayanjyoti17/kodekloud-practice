# Day 28: Git Cherry Pick
# The Nautilus application development team has been working on a project repository /opt/official.git. 
# This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared 
# the following requirements with the DevOps team:
There are two branches in this repository, master and feature. One of the developers is working on the 
feature branch and their work is still in progress, however they want to merge one of the commits from 
the feature branch to the master branch, the message for the commit that needs to be merged into master 
is Update info.txt. Accomplish this task for them, also remember to push your changes eventually.


# Solution ->>>>>>>>>>>>>
# first ssh into Storage Server..
cd /usr/src/kodekloudrepos/official
sudo git log / sudo git log feature --oneline   # Find the commit hash for "Update info.txt"
sudo git checkout master / sudo git switch master  # Switch to the branch where you want to apply the commit
sudo git cherry-pick <commit-hash>  # Replace <commit-hash> with the actual hash
# git cherry-pick is like copying and pasting a single commit from one branch to another.
sudo git push origin master