#!/usr/bin/env bash

# Installs wild-truffle and its targets on a local environment, at a specified
# branch. Defaults to 'develop'
#
# Usage: npm run install:local <experimental-truffle-branch>

#!/usr/bin/env bash

# Installs wild-truffle and its targets on Travis.

# Install wild-truffle
echo "Installing wild-truffle ..."
git clone https://github.com/trufflesuite/truffle.git

echo ""
echo "Installing colonyNetwork ..."
echo ""

cd targets
git clone https://github.com/JoinColony/colonyNetwork.git
cd colonyNetwork
yarn
git submodule update --init
rm -rf .git

# Load TRUFFLE_BRANCH variable
source .wildtruffle
source .wildganache

echo ""
echo "Checking out Truffle @ $TRUFFLE_BRANCH..."
echo ""

# Run
cd truffle
git checkout $TRUFFLE_BRANCH
npm run bootstrap
chmod +x truffle/packages/truffle/build/cli.bundled.js
