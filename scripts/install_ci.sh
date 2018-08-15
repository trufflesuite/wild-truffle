#!/usr/bin/env bash

# Installs wild-truffle and its targets on Travis.

# Don't run tests if we're just working on the wild-truffle scripts.
if [[ "$TRAVIS_BRANCH" == "develop" || "$TRAVIS_BRANCH" == "master" ]]; then
  exit 0
fi

# Install wild-truffle
echo "Installing wild-truffle ..."
npm install -g yarn
npm install -g lerna
git clone https://github.com/trufflesuite/truffle.git

if [ "$COLONY" = true ]; then
  echo ""
  echo "Installing colonyNetwork ..."
  echo ""

  cd targets
  git clone https://github.com/JoinColony/colonyNetwork.git
  cd colonyNetwork
  yarn
  git submodule update --init
  node ../../scripts/linkTruffle.js colony
fi

# Load TRUFFLE_BRANCH variable
source .wildtruffle
#source .wildganache

echo ""
echo "Checking out Truffle @ $TRUFFLE_BRANCH..."
echo ""

# Run
cd truffle
git checkout $TRUFFLE_BRANCH
npm run bootstrap
chmod +x truffle/packages/truffle/build/cli.bundled.js
