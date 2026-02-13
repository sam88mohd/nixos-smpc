{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/main-user.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Binary cache
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable GPU hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-media-driver
    ];
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable user
  main-user.enable = true;
  main-user.userName = "sm";

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      sm = import ./home.nix;
    };
  };

  # auto upgrade
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;

  networking.hostName = "smpc"; # Define your hostname.

  # install fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable power-profile
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Enable GVfs (for smb:// support)
  services.gvfs.enable = true;

  # Enable GNOME Keyring (to store the secrets)
  services.gnome.gnome-keyring.enable = true;

  # Ensure the Secret Service (D-Bus) is available
  services.dbus.packages = [ pkgs.seahorse ]; # Optional: includes key manager

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # sysc-greet configuration
  services.sysc-greet = {
    enable = true;
    compositor = "niri"; # or "hyprland" or "sway"
  };

  # Optional: Set initial session for auto-login
  # services.sysc-greet.settings.initial_session = {
  #   command = "niri-session";
  #   user = "sm";
  # };

  # If using greetd:
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  pipewire.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnumake
    tree
    dconf
    brightnessctl
    xwayland-satellite-unstable
  ];

  services.tumbler.enable = true; # For thumbnails

  # thunar config
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Enable xfconf to save preferences
  programs.xfconf.enable = true;

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
