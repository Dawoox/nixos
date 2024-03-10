{ config, pkgs, ... }:
let
  palenight-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "material-palenight-theme";
      publisher = "whizkydee";
      version = "2.0.3";
      sha256 = "sha256-qz2pz9JlnO2OV3eJnRqzbcic1lzpl0ViygwhNjZOWpI=";
    };
  };
  material-icons = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "a-file-icon-vscode";
      publisher = "atommaterial";
      version = "1.2.0";
      sha256 = "sha256-PgvhqqMvIvBej96mnoNMgtniuKHzlu+XB1rbSLqPF7E=";
    };
  };
  nix-plugins = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nix-extension-pack";
      publisher = "pinage404";
      version = "3.0.0";
      sha256 = "sha256-cWXd6AlyxBroZF+cXZzzWZbYPDuOqwCZIK67cEP5sNk=";
    };
  };
  nix-ide = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nix-ide";
      publisher = "jnoortheen";
      version = "0.2.2";
      sha256 = "sha256-jwOM+6LnHyCkvhOTVSTUZvgx77jAg6hFCCpBqY8AxIg=";
    };
  };
  nix-env-selector = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nix-env-selector";
      publisher = "arrterian";
      version = "1.0.10";
      sha256 = "sha256-b3Sr0bwU2VJgl2qcdsUROZ3jnK+YUuzJMySvSD7goj8=";
    };
  };
  direnv = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "direnv";
      publisher = "mkhl";
      version = "0.16.0";
      sha256 = "sha256-u2AFjvhm3zio1ygW9yD9ZwbywLrEssd0O7/0AtfCvMo=";
    };
  };
  copilot = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "copilot";
      publisher = "github";
      version = "1.152.0";
      sha256 = "sha256-+bwEJQI6wrouEfaqmkIG4Ao01a069cY95satwA7TsVs=";
    };
  };
  copilot-chat = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "copilot-chat";
      publisher = "github";
      version = "0.10.2";
      sha256 = "sha256-NfVg0Mor6agPrPYuzsNiWgX5DAcSysWaP3GilyXv/S4=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      #copilot
      #copilot-chat
      palenight-theme
      material-icons
      nix-plugins
      nix-ide
      nix-env-selector
      direnv
    ];
    userSettings = {
      # Themes
      "workbench.iconTheme" = "a-file-icon-vscode";
      "workbench.colorTheme" = "Palenight (Mild Contrast)";

      # File settings
      "files.autoSave" = "onFocusChange";

      # Git / Github
      "git.autofetch" = true;

      "window.titleBarStyle" = "custom";
    };
  };
}
