#!/usr/bin/env bash

# Installs wild-truffle and its targets on a local environment, at a specified
# branch. Defaults to 'develop'
#
# Usage: npm run install:local -- -t <experimental-truffle-branch>

#!/usr/bin/env bash

# Installs wild-truffle and its targets on Travis.
TRUFFLE_BRANCH="next"

# Install wild-truffle
echo "Installing wild-truffle ..."
git clone https://github.com/trufflesuite/truffle.git

while getopts 't:g:' key;
do
case "${key}" in
    t) TRUFFLE_BRANCH="${OPTARG}" ;;
    g) GANACHE_BRANCH="${OPTARG}" ;;
    *) echo "Unrecognized arg: ${flag}";;
esac
done

echo ""
echo "Checking out Truffle @ $TRUFFLE_BRANCH..."
echo ""

# Run
cd truffle
git checkout $TRUFFLE_BRANCH
npm run bootstrap
rm -rf .git
cd packages/truffle
npm run build
chmod +x build/cli.bundled.js
cd ../../..

echo ""
echo "Installing colonyNetwork ..."
echo ""

mkdir targets
cd targets
git clone https://github.com/JoinColony/colonyNetwork.git
cd colonyNetwork
yarn
git submodule update --init
rm -rf .git

NEWPATH="./../../truffle/packages/truffle/build/cli.bundled.js"
sed -i.bak "s|truffle|$NEWPATH|g" package.json
sed -i.bak 's|"test:contracts"|"wildtruffle"|g' package.json
npm run wildtruffle


