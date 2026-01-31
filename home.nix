{ inputs, config, pkgs, lib, ... }:

{
  imports = [ inputs.niri.homeModules.niri ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  
  home.username = "sm";
  home.homeDirectory = lib.mkDefault "/home/sm";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    kitty    
    python3
  ];

  home.file = {
    ".config/niri/config.kdl".source = ./niri/default-config.kdl;
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

  # kitty config
  programs.kitty.settings.confirm_os_window_close = 0;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # niri config
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
