{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "sm";
  home.homeDirectory = lib.mkDefault "/home/sm";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    clinfo
    vulkan-tools
    python3
    libreoffice-fresh
    tldr
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "samsudinMohamad";
      user.email = "sam88mohd@gmail.com";
      init.defaultBranch = "main";
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "noctalia";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt;
      }
    ];
  };

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
