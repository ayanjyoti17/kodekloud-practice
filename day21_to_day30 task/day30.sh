# Day 30: Git hard reset
# The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/demo 
# present on Storage server in Stratos DC. This was just a test repository and one of the developers just 
# pushed a couple of changes for testing, but now they want to clean this repository along with the commit 
# history/work tree, so they want to point back the HEAD and the branch itself to a commit with message add data.txt file. 
# Find below more details:

1. In /usr/src/kodekloudrepos/apps git repository, reset the git commit history so that there are only two commits 
in the commit history i.e initial commit and add data.txt file.
2. Also make sure to push your changes.

# solution ->>>>>>>>>>>>
first ssh into storage server ..
go to the repo -> cd /usr/src/kodekloudrepos/demo

# Find the commit with the message "add data.txt file"
sudo git log

# sudo git reset --hard <git-commit>
sudo git reset --hard d38e43d44a9ccf4c137ef1f906ec69d770a8b71a

# Force Push the Changes
sudo git push -f