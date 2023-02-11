## Installation

```sh
npm install
cd nim
nimble install -l 
```

## Run
```sh
cd nim

# recompile and start markdown watcher
# needs separate shell
nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/transpileMarkdown.nim && ./bin/transpileMarkdown -w

# start build watcher
# needs separate shell
nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/build.nim && ./bin/build -w

# start asset watcher
# needs separate shell
nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/putAssets.nim && ./bin/putAssets -w

# start http server hosting at localhost:8080
# needs separate shell
./nimbledeps/bin/nimhttpd -p:8080 ../dist

cd ../tailwind
# start tailwind watcher
# needs separate shell
npx tailwindcss -i ./prestyles.css -o ../dist/styles.css --watch

```

Or convenient shell alias using `zsh` shell and `kitty` terminal:

```sh
website () {
  p=~/Documents/website
  pn=$p/nim
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/transpileMarkdown.nim && ./bin/transpileMarkdown -w"
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/build.nim && ./bin/build -w"
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "nim c --outDir:bin --verbosity:0 --listfullpaths ./tools/putAssets.nim && ./bin/putAssets -w"
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "./nimbledeps/bin/nimhttpd -p:8080 ../dist"
  kitty @ launch --type=window --cwd=$p/tailwind --keep-focus zsh -c "npx tailwindcss -i ./prestyles.css -o ../dist/styles.css --watch"
  kitty @ launch --type=tab --cwd=$p zsh -c "nvim -S Session.vim"
}
```
