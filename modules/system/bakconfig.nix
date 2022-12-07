# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{

  #imports =
    #[ # Include the results of the hardware scan.
      #./hardware-configuration.nix
    #];

  # Bootloader.
  boot.cleanTmpDir = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.timeout = 0;

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
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland= false;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvp";
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "video"];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    helix
    
    acpi tlp git
  ];

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
  
  #environment.defaultPackages = [ ];
  
  # Wayland stuff: enable XDG integration, allow sway to use brillo
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };
  
  # basically identical config for enabling experimental features
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "jklp" ];
    gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
    '';
  };
  
  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
      bluetooth.enable = false;
      opengl = {
          enable = true;
          driSupport = true;
      };
  };
  
  fonts = {
    fonts = with pkgs; [
        jetbrains-mono
        roboto
        #$openmoji-color
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
  
}