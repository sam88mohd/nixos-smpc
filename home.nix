{ inputs, config, pkgs, ... }:

{
  home.username = "sm";
  home.homeDirectory = "/home/sm";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    kitty    
  ];

  home.file = {
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
  imports = [ inputs.niri.homeModules.niri ];

  nixpkgs.overlay = [ inputs.niri.overlays.niri ];
  programs.niri.packages = pkgs.niri-unstable;

  programs.niri.enable = true;
  programs.niri.settings = {
    binds = {
      "Mod+Return".action.spawn = "kitty";
      "Mod+q".action.close-window = [];
    };
  };
}
