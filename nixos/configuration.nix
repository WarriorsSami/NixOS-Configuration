# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi = {
      # canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      configurationLimit = 4;
      efiInstallAsRemovable = true;
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };

  # Virtualisation
  virtualisation.docker.enable = true;

  # Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Envvars
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Hypr
#  programs.hyprland = {
#    enable = true;
#    enableNvidiaPatches = true;
#    xwayland.enable = true;
#  };
#
#  environment.sessionVariables = {
#    WLR_NO_HARDWARE_CURSORS = "1";
#    NIXOS_OZONE_WL = "1";
#  };
#
#  hardware = {
#    opengl.enable = true;
#    nvidia.modesetting.enable = true;
#  }; 
#
#  # XDG portal
#  xdg.portal.enable = true;
#  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#
#  # Enable sound with pipewire.
#  sound.enable = true;
#  hardware.pulseaudio.enable = false;
#  security.rtkit.enable = true;
#  services.pipewire = {
#    enable = true;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
#    jack.enable = true;
#  };

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
  users.users.sami = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "sami";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
	firefox      
    ];
  };

  # users.defaultShell = pkgs.zsh;

  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Zsh
#  programs.zsh = {
#   oh-my-zsh = {
#      enable = true;
#      enableAutosuggestions = true;
#      syntaxHighlighting.enable = true;
#      plugins = [ "git" "thefuck" ];
#      theme = "robbyrussell";
#    };
#  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      vim
      wget
      neovim
      neofetch
      lf
      gcc
      gnat
      git
      cargo
      rustup
      go
      dotnet-sdk_7
      dotnet-runtime_7
      flutter
      dapr-cli
      docker
      postman
      vscode
      jetbrains.rider
      jetbrains.goland
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.rust-rover
      jetbrains.datagrip
      jetbrains-toolbox
      spotify
      discord
      opera
      brave
      firefox
      thunderbird
      gparted
      unityhub
      haskellPackages.postgresql-libpq_0_10_0_0
      alacritty
      zsh
      fish
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc
      obsidian
      gnome.gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.downfall
      gnomeExtensions.pano
      gnomeExtensions.compiz-alike-magic-lamp-effect
      gnomeExtensions.compiz-windows-effect
      gnomeExtensions.dash-to-dock
      gnomeExtensions.dashbar
      gnomeExtensions.hide-top-bar
      gnomeExtensions.blur-my-shell
      gnomeExtensions.appindicator
      gnomeExtensions.vitals
      gnomeExtensions.unblank
      jetbrains.jdk
#      waybar
#      dunst
#      swww
#      kitty
#      wofi
#      (waybar.overrideAttrs (oldAttrs: {
#          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
#        })
#      )
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
  system.stateVersion = "23.05"; # Did you read the comment?

}
