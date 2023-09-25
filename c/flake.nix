{

  description = "basic C development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShells.${system}.default = pkgs.mkShell.override {
      stdenv = pkgs.gcc13Stdenv;
    } {
      packages = with pkgs; [
        clang-tools_15
      ];

      buildInputs = with pkgs; [ ];

      shellHook = ''
        alias clang="clang -Wall -Wextra -Wpedantic -std=c99";
      '';
    };
  };
}
