#!/usr/bin/env bash

# Installs wild-truffle and its targets on Travis.

# Don't run tests if we're just working on the wild-truffle scripts.
if [[ "$TRAVIS_BRANCH" == "develop" || "$TRAVIS_BRANCH" == "master" ]]; then
  exit 0
fi

# Install wild-truffle
echo "Installing wild-truffle ..."
docker pull ethereum/solc:0.4.23
npm install -g yarn
npm install -g lerna
git clone https://github.com/trufflesuite/truffle.git

TRUFFLE_BRANCH="next"

# Load TRUFFLE_BRANCH variable
source .wildtruffle
source .wildganache

echo ""
echo "Checking out Truffle @ $TRUFFLE_BRANCH..."
echo ""

cd truffle
git checkout $TRUFFLE_BRANCH
npm run bootstrap
cd packages/truffle
npm run build
chmod +x build/cli.bundled.js
cd ../../..

if [ "$COLONY" = true ]; then
  echo ""
  echo "Installing colonyNetwork ..."
  echo ""

  mkdir targets
  cd targets
  git clone https://github.com/JoinColony/colonyNetwork.git
  cd colonyNetwork
  yarn
  git submodule update --init

  NEWPATH="./../../truffle/packages/truffle/build/cli.bundled.js"
  sed -i.bak "s|truffle|$NEWPATH|g" package.json
  sed -i.bak 's|"test:contracts"|"wildtruffle"|g' package.json
  npm run wildtruffle
fi

