with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "node";
    buildInputs = [
        nodejs
    ];
    shellHook = ''
        export PATH="$PWD/node_modules/.bin/:$PATH"
        npm set prefix $PWD/.npm-global
        npm install -g @angular/cli
        npm install -g @nestjs/cli
    '';
}
