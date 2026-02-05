{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.noctalia.homeModules.default
  ];

  home.username = "sm";
  home.homeDirectory = lib.mkDefault "/home/sm";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    clinfo
    vulkan-tools
    alacritty
    nwg-look
    adw-gtk3
    bibata-cursors
    gnome-themes-extra
    adwaita-icon-theme
    papirus-icon-theme
    qogir-icon-theme
    python3
    loupe
    steam
    mpv
    btop
    zathura
    thunar
    libreoffice-fresh
    tldr
  ];

  home.file = {
    ".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink /home/sm/.config/home-manager/niri/default-config.kdl;
  };

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

  # niri config
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # enable noctalia systemd service
  programs.noctalia-shell.systemd.enable = true;

  # configure noctalia shell
  programs.noctalia-shell = {
    enable = true;
  };
}
