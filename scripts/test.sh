#!/usr/bin/env bash

# Runs tests in Travis.

# Don't run tests if we're just working on the wild-truffle scripts.
if [[ "$TRAVIS_BRANCH" == "develop" || "$TRAVIS_BRANCH" == "master" ]]; then
  exit 0
fi

# Exit script as soon as a command fails.
set -o errexit

# Run unit tests
if [ "$COLONY" == true ]; then
  cd targets/colonyNetwork
  npm run test:contracts
  cd ../..
fi