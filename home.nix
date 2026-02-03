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

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

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
<<<<<<< HEAD
    # papirus-icon-theme
=======
    papirus-icon-theme
    materia-theme
>>>>>>> e8dc492 (add materia-theme package)
    python3
    loupe
    mpv
    btop
    zathura
    nautilus
    libreoffice-fresh
    tldr
  ];

  home.file = {
    ".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink /home/sm/.config/home-manager/niri/default-config.kdl;
  };

  home.sessionVariables = {
    EDITOR = "vim";
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
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
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

  # configure GTK
  gtk = {
    enable = true;
    iconTheme = {
      name = "materia theme";
      package = pkgs.materia-theme;
    };
  };
}
