# Day 33: Resolve Git Merge Conflicts
# Sarah and Max were working on writting some stories which they have pushed to the repository. Max has 
# recently added some new changes and is trying to push them to the repository but he is facing some issues. 
# Below you can find more details:

SSH into storage server using user max and password Max_pass123. Under /home/max you will find the 
story-blog repository. Try to push the changes to the origin repo and fix the issues. The story-index.txt 
must have titles for all 4 stories. Additionally, there is a typo in The Lion and the Mooose line where 
Mooose should be Mouse.

# Click on the Gitea UI button on the top bar. You should be able to access the Gitea page. You can login to 
# Gitea server from UI using username sarah and password Sarah_pass123 or username max and password Max_pass123.


# solution ->>>>>>>>
ssh max@ststor01
cd story-blog
vim story-index.txt

# Commit and Push the Fix
git add .
git commit -m "Fix typo error"
git push origin

git pull
git status

vi story-index.txt
git add story-index.txt
git commit -m "story-index fix conflict"
git status
git push
