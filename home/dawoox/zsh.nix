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
    '';
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          hash = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "eee8bbeb717e44dc6337a799ae60eda02d371b73";
          hash = "sha256-2qkB8I3GXeg+mH8l12N6dnKtdnaxTeLf5lUHWxA2rNg=";
        };
      }
    ];
  };
}