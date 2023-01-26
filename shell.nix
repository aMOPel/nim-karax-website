{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    nim
    nimlsp
    nodejs
  ];

  # Aliases work from project root in the ./nim folder
  shellHook = ''
    alias karax-start="./bin/transpileMarkdown && \
./nimbledeps/bin/karun -r -w ./src/website.nim"

    alias tailwind-start="npx tailwindcss -i ./assets/prestyles.css \
-o ./assets/styles.css --watch"

    alias karax-recompile="cd $PROJECT_ROOT; ./bin/transpileMarkdown && \
nim js --out:./app.js ./src/website.nim"

    alias nim-compile="nim c --outDir:bin --verbosity:0 --listfullpaths \
./transpileMarkdown.nim"
  '';
}
