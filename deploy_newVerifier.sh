    cp packages/zkp/circom/verifier.sol packages/solidity/contracts/ZKPVerifier.sol
    sed -i "s/\^0.6.11/^0.8.0/" packages/solidity/contracts/ZKPVerifier.sol

    cd packages/solidity
    npx truffle migrate --f 4 --to 4 --network goerli
    npx truffle migrate --f 4 --to 4 --network bsctestnet
    npx truffle migrate --f 4 --to 4 --network cronostestnet
    npx truffle migrate --f 4 --to 4 --network rolluxtestnet
    cd -

    cd packages/solidity/clients/
    node config-contracts-info.js
    cd -