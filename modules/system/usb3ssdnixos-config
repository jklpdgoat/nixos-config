# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  #imports =
  #  [ # Include the results of the hardware scan.
  #    ./hardware-configuration.nix
  #  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "usb3ssdnixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland= false;
  #services.xserver.desktopManager.gnome.enable = true;
  services = {
    xserver = {
      enable = true;
      displayManager = {
        #gdm.enable = true;
        #defaultSession = "gnome";
      };
      #displayManager.startx.enable = true;
      displayManager.gdm.wayland = true;
      #desktopManager.gnome.enable = true;
      #windowManager.bspwm.enable = true;
      videoDrivers = [ "amdgpu" ];
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvp";
  };
  
  #console.useXkbConfig = true;
  console = {
    font = "ter-powerline-v20b";
    packages = [
      pkgs.terminus_font
      pkgs.powerline-fonts
    ];
    keyMap = "dvorak-programmer";
  };
  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jklp = {
    isNormalUser = true;
    description = "Jar Pads";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    shell = pkgs.zsh;
    #packages = with pkgs; [
    #  #firefox brave thunderbird
    #];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];
  environment.shells = with pkgs; [ zsh ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?
  
  # basically identical config for enabling experimental features
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    package = pkgs.nixUnstable;
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "jklp" ];
    settings.trusted-users = [ "root" "jklp" ];
    #settings.trusted-public-keys = [
    #  "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    #];
    #settings.substituters = [
    #  "https://cache.iog.io"
    #];
    gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
      #allow-import-from-derivation = true
    '';
  };

  # Fonts
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      roboto
      fira-code
      hack-font
      (nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono"]; })
    ];
    fontconfig = {
      hinting.autohint = true;
    };
  };
  
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # to make gtk apps happy
  #  extraPackages = with pkgs; [
  #    swaylock
  #    swayidle
  #    wl-clipboard
  #    wf-recorder
  #    mako  # notification daemon
  #    #wofi
  #    waybar
  #  ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
  
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixos-cfg/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos-cfg/";
    XDG_DATA_HOME = "$HOME/.local/share";
    EDITOR = "hx";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    
    GTK_USE_PORTAL = "1";
    
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway"; 
  };
  
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      #gtkUsePortal = true;
    };
  };
  
  # Binary Cache for Haskell.nix
  #nix.settings.trusted-public-keys = [
  #  "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  #];
  #nix.settings.substituters = [
  #  "https://cache.iog.io"
  #];
  
  virtualisation.docker.enable = true;

}