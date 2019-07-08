#!/bin/bash
set -ev

# Keeps the wiki on https://github.com/codeoverflow-org/chatoverflow/wiki synchronized with the current master! 

git checkout master

echo "Configuring git..."
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git remote add wiki https://${GH_TOKEN}@github.com/codeoverflow-org/chatoverflow.wiki.git >/dev/null 2>&1

echo "Excluding files:"
git rm README.md --cached
git rm .synchronize-wiki.sh --cached
git rm .travis.yml --cached
git commit --message "Synchronized wiki (Travis build #$TRAVIS_BUILD_NUMBER)"

echo "Pushing wiki..."
git push --force wiki master