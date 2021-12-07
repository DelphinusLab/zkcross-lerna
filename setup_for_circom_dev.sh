#!/bin/bash
LERNA_PATH=`dirname "${BASH_SOURCE}"`

# under lerna
git restore package-lock.json
git checkout sign
bash setup.sh

# under packages/zkp 
cd ${LERNA_PATH}/packages/zkp
git restore package-lock.json
# git branch -avv
git checkout ZhenXunGe/feature/circom_mtree

# under packages/zkp/circom
cd ${LERNA_PATH}/packages/zkp/circom
bash tools/setup.sh
bash tools/compile.sh

# under packages/zkp
cd ${LERNA_PATH}/packages/zkp
npx lerna bootstrap
node dist/tests/circom.test.js