[ -d "./packages" ] || mkdir packages

cd packages
repo init -u git@github.com:ZhenXunGe/delphinus.git -b main
repo sync
cd -

npm install
npx lerna bootstrap
