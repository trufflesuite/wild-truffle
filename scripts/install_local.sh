#!/usr/bin/env bash

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

# Load TRUFFLE_BRANCH variable
# Set default truffle branch to checkout
TRUFFLE_BRANCH="develop"

# Set to check branch to command line arg if present
if ! [ -z $1 ]; then
  TRUFFLE_BRANCH=$1
fi

echo ""
echo "Installing and linking branch: $TRUFFLE_BRANCH ..."
echo ""

# Run `meta` setup
meta git update
meta git checkout $TRUFFLE_BRANCH
meta npm install
meta npm symlink

