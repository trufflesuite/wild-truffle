#!/bin/bash

# Run this locally. It sets up the environment so Travis knows
# which `truffle` branch to check out and pushes a throwaway branch
# to GH, triggering the CI build.
#
# usage: $ npm run ci <truffle-branch-to-checkout>
#

# Verify we're not attempting to push to a protected branch
STATUS=$(git status)

if [[ $STATUS = *"master"* || $STATUS = *"develop"* ]]; then
  echo ""
  echo "** ERROR **"
  echo "You're on a protected branch (master/develop)."
  echo "Create a throwaway branch first: git checkout -b <throw-away-name>"
  echo ""
  exit 0
fi

# Get wildtruffle branch name
WILD=$(git rev-parse --abbrev-ref HEAD)
EXISTS=$(git ls-remote --heads git@github.com:trufflesuite/wild-truffle.git $WILD | wc -l)

# Set default truffle branch to checkout
BRANCH="develop"

# Set to check branch to command line arg if present
if ! [ -z $1 ]; then
  BRANCH=$1
fi

# Write truffle branch we should checkout in CI
printf "TRUFFLE_BRANCH=\"$BRANCH\"" > .wildtruffle

# Make sure git thinks we changed something
date +%s > .dirty

# Get a helpful identifier for the commit
TIME_ID=`date +%Y-%m-%d::%H:%M:%S`

# Commit
echo ""
echo "Committing..."
echo ""

git add -A
git commit -a -m "Truffle branch \"$BRANCH\" at $TIME_ID"

# Push
echo ""
echo "Pushing..."
echo ""

if [ $EXISTS == 0 ]; then
  git push --set-upstream origin $WILD
else
  git push
fi

# Goodbye
echo ""
echo "Running \"$BRANCH\" on Travis (shortly)."
echo ""
