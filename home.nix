{ inputs, config, pkgs, lib, ... }:

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
    alacritty
    nwg-look 
    adw-gtk3
    gnome-themes-extra
    adwaita-icon-theme
    papirus-icon-theme
    python3
    loupe
    mpv
    btop
    zathura
    nautilus
    libreoffice-fresh
  ];

  home.file = {
    ".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink /home/sm/.config/home-manager/niri/default-config.kdl;
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
