{
  description = "local development setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        overallPkgs = with pkgs;[
          go
          # vhs # wait for 0.2.0 to be released
          cowsay
        ];
        shellHook = '''';
      in
      rec{
        packages = {
          default = packages.local;
          local = pkgs.buildEnv {
            name = "dev-tools";
            paths = with pkgs; overallPkgs ++ [
              earthly
            ];
          };
          ci = pkgs.buildEnv {
            name = "dev-tools";
            paths = with pkgs; overallPkgs ++ [
              cowsay
              # hack to share shellHook with container
              (pkgs.writeScriptBin "setup-shell" shellHook)
            ];
          };
        };
        devShell = pkgs.mkShell {
          inherit shellHook;
          packages = [ packages.local ];
        };
      }
    );
}
