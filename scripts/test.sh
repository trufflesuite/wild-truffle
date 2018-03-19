#!/usr/bin/env bash

# Runs tests in Travis.

# Exit script as soon as a command fails.
set -o errexit

# Build truffle, post branch checkout
npm run build
chmod +x truffle_build/cli.bundled.js
chmod +x ganache_build/cli.node.js

# Run unit tests
if [ "$ZEPPELIN" == true ]; then
  cd targets/zeppelin-solidity
  npm test
  cd ../..
elif [ "$ARAGON" == true ]; then
  cd targets/aragonOS
  npm test
  cd ../..
elif [ "$COLONY" == true ]; then
  cd targets/colonyNetwork
  npm run test:contracts
  cd ../..
fi