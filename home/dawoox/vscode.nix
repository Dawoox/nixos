{ config, pkgs, unstable, ... }:
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
  direnv = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "direnv";
      publisher = "mkhl";
      version = "0.16.0";
      sha256 = "sha256-u2AFjvhm3zio1ygW9yD9ZwbywLrEssd0O7/0AtfCvMo=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    package = unstable.vscode;
    mutableExtensionsDir = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        palenight-theme
        material-icons
        nix-plugins
        nix-ide
        direnv
      ];
      userSettings = {
        # Themes
        "workbench.iconTheme" = "a-file-icon-vscode";
        "workbench.colorTheme" = "Palenight (Mild Contrast)";
        "editor.fontSize" = 14;

        # File settings
        "files.autoSave" = "onFocusChange";

        # Git / Github
        "git.autofetch" = true;

        "window.titleBarStyle" = "custom";

        # Disable auto check updates
        "update.mode" = "none";

        # Use system platformio
        #"platformio-ide.useBuiltinPIOCore" = "false";

        # Open as read-only files marked as such by the filesystem
        "files.readonlyFromPermissions" = "true";
      };
    };
  };
}
