#!/bin/bash
set -ev

# Keeps the wiki on https://github.com/codeoverflow-org/chatoverflow/wiki synchronized with the current master! 

git checkout master

echo "Configuring git..."
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git remote add wiki https://${GH_TOKEN}@github.com/codeoverflow-org/chatoverflow.wiki.git >/dev/null 2>&1

echo "Fixing named links..."
# Change [Structure](development/Structure.md) to [Structure](Structure) as the wiki works that way
find . -type f -name "*.md" -exec sed -i 's:\[\([^\n]\+\)\](\([^ \n]\+/\)*\([^ \n/]\+\)\.md\(#[^ \n/]\+\)\?):[\1](\3\4):g' {} +
# Strip leading backslashes from links as all markdown files will be in the root of the final wiki
find . -type f -name "*.md" -exec sed -i 's:\[\([^\n]*\)\](/\([^ \n]\+\)):[\1](\2):g' {} +
git add .

echo "Excluding files:"
git rm README.md --cached
git rm .synchronize-wiki.sh --cached
git rm .travis.yml --cached

git commit --message "Synchronized wiki (Travis build #$TRAVIS_BUILD_NUMBER)"

echo "Pushing wiki..."
git push --force wiki master

# This file is not included in the wiki.