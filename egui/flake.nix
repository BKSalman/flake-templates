{
  description = "basic egui applications development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  }:
      let
        system = "x86_64-linux";

        pkgs = import nixpkgs { inherit system; overlays = [ rust-overlay.overlays.default ]; };

        libPath =  with pkgs; lib.makeLibraryPath [
          libxkbcommon
          vulkan-loader
          libGL
          fontconfig
          freetype
          xorg.libX11
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXi
          wayland
        ];

        nativeBuildInputs = with pkgs; [
          pkg-config
          cmake
          mesa
        ];

        buildInputs = with pkgs; [
          fontconfig
          freetype

          vulkan-loader
          libGL

          libxkbcommon
          # WINIT_UNIX_BACKEND=wayland
          wayland

          # WINIT_UNIX_BACKEND=x11
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXi
          xorg.libX11
        ];
      in with pkgs; {
        devShells.${system}.default = mkShell {
          inherit buildInputs nativeBuildInputs;

          packages = with pkgs; [
            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" "rust-analyzer" ];
            })
            cargo-watch
          ];

          LD_LIBRARY_PATH = "${libPath}";
        };
      };
}

