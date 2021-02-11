read -p "Commit description: " desc  
git pull origin master
git add .  
git commit -m "$desc"
git push origin master