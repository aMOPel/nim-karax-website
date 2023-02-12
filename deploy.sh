#!/usr/bin/env sh

# abort on errors
set -e

# build
cd nim
nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/build.nim && ./bin/build
cd -

cd tailwind
npx tailwindcss -i ./prestyles.css -o ../dist/styles.css
cd -

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
