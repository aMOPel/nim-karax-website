#!/usr/bin/env sh

# execute this script in project root only
root=$(pwd)
build=$root/build
dist=$root/dist
nim=$root/nim
tools=$nim/tools
bin=$nim/bin
assets=$root/assets
devtools=$root/devtools
# src=$nim/src
# nimContent=$src/website/content
# content=$root/content

mkdir -p $build
mkdir -p $dist

# abort on errors
set -e

# build js, html and place assets
cd $nim
nim c --outDir:bin --verbosity:0 --listfullpaths $tools/build.nim && \
  $bin/build -r
cd -

# build css
cd $devtools
npx tailwindcss -i $devtools/prestyles.css -o $build/styles.css
cd -

# minify build
npx postcss --config $devtools $build/styles.css > $dist/styles.css
npx html-minifier \
--case-sensitive                     \
--collapse-boolean-attributes        \
--collapse-inline-tag-whitespace     \
--collapse-whitespace                \
--decode-entities                    \
--minify-css true                    \
--minify-js true                     \
--minify-urls true                   \
--process-conditional-comments       \
--remove-attribute-quotes            \
--remove-comments                    \
--remove-empty-attributes            \
--remove-optional-tags               \
--remove-redundant-attributes        \
--remove-script-type-attributes      \
--remove-style-link-type-attributes  \
--remove-tag-whitespace              \
--trim-custom-fragments              \
--use-short-doctype                  \
-o $dist/index.html $build/index.html
# --compress doesn't work
npx uglifyjs --mangle -o $dist/app.js $build/app.js
npx imagemin $build/assets/ --out-dir $dist/assets/

# navigate into the build output directory
cd $dist

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
