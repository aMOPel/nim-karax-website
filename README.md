## Installation

```sh
npm install
cd nim
nimble install -l 
```

## Run
```sh
cd nim

# (re)compile transpileMarkdown.nim
nim c --outDir:bin --verbosity:0 --listfullpaths ./transpileMarkdown.nim

# start http server 
# needs separate shell
./bin/build && ../nimbledeps/bin/karun -r -w ./website.nim        

# start tailwind watcher
# needs separate shell
npx tailwindcss -i ./assets/prestyles.css -o ./assets/styles.css --watch

# recompilation should work automatically because both build tools use the watch flag (-w/--watch)
# but if it doesn't work:
# recompile website manually
./bin/build && nim js --out:./app.js ./src/website.nim                  
```
