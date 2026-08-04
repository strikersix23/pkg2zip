{
  description = "A Nix-flake-based C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default =
            pkgs.mkShell.override
              {
                stdenv = pkgs.gccStdenv;
              }
              {
                packages = with pkgs; [
                  python3
                  gcc
                  clang-tools
                  gdb
                  typos
                  pkg-config
                ];

              };
        }
      );

      packages = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "pkg2zip";
            version = "0.1";

            src = ./.;

            # nativeBuildInputs = [ pkgs.makeWrapper ]; # If you need wrappers
            buildInputs = [ ]; # Add dependencies like pkgs.openssl if needed

            buildPhase = ''
              printenv
              make
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp ./pkg2zip $out/bin/
            '';

            meta = {
              description = "Decrypts PlayStation Vita pkg file and packages to zip archive";
              license = pkgs.lib.licenses.unlicense;
              platforms = pkgs.lib.platforms.linux;
            };
          };
        }
      );
    };
}
