# 🔛⛓️🧸 On Chain Bears 🔛⛓️🧸

## About

On Chain Bears is a passion project inspired by the concept of on-chain NFTs, NFTs with no dependence on the outside world or external services such as IPFS. Rendered directly from the blockchain and destined to remain there forever. In the true spirit of decentralisation; CC0, 100% on-chain and 0% royalties.

## Directory

`/art-parser/`
Used for parsing artworks that were created using pixilart.com, this parser _should_ work if you just drop and drag your workspace file into it. Remember to set `PYTHONHASHSEED` env var to an arbitrary value.

`/script/`
Deployment script used to deploy the project onto the Ethereum network.

`/src/`
Source code for smart contracts.

`/test/`
Unit tests, sorry in advance for lack of coverage uwu.

`/traits/`
Separated trait files that were used in Foundry unit tests, these are also parsed in the deployment script to provide peace of mind when populating the trait data on-chain.
