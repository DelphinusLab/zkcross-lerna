cd packages
repo init -u git@github.com:ZhenXunGe/delphinus.git
repo sync
cd -

npm install
npx lerna bootstrap
