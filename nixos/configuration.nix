{ config, pkgs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 15;

  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
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

  services.xserver.enable = true; # needed for XWayland
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      enable = true;
      wayland.enable = true;
    };
  };

  services.fwupd.enable = true;
  services.ollama.enable = true;
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ==== Nix OS Settings ====

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "john"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # ==== Keyboard ====

  hardware.keyboard.qmk.enable = true;

  # ==== Fonts ====

  fonts.fontconfig.enable = true;

  # ==== User Account ====

  users.users.john = {
    isNormalUser = true;
    description = "john";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [ ];
    shell = pkgs.fish;
  };

  # ==== Packages ====

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  environment.systemPackages = with pkgs; [
    # nix
    nh                # nix helper CLI

    # desktop environment
    wl-clipboard      # Wayland clipboard
    brightnessctl     # brightness control

    # essentials
    wget              # file downloader
    openssl           # crypto library
    pkg-config        # build config
    libgit2           # git C library
    clang             # C compiler
    libgccjit         # JIT compiler lib
    llvmPackages.bintools # LLVM linker

    # utilities
    inotify-tools     # file watcher
    usbutils          # USB info
    unzip             # extract archives
    zip               # create archives
    qpdf              # PDF tool
    timer             # countdown timer
    alsa-utils        # audio tools
    dig               # DNS lookup

    # keyboard firmware
    qmk               # QMK firmware
  ];

  environment.variables = {
    HYPRSHOT_DIR = "$HOME/Screenshots";
  };

  system.stateVersion = "25.05";
}
