{ config, pkgs, lib, builtins, inputs, username, terminal, font, ... }:
let
  background = ../../images/nix-blue.png;
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/hyprlock
    ../../modules/home-manager/hypridle
    ../../modules/home-manager/waybar
    ../../modules/home-manager/foot
    ../../modules/home-manager/helix
    ../../modules/home-manager/sh
  ];

  colorScheme = inputs.nix-colors.colorSchemes.ayu-mirage;
  home.username = username;
  home.homeDirectory = "/home/${username}";
  programs.hyprlock.enable = true;
  
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 26;
  };

  fonts.fontconfig.enable = true;
  nixpkgs.config = { 
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "discord"
    ];
  };

  hyprland.colorScheme = config.colorScheme;
  hyprland.terminal = terminal;
  hyprlock.background = background;
  hypridle.timeout = 60;
  
  foot.font = font;
  foot.fontSize = 10;
  home.packages = with pkgs; [
    curl
    neovim
    neofetch
    discord
    brave
    ranger
    lazygit
    nil
    ripgrep

   (nerdfonts.override {
      fonts = [
        "FiraCode"
        "SpaceMono"
        "Iosevka"
        "Monoid"
        "Hack"
      ];
    })
  ];
  
  programs.git = {
    enable = true;
    userName = "Sebastian Callh";
    userEmail = "sebastian.callh@gmail.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.firefox = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Standard-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "standard";
        tweaks = [ "black" ];
        variant = "macchiato";
      };
    };
  };
  
  home.file = {
    ".config/colors.css".text = ''
      @define-color base #${config.colorScheme.palette.base00};
      @define-color mantle #${config.colorScheme.palette.base01};
      @define-color surface0 #${config.colorScheme.palette.base02};
      @define-color surface1 #${config.colorScheme.palette.base03};
      @define-color surface2 #${config.colorScheme.palette.base04};
      @define-color text #${config.colorScheme.palette.base05};
      @define-color rosewater #${config.colorScheme.palette.base06};
      @define-color lavender #${config.colorScheme.palette.base07};
      @define-color red #${config.colorScheme.palette.base08};
      @define-color peach #${config.colorScheme.palette.base09};
      @define-color yellow #${config.colorScheme.palette.base0A};
      @define-color green #${config.colorScheme.palette.base0B};
      @define-color teal #${config.colorScheme.palette.base0C};
      @define-color blue #${config.colorScheme.palette.base0D};
      @define-color mauve #${config.colorScheme.palette.base0E};
      @define-color flamingo #${config.colorScheme.palette.base0F};
    '';
 };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
