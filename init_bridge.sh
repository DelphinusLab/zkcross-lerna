set -e

if [ ! -f initbridge.lock ];
then
    cp packages/zkp/circom/verifier.sol packages/solidity/contracts/ZKPVerifier.sol
    sed -i "s/\^0.6.11/^0.8.0/" packages/solidity/contracts/ZKPVerifier.sol

    # Dont have to migrate the tokens again
    cd packages/solidity
    npx truffle migrate --f 1 --to 1 --network ropsten
    npx truffle migrate --f 1 --to 1 --network bsctestnet
    cd -

    cd packages/solidity/clients/tools/bridge
    node init.js ropsten
    node init.js bsctestnet
    cd -

    touch initbridge.lock
fi

echo "please start monitors"
