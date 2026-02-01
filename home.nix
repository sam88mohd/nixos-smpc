{ inputs, config, pkgs, lib, ... }:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in
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
     python3
     nautilus
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
 
   # Let Home Manager install and manage itself.
   programs.home-manager.enable = true;
 
   # niri config
   programs.niri = {
     enable = true;
     package = pkgs.niri-unstable;
     settings = {
       binds = with config.lib.niri.actions; {
        "Mod+space".action.spawn = noctalia "launcher toggle";
       };
     };
   };
 
   # enable noctaslia systemd service
   programs.noctalia-shell.systemd.enable = true;
 
   # configure noctalia shell
   programs.noctalia-shell = {
     enable = true;
   };
 }
