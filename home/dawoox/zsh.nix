{ configs, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
      alias lock="~/scripts/lock_custom.sh"
      alias epidock="sudo docker run -it --rm -v $(pwd):/home/project -w /home/project epitechcontent/epitest-docker:latest /bin/bash"
      alias waybar-reload="~/waybar_reload.sh"
    '';
    enableAutosuggestions = true;
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
