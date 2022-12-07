{ config, pkgs, ... }:

{
  #imports = [
    #./configs/alacritty.nix
  #];
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jklp";
  home.homeDirectory = "/home/jklp";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # User config append section
  home.packages = with pkgs; [ ];
  
  programs.git = {
    enable = true;
    userName = "jklpdgoat";
    userEmail = "jarpadul@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = {
      core.editor = "hx";
      credential.helper = "cache"; 
    };
  };
    
}
