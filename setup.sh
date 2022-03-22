[ -d "./packages" ] || mkdir packages

cd packages
repo init -u git@github.com:DelphinusLab/delphinus.git -b main
repo sync
cd -

npm install
npx lerna bootstrap --hoist --nohoist=circomlib
