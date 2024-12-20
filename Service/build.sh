cd ./web
pnpm i
pnpm build
rm -rf ../dist 
mv -f dist/ ../
cd ../
make build
rm -rf dist