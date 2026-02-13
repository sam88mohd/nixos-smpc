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
    nwg-look
    adw-gtk3
    glib
    cava
    bibata-cursors
    gnome-themes-extra
    adwaita-icon-theme
    papirus-icon-theme
    qogir-icon-theme
    unzip
    zip
    python3
    loupe
    mpv
    btop
    zathura
    libreoffice-fresh
    tldr
    alacritty
    steam
    gnome-text-editor
  ];

  home.file = {
    ".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink /home/sm/nixos-smpc/modules/nixos/niri/default-config.kdl;
  };

  # git config
  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "samsudinMohamad";
      user.email = "sam88mohd@gmail.com";
      init.defaultBranch = "main";
    };
  };

  # helix config
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

  # vim config
  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
    };
  };

  # niri config
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # noctalia shell config
  programs.noctalia-shell = {
    enable = true;
    systemd = {
      enable = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
