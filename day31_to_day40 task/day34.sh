# Day 34: Git Hook
# The Nautilus application development team was working on a git repository /opt/beta.git which is 
# cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to 
# setup a hook on this repository, please find below more details:

1. Merge the feature branch into the master branch , but before pushing your changes complete below point.
2. Create a post-update hook in this git repository so that whenever any changes are pushed to the master branch, 
   it creates a release tag with name release-2023-06-15, where 2023-06-15 is supposed to be the current date. For 
   example if today is 20th June, 2023 then the release tag must be release-2023-06-20. Make sure you test the hook 
   at least once and create a release tag for todays release.
3. Finally remember to push your changes.
Note: Perform this task using the natasha user, and ensure the repository or existing directory permissions are not altered.


# Step 1: Merge the feature Branch into master
First, log in to the storage server. Then, navigate to the cloned repository, switch to the master branch, and merge the feature branch.
# Navigate to the cloned repository directory
cd /usr/src/kodekloudrepos/beta
# Switch to the master branch
git checkout master
# Merge the feature branch into master
git merge feature

# Step 2: Create the post-update Hook

# Navigate to the bare repository's hooks directory
cd /opt/beta.git/hooks

# Create a new hook file named 'post-update'
touch post-update

# step 3: Add the Script Logic
Edit the post-update file and add the script that will create a dated release tag whenever the master branch is updated.
# Open the file in an editor, for example, vi
vi post-update
Add the following content to the file. This script checks if the master branch was updated and, 
if so, creates a tag with the current date.

#!/bin/sh

# Check if the master branch was updated
if echo "$@" | grep -q "refs/heads/master"; then
    # Get current date in YYYY-MM-DD format
    CURRENT_DATE=$(date +%F)
    TAG_NAME="release-${CURRENT_DATE}"

    # Create the tag in the repository
    git tag "$TAG_NAME"
    echo "Hook executed: Created tag '${TAG_NAME}'"
fi

exit 0
Save and close the file.

# Step 4: Make the Hook Executable
For Git to run your script, you must give it execute permissions.
# Make the post-update script executable
chmod +x post-update

# Step 5: Push Changes and Test the Hook
Go back to the cloned repository and push the merged master branch to the remote (origin). This action will 
trigger the post-update hook on the server.
# Navigate back to the cloned repository
cd /usr/src/kodekloudrepos/beta
# Push the master branch to the remote repository
git push origin master
After the push completes, you should see the echo message from the hook script, confirming that the tag was created.

# Step 6: Verify the Tag
Finally, verify that the tag was created successfully by listing the tags in the bare repository.
# Navigate to the bare repository
cd /opt/beta.git
# List all tags
git tag
You will see the new release tag in the output, for example: release-2025-09-27.