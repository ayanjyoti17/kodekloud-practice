# Day 24: Git Create Branches
# Nautilus developers are actively working on one of the project repositories, /usr/src/kodekloudrepos/blog. 
# ecently, they decided to implement some new features in the application, and they want to maintain those 
# new changes in a separate branch. Below are the requirements that have been shared with the DevOps team:

1. On Storage server in Stratos DC create a new branch xfusioncorp_blog from master branch in /usr/src/kodekloudrepos/blog git repo.
2. Please do not try to make any changes in the code.

# Step 1: Navigate to the Git Repository
cd /usr/src/kodekloudrepos/blog

# Step 2: Ensure You Are on the Master Branch
sudo git branch
sudo git checkout master

# Step 3: Create the New Branch
sudo git checkout -b xfusioncorp_official 
# git checkout -b command creates a new branch from your current branch (master) and immediately switches to it.

# Step 4: Verify the Branch
sudo git branch