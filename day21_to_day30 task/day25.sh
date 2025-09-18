# Day 25: Git Merge Branches
# The Nautilus application development team has been working on a project repository /opt/blog.git. 
# This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. 
# They recently shared the following requirements with DevOps team:
Create a new branch nautilus in /usr/src/kodekloudrepos/blog repo from master and 
copy the /tmp/index.html file (present on storage server itself) into the repo. Further, 
add/commit this file in the new branch and merge back that branch into master branch. 
Finally, push the changes to the origin for both of the branches.

# solution ->>>>>>>>>>>>>>>>
# first ssh into the storager server .
cd /usr/src/kodekloudrepos/blog
sudo git checkout master
sudo git pull origin master
sudo git checkout -b nautilus # This creates the branch AND switches to it in one step
sudo cp /tmp/index.html .
sudo git add index.html
sudo git commit -m "Added index.html file"
sudo git checkout master
sudo git merge nautilus
sudo git push origin master
sudo git push origin nautilus