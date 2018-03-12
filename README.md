# wild-truffle

[![Greenkeeper badge](https://badges.greenkeeper.io/trufflesuite/wild-truffle.svg?token=c539e4a31a2ca18a876785bdb92d86507bccc420f3364fbacdcdbdbd759ca66e&ts=1520890061714)](https://greenkeeper.io/)

`wild-truffle` lets you run unpublished Truffle changes against a selection of existing commercial Truffle projects:
+ [zeppelin-solidity](https://github.com/OpenZeppelin/zeppelin-solidity/tree/7586e383c2e9d62b2f1d414e850ab365afef6d89) (at commit 7586e38, early March 2018)
+ [aragonOS] (at commit )
+ [colonyNetwork] (at commit)

Goal is to extend Truffle's scenario testing regime to include an ~800 unit battery that reflects real usage of the toolset. Its structure is very similar to the root `truffle` repository.

# Install

```
npm install
```

# Use

Test an experimental Truffle branch (this can span across modules) against the projects listed above on Travis CI and see what breaks :)

```shell

git checkout -b <throw-away-branch-name>  # checkout a throw-away branch.

npm run ci <experimental-branch>          # Run the truffle branch in CI (defaults to `develop`).
```






