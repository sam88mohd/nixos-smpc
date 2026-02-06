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
    inputs.dms-plugin-registry.modules.default
  ];

  home.username = "sm";
  home.homeDirectory = lib.mkDefault "/home/sm";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    clinfo
    vulkan-tools
    alacritty
    nwg-look
    adw-gtk3
    glib
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

  # enable DMS
  programs.dms-shell = {

    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
  };
}
