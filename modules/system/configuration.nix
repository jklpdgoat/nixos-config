# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet" "splash" "rd.systemd.show_status=false"
    "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail"
    "i915.force_probe=46a8"
  ];
  
  boot.loader.systemd-boot.enable = true;
  #boot.loader.timeout = 0;
  boot.loader.systemd-boot.consoleMode = "0";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixhp15s"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.thermald.enable = true;
  # services.tlp.enable = true;

  # services.xserver = {
  #   enable = true;

  #   displayManager = {
  #     gdm.enable = true;
  #   };

  #   desktopManager = {
  #     # xterm.enable = true;
  #     # gnome.enable = true;
  #     xfce = {
  #       enable = true;
  #       # noDesktop = true;
  #       # enableXfwm = false;
  #     };
  #   };
  # };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # programs.hyprland.enable = true;
  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  }; 

  environment.sessionVariables = {
    # If cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # For Electron apps (terrible btw)
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    # opengl already enabled
    # Most wayland compositors need this
    # nvidia.modsetting.enable = true;
  };
  

  # environment.gnome.excludePackages = (with pkgs; [
  #   gnome-photos
  #   gnome-tour
  # ]) ++ (with pkgs.gnome; [
  #   cheese # webcam tool
  #   gnome-music
  #   gnome-terminal
  #   # gedit # text editor
  #   epiphany # web browser
  #   geary # email reader
  #   evince # document viewer
  #   gnome-characters
  #   totem # video player
  #   tali # poker game
  #   iagno # go game
  #   hitori # sudoku game
  #   atomix # puzzle game
  # ]);

  environment.systemPackages = [
    # For waybar icons
    pkgs.font-awesome
    # For general unix stuff
    pkgs.gnomeExtensions.appindicator
    pkgs.man-pages
    pkgs.man-pages-posix

    # For hyprland stuff
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    pkgs.kitty
    pkgs.dunst
    pkgs.rofi-wayland
    pkgs.swww

    pkgs.swayidle
    pkgs.swaylock

    # pkgs.brillo
    pkgs.brightnessctl

    pkgs.networkmanagerapplet

    pkgs.auto-cpufreq
  ];

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      # energy_performance_preference = "performance";
      turbo = "never";
    };
  };

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];

  # environment.systemPackages = with pkgs.libsForQt5; [
  #   bluedevil
  # ];

  # environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  #   elisa
  #   gwenview
  #   okular
  #   oxygen
  #   khelpcenter
  #   konsole
  #   plasma-browser-integration
  #   print-manager
  # ];

  # environment.systemPackages = [ pkgs.arc-theme ];
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #         [org.gnome.desktop.interface]
  #         gtk-theme='Arc-Dark'
  # '';


  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "dvorak";
    };
  };

  # Console config
  console = {
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18b.psf.gz";
    # keyMap = "us";
    useXkbConfig = true;
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = ''
      font-name=MesloLGS NF
      font-size=13
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # trace: warning: The option `services.xserver.libinput.enable' defined in `/nix/store/3ladnq91hj9b8q70w4943va7rdiqw2dr-source/modules/system/configuration.nix' has been renamed to `services.libinput.enable'.
  # services.xserver.libinput.enable = true;
  services.libinput.enable = true;
  #services.xserver.libinput.touchpad.middleEmulation = true;
  #services.xserver.libinput.touchpad.tapping = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jklp = {
    isNormalUser = true;
    description = "Jar Padul";
    extraGroups = [ "journalctl" "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      brave
      droidcam
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [ ];
  environment.shells = with pkgs; [ zsh ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;

  # Can't enable in HM, try adding in System level
  programs.dconf.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  nix = {
    # package = pkgs.nixUnstable;
    package = pkgs.nixVersions.latest;
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "jklp" ];
    settings.trusted-users = [ "root" "jklp" ];
    settings.trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    settings.substituters = [
      "https://cache.iog.io"
    ];
    gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
      max-jobs = auto
      #allow-import-from-derivation = true
    '';
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      fira-code
      hack-font
      meslo-lgs-nf
      (nerdfonts.override { fonts = [ "FiraCode" "Hack" "JetBrainsMono" "DroidSansMono"]; })
    ];
    fontconfig = {
      enable = true;
      hinting.autohint = true;
    };
  };

  virtualisation.docker.enable = true;

  # Logind?
  # services.logind.extraConfig = ''
  #   # KillUserProcesses=no
  #   HandlePowerKey=hibernate
  #   HandlePowerKeyLongPress=poweroff
  #   # HandleRebootKey=reboot
  #   # HandleRebootKeyLongPress=poweroff
  #   HandleSuspendKey=suspend
  #   # HandleSuspendKeyLongPress=hibernate
  #   # HandleHibernateKey=hibernate
  #   # HandleHibernateKeyLongPress=ignore
  #   HandleLidSwitch=suspend
  #   # HandleLidSwitchExternalPower=suspend
  #   # HandleLidSwitchDocked=ignore
  # '';
  services.logind = {
    powerKey = "hibernate";
  };

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "jklp" ];

  # user systemd services
  #systemd.user.services.foot-server@wayland-0.service = {
  #  description = "Execute foot server as a service";
  #  serviceConfig.PassEnvironment = "DISPLAY";
  #  script = ''
  #    echo "Test foot server as a service"
  #  ''
  #  wantedBy = [ "multi-user.target" ];
  #}
  
  # XDG Format
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      #gtkUsePortal = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
