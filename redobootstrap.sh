#This sh will clean node modules and redo the lerna bootstrap
rm -rf node_modules
rm -rf packages/*/node_modules
rm -f packages/*/package-lock.json
rm -f package-lock.json
npx lerna bootstrap --hoist --nohoist=circomlib
