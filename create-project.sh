#! /usr/bin/bash

# create new directory
read -p "Enter new project name: " NAME
mkdir $NAME
cd $NAME/

# create readme
touch readme.md
echo "readme created"

# init git
git init
echo "git init"

# create new git repo
gh repo create $NAME --public

# add remote
git remote add origin "https://github.com/David-Orson/$NAME"
echo "https://github.com/David-Orson/$NAME"
git remote -v
echo "done"

# add commit
git add .
git commit -m "inital commit"

# push
git branch -M main
git push origin main

echo "Success"
