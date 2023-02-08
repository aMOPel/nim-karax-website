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
nim c --outDir:bin --verbosity:0 --listfullpaths ./transpileMarkdown.nim && ./bin/transpileMarkdown -w

# start http server 
# needs separate shell
./nimbledeps/bin/karun -r -w ./src/website.nim        

# start tailwind watcher
# needs separate shell
npx tailwindcss -i ./assets/prestyles.css -o ./assets/styles.css --watch

# recompilation should work automatically because all build tools use the watch flag (-w/--watch)
# but if it doesn't work:
# recompile website manually
./bin/transpileMarkdown && nim js --out:./app.js ./src/website.nim                  
```

Or convenient shell alias using `zsh` shell and `kitty` terminal:

```sh
website () {
  p=~/Documents/website
  pn=$p/nim
  # opens windows for the 3 watchers
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "nim c --outDir:bin --verbosity:0 --listfullpaths ./transpileMarkdown.nim && ./bin/transpileMarkdown -w"
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "./nimbledeps/bin/karun -r -w ./src/website.nim"
  kitty @ launch --type=window --cwd=$pn --keep-focus zsh -c "npx tailwindcss -i ./assets/prestyles.css -o ./assets/styles.css --watch"
  # launches neovim session in a new tab afterwards
  kitty @ launch --type=tab --cwd=$p zsh -c "nvim -S Session.vim"
}
```
