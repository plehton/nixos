{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "streambox"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # hardware.pulseaudio.enable = true;
  hardware.alsa = {
    enable = true;
    config = ''
      defaults.pcm.!card 1
    '';
  };

  users.users.pjl = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ]; # Enable ‘sudo’ for the user.
  };

  nix.settings.trusted-users = [ "root" "pjl" ];

  environment.systemPackages = with pkgs; [
    alsa-lib
    brutefir
    curl
    git
    htop
    librespot
    lsof
    ranger
    tmux
    usbutils
    vim
    wget
  ];

  networking.firewall.enable = false;
  #networking.firewall.allowedTCPPorts = [ 3232 3223 ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    extraConfig = ''
      ClientAliveCountMax 0
      ClientAliveInterval 600
    '';
  };

#  systemd.services.librespot = {
#    after = [
#      "network-online.target"
#      "sound.target"
#    ];
#    description = "librespot";
#    wants = [
#      "network-online.target"
#    ];
#    serviceConfig = {
#      ExecStart = "${pkgs.librespot}/bin/librespot --name 'Hegel' --device-type avr --backend alsa --bitrate 160 --format S24_3 --enable-volume-normalisation --initial-volume 80 --zeroconf-port 3232";
#      Restart = "always";
#      RestartSec = "10";
#      SupplementaryGroups = "audio";
#    };
#    wantedBy = [
#      "multi-user.target"
#    ];
#  };


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

