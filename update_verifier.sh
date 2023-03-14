    cp packages/zkp/circom/verifier.sol packages/solidity/contracts/ZKPVerifier.sol
    sed -i "s/\^0.6.11/^0.8.0/" packages/solidity/contracts/ZKPVerifier.sol

    # Copy the migration file in migration folder
    cp packages/solidity/tools/verifier_migration.js packages/solidity/migrations/4_verifier_migration.js

    # # Dont have to migrate the tokens again
    cd packages/solidity
    npx truffle migrate --f 4 --to 4 --network goerli
    npx truffle migrate --f 4 --to 4 --network bsctestnet
    npx truffle migrate --f 4 --to 4 --network cronostestnet
    npx truffle migrate --f 4 --to 4 --network rolluxtestnet
    cd -

    # Delete the migration file in migration folder
    rm packages/solidity/migrations/4_verifier_migration.js

    echo "new verifier has been updated"