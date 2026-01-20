# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11 # Using Wayland tho?
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;

  # SDDM
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      # extraPackages = [sddm-astronaut];
      enable = true;
      wayland.enable = true;
      # theme = "sddm-astronaut-theme";
    };
  };

  # Firmware for framework
  services.fwupd.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # ==== Nix OS Settings ====

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ==== Keyboard ====

  hardware.keyboard.qmk.enable = true;


  # ==== Fonts ====

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  # ==== User Account ====

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.john = {
    isNormalUser = true;
    description = "john";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
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
     nh
     wget
     nil
     nixd
     direnv

     # desktop environment
     wl-clipboard
     brightnessctl
     swayidle

     # essentials
     openssl
     pkg-config
     libgit2

     # fish
     fish-lsp

     # utilities
     inotify-tools
     usbutils
     unzip
     zip
     qpdf
     timer
     alsa-utils
     wl-clipboard-rs
     dig

     # python
     python315
     
     # web dev tools
     nodejs_24
     pnpm
     typescript-language-server
     vscode-langservers-extracted
     superhtml
     tailwindcss_4
     zola # rust static site generator

     # rust dev tools
     rustup
     clang
     libgccjit
     llvmPackages.bintools
     cargo-watch
     clippy
     cargo-generate
     lldb
     trunk         # js build tool
     leptosfmt     # web frontend framework
     cargo-shuttle # shuttle rs cli

     # keyboard firmware
     qmk

     # applications
     obsidian
     discord
     zoom
     zoom-us
     anki

     # LLM
     claude-code
  ];

  environment.variables = {
    HYPRSHOT_DIR = "$HOME/Screenshots";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
