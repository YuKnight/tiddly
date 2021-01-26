#!/bin/bash

# go to the output directory and create a new git repo
cd ./*wiki/output || exit 1 # abort script if folder does not exists
git init || exit 2

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI" || exit 3
git config user.email "${GH_EMAIL}" || exit 4

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
git add . || exit 5
git commit -m "Deploy to GitHub Pages $(date)" || exit 6

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" main:gh-pages > /dev/null 2>&1 || exit 7