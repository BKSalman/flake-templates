{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {nixpkgs,  rust-overlay, ...}:
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; overlays = [ rust-overlay.overlays.default ]; };
      in
    with pkgs; {
      devShells.${system}.default = mkShell {
          packages = [
            xorg.xmodmap
            gdb
          ];
          
          nativeBuildInputs = [
          ];
          
          buildInputs = [
           (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" "rust-analyzer" ];
            })
            # auto reload server on save
            # cargo watch -x run
            cargo-watch
            pkg-config
            xorg.libX11
            xorg.libXft
            xorg.libXrandr
            xorg.libXinerama
          ];

          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [ pkgs.xorg.libX11 pkgs.xorg.libXcursor pkgs.xorg.libXrandr pkgs.xorg.libXi pkgs.xorg.libXft pkgs.fontconfig pkgs.freetype ]}";
        };

      formatter.x86_64-linux = legacyPackages.${system}.nixpkgs-fmt;
    };
}


