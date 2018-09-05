# wild-truffle
[![Build Status](https://travis-ci.org/trufflesuite/wild-truffle.svg?branch=develop)](https://travis-ci.org/trufflesuite/wild-truffle)

`wild-truffle` runs unpublished Truffle changes against existing commercial Truffle projects. At
the moment it validates Truffle V5 and has a single target. Targets are cloned per test and their
invocation of truffle in `package.json` is aliased to the `bundled.cli.js` of the installed branch.
+ [colonyNetwork](https://github.com/JoinColony/colonyNetwork)

## Use (on [Travis](https://travis-ci.org/trufflesuite/wild-truffle/branches))

Test an experimental Truffle branch against the projects listed above on Travis CI and see what breaks.

```shell
git clone  https://github.com/trufflesuite/wild-truffle.git # no need to `npm install`
git checkout -b <throw-away-branch-name>                    # checkout a throw-away branch.

# Run truffle at branch 'next' in CI (default)
npm run ci

# Or run against specific branches
npm run ci -- -t <truffle-branch>
```

## Use locally

Install `wild-truffle` locally to debug a target's test failures against a branch.

```shell
npm install -g yarn

# Install truffle and targets at next
npm run install:local

# Or install at a specific truffle branch
npm run install:local -- -t <truffle-branch>

# Run colonyNetwork tests
npm run test:colony
```







