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

  # enable noctaslia systemd service
  programs.noctalia-shell.systemd.enable = true;

  # configure noctalia shell
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/sm/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Lunas, MY";
      };
    };
  };
}
