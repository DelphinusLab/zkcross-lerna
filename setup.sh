[ -d "./packages" ] || mkdir packages

cd packages
repo init -u git@github.com:ZhenXunGe/delphinus.git -b dev
repo sync
cd -

npm install
npx lerna bootstrap
