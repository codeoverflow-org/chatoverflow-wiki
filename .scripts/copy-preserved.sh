#!/usr/bin/env bash
# Perserves the readme, the CNAME and the java & scaladocs by copying them from the latest commit
# of the gh-pages repo to the site dir

cp -r gh-pages/code/ site/code/
cp gh-pages/readme.md site/readme.md
cp gh-pages/CNAME site/CNAME