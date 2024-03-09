{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = with pkgs; [
    gcc
    gdb
    gcovr
    gnumake
    valgrind
    criterion
  ];
}
