cd packages/deployment
npx jest --verbose
cd -

cd packages/monitors
npx jest --verbose
cd -

cd packages/solidity
npx jest --verbose
cd -

cd packages/web3subscriber
npx jest --verbose
cd -

cd packages/zkp
npx jest --verbose
cd -