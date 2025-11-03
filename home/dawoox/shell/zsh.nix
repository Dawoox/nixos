{ configs, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      NH_FLAKE = "/home/dawoox/config";
    };
    initContent = ''
      eval "$(direnv hook zsh)"
      path+=$HOME/scripts/public
    '';
    shellAliases = {
      "epidock" = "sudo docker run -it --rm -v $(pwd):/home/project -w /home/project epitechcontent/epitest-docker:latest /bin/bash";
      "obsidian" = "obsidian --disable-gpu";
      "lz" = "lazygit";
      "cs" = "nix run github:sigmapitech/cs";
      "ssh" = "kitty +kitten ssh";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      # Need to be disable currently because its too
      # cpu intensive, so it add 0.4s to zsh load
      #{
      #  name = "zsh-autocomplete";
      #  src = pkgs.fetchFromGitHub {
      #   owner = "marlonrichert";
      #   repo = "zsh-autocomplete";
      #   rev = "eee8bbeb717e44dc6337a799ae60eda02d371b73";
      #   hash = "sha256-2qkB8I3GXeg+mH8l12N6dnKtdnaxTeLf5lUHWxA2rNg=";
      # };
      #}
    ];
  };
}
