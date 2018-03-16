#!/usr/bin/env bash

# Installs wild-truffle and its targets on a local environment, at a specified
# branch. Defaults to 'develop'
#
# Usage: npm run install:local <experimental-truffle-branch>


# Hack: `chai-bignumber` is not recognizing `truffle` bignumbers
# as instances unless we do this post install for Zeppelin.
patchBigNumber(){
  npm uninstall bignumber.js
  npm uninstall chai-bignumber
  npm install bignumber.js
  npm install chai-bignumber
}

# Install wild-truffle
echo "Installing wild-truffle ..."
npm install

echo ""
echo "Installing zeppelin-solidity ..."
echo ""

cd targets/zeppelin-solidity

npm install
patchBigNumber

cd ../..

echo ""
echo "Installing aragonOS ..."
echo ""

cd targets/aragonOS
npm install
cd ../..


echo ""
echo "Installing colonyNetwork ..."
echo ""

cd targets/colonyNetwork
yarn
cd ../..


# Install truffle dependencies via meta
echo ""
echo "Installing meta dependencies ..."
echo ""

TRUFFLE_BRANCH="develop"
GANACHE_BRANCH="develop"

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -t|--truffle)
    TRUFFLE_BRANCH="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--ganache)
    GANACHE_BRANCH="$2"
    shift # past argument
    shift # past value
    ;;
esac
done

echo ""
echo "Installing and linking Truffle: $TRUFFLE_BRANCH Ganache: $GANACHE_BRANCH ..."
echo ""

# Run `meta` setup
meta git update
meta git checkout $TRUFFLE_BRANCH
meta git checkout $GANACHE_BRANCH
meta npm install
meta npm symlink

