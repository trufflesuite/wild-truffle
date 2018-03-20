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


# Set default truffle branch to checkout
TRUFFLE_BRANCH="develop"
GANACHE_BRANCH="develop"

# Parse cli options
while getopts 't:g:' key;
do
case "${key}" in
    t) TRUFFLE_BRANCH="${OPTARG}" ;;
    g) GANACHE_BRANCH="${OPTARG}" ;;
    *) echo "Unrecognized arg: ${flag}";;
esac
done


echo ""
echo "Installing and linking Truffle: $TRUFFLE_BRANCH Ganache: $GANACHE_BRANCH ..."
echo ""

# Run `meta` setup
meta git update
meta git checkout $TRUFFLE_BRANCH
meta pkgs checkout "ganache-core@$GANACHE_BRANCH"
meta npm install
meta npm symlink
