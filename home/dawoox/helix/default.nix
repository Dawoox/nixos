{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    helix

    clang-tools # Needed LSP for C/C++
    dockerfile-language-server-nodejs # Dockerfile LSP
    markdown-oxide # Markdown LSP
    nil # Nix LSP
    yaml-language-server # YAML LSP
    python312Packages.python-lsp-server # Python LSP
    ruff
    python312Packages.python-lsp-ruff
    python312Packages.python-lsp-black
    lua-language-server
  ];
}