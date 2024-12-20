cd ./web
pnpm i
pnpm build 
cp dist ../
rm -rf dist
cd ../
make build