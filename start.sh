set -e

cd packages/solidity/tools
[ -d testnet1.backup ] || bash create_testnet.sh
cd -

#cd packages/zkp
#[ -f out ] || zokrates compile -i zok/business/main.zok
#[ -f proving.key ] || zokrates setup
#[ -f verifier.sol ] || zokrates export-verifier
#cd -

cd packages/zkp/circom
[ -f pot20_final.ptau ] || bash tools/setup.sh
[ -d main_js ] || bash tools/compile.sh
cd -

#cd packages/monitors
#bash run.sh
#cd -

[ -d data ] || mkdir data
mongod --dbpath=data 1> db.log 2> db.err &

pwd=$(pwd)
echo "please start two eth chain, substrate, wallet."
echo ""
echo "cd ${pwd}/packages/solidity/tools && bash runtestnet1.sh testnet1.backup/ .password 1"
echo ""
echo "cd ${pwd}/packages/solidity/tools && bash runtestnet2.sh testnet2.backup/ .password 1"
echo ""
echo "cd ${pwd}/packages/substrate-node && bash start.sh"
echo ""
echo "cd ${pwd}/packages/wallet && npm run start"
echo ""

read

if [ ! -f init.lock ];
then
    #cp packages/zkp/verifier.sol packages/solidity/contracts/ZKPVerifier.sol
    cp packages/zkp/circom/verifier.sol packages/solidity/contracts/ZKPVerifier.sol
    sed -i "s/\^0.6.11/^0.8.0/" packages/solidity/contracts/ZKPVerifier.sol

    cd packages/solidity
    npx truffle migrate --network testnet1
    npx truffle migrate --network testnet2
    cd -

    cd packages/solidity/clients/tools/bridge
    node init.js localtestnet1
    node init.js localtestnet2
    cd -

    cd packages/monitors/src/tools
    node init-substrate.js
    cd -

    cd packages/solidity/clients/tools/token
    node mint.js localtestnet1
    node mint.js localtestnet2
    node mint-rio.js localtestnet1
    cd -

    touch init.lock
fi

echo "please start monitors"
