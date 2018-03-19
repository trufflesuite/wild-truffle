#!/usr/bin/env bash

# Installs wild-truffle and its targets on Travis.

# Hack: `chai-bignumber` is not recognizing `truffle` bignumbers
# as instances unless we do this post install for Zeppelin.
patchBigNumber(){
  npm uninstall bignumber.js
  npm uninstall chai-bignumber
  npm install bignumber.js
  npm install chai-bignumber
}

# Don't run tests if we're just working on the wild-truffle scripts.
if [["$TRAVIS_BRANCH" == "develop" || $TRAVIS_BRANCH == "master"]]; then
  exit 0
fi

# Install wild-truffle
echo "Installing wild-truffle ..."
npm install -g yarn
npm install -g meta
npm install

# Install matrix target
if [ "$ZEPPELIN" = true ]; then

  echo ""
  echo "Installing zeppelin-solidity ..."
  echo ""

  cd targets/zeppelin-solidity
  npm install
  patchBigNumber
  cd ../..

elif [ "$ARAGON" = true ]; then

  echo ""
  echo "Installing aragonOS ..."
  echo ""

  cd targets/aragonOS
  npm install
  cd ../..

elif [ "$COLONY" = true ]; then

  echo ""
  echo "Installing colonyNetwork ..."
  echo ""

  cd targets/colonyNetwork
  yarn
  cd ../..
fi


# Install truffle dependencies via meta
echo ""
echo "Installing meta dependencies ..."
echo ""

# Load TRUFFLE_BRANCH variable
source .wildtruffle
source .wildganache

echo ""
echo "Checking out Truffle @ $TRUFFLE_BRANCH, Ganache @ $GANACHE_BRANCH ..."
echo ""

# Run `meta` setup
meta git update
meta git checkout $TRUFFLE_BRANCH
meta pkgs checkout "ganache-core@$GANACHE_BRANCH"
meta npm install
meta npm symlink


