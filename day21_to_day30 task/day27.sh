# Day 27: Git Revert Some Changes
# The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/media present 
# on Storage server in Stratos DC. However, they reported an issue with the recent commits being pushed to this repo. 
# They have asked the DevOps team to revert repo HEAD to last commit. Below are more details about the task:
1. In /usr/src/kodekloudrepos/media git repository, revert the latest commit ( HEAD ) to the previous commit 
(JFYI the previous commit hash should be with initial commit message ).
2. Use revert apps message (please use all small letters for commit message) for the new revert commit.


# solution ->>>>>>>>>>>>>>>>>>
# first ssh into storage server..
sudo git revert HEAD 
# no edit
sudo git commit -- amend -m "revert apps"