#!/usr/bin/env sh

# abort on errors
set -e

# build
cd nim
nim c --outDir:bin --verbosity:0 --listfullpaths ./transpileMarkdown.nim && ./bin/transpileMarkdown
./nimbledeps/bin/karun ./src/website.nim
npx tailwindcss -i ./prestyles.css -o ./assets/styles.css
cd -

mkdir -p dist/assets
cp nim/assets/* dist/
cp nim/app.html dist/index.html
cp nim/app.js dist/app.js

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io
git push -f https://github.com/aMOPel/aMOPel.github.io.git master:main

# if you are deploying to https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<aMOPel>/<quoteapp>.git main:gh-pages

cd -
