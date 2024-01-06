{ configs, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
      alias lock="~/scripts/lock_custom.sh"
      alias epidock="sudo docker run -it --rm -v $(pwd):/home/project -w /home/project epitechcontent/epitest-docker:latest /bin/bash"
      alias waybar-reload="~/waybar_reload.sh"
    '';
    enableAutosuggestions = true;
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          hash = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
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