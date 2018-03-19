# wild-truffle
[![Build Status](https://travis-ci.org/trufflesuite/wild-truffle.svg?branch=develop)](https://travis-ci.org/trufflesuite/wild-truffle)

`wild-truffle` lets you run unpublished Truffle changes against a selection of existing commercial Truffle projects:
+ [zeppelin-solidity](https://github.com/OpenZeppelin/zeppelin-solidity/tree/7586e383c2e9d62b2f1d414e850ab365afef6d89) (at commit 7586e38)
+ [aragonOS](https://github.com/aragon/aragonOS/tree/501a90515287a8bfe015f5416e5e6aa07ced0ec4) (at commit 501a905)
+ [colonyNetwork](https://github.com/JoinColony/colonyNetwork/tree/8678f4bd7e2e93260cc40e3bdc002d8e1e3008c5) (at commit 8678f4b)

It extends Truffle's scenario testing regime to include an ~800 unit battery that reflects real usage of the toolset.

## Use (on [Travis](https://travis-ci.org/trufflesuite/wild-truffle/branches))

Test an experimental Truffle branch (may span several modules) against the projects listed above on Travis CI and see what breaks.

```shell
git clone  https://github.com/trufflesuite/wild-truffle.git # no need to `npm install`
git checkout -b <throw-away-branch-name>                    # checkout a throw-away branch.

# Run truffle and ganache at develop in CI (default)
npm run ci

# Or run against specific branches
npm run ci -- -t <truffle-branch> -g <ganache-branch>
```

## Use locally

Install `wild-truffle` locally to debug a target's test failures against a branch.

```shell
npm install -g meta
npm install -g yarn

# Install truffle and ganache @ `develop`
npm run install:local

# Or install at a specific branch (useful if its deps are different)
npm run install:local -- -t <truffle-branch> -g <ganache-branch>

# Meta is available
meta checkout <truffle-branch>
meta checkout <ganache-branch>

# Run some tests
npm run test:zeppelin
npm run test:aragon
npm run test:colony
```






