{ inputs, config, pkgs, lib, ... }:

 #let
  #flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  #hyprland = (import flake-compat {
   # src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
 # }).defaultNix;
#in {
  #imports = [
   # hyprland.homeManagerModules.default
 # ];

 # wayland.windowManager.hyprland = {
  #  enable = true;

   # extraConfig = ''
     # bind = SUPER, t, exec, foot 
      # ...
   # '';
 # };


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
{
  home.username = "sadiel";
  home.homeDirectory = "/home/sadiel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "RobotoMono" "SpaceMono" "CascadiaCode" "ComicShannsMono" "Go-Mono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    
    pkgs.avizo
    pkgs.brightnessctl
    pkgs.cliphist # Clippboard manager

    pkgs.direnv
    
    pkgs.foot
    pkgs.unzip

    pkgs.swww
    pkgs.wbg
    pkgs.just
    pkgs.fd
    pkgs.ripgrep
    pkgs.procs
    pkgs.helix
    pkgs.tokei
    pkgs.nushell
    pkgs.zellij

    pkgs.plasma5Packages.kdeconnect-kde   

    pkgs.taplo
    pkgs.lua-language-server
    pkgs.nodePackages_latest.typescript-language-server
    #pkgs.nodePackages_latest.svelte-language-server
    pkgs.nodePackages_latest.vscode-html-languageserver-bin
    pkgs.nodePackages_latest.vscode-langservers-extracted
    #pkgs.nodePackages_latest.vscode-json-languageserver-bin

    pkgs.zola
    pkgs.nodejs_20
    pkgs.nodePackages_latest.pnpm
];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sadiel/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "hx";
    SHELL = "nu";
    TERMINAL = "foot";
    };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.aria2.enable = true;
  programs.gpg.enable = true;
  programs.password-store.enable = true; # UNIX Password Manager
  programs.browserpass.enable = true;    # Pass Browser Integration
  programs.zathura.enable = true;


  #Neovim
  programs.neovim = {
	 enable = true;
	 viAlias = true;
	 vimAlias = true;
	 extraLuaConfig = lib.fileContents ../nvim/init.lua.backup;
	 };
  
  programs.firefox.enable = true;
 
   #Rust utilities!
    programs.atuin.enable = true;
    programs.bat.enable = true;	  # Cat replacement
    programs.broot.enable = true;   # Tree replacement
    programs.bottom.enable = true;	  # System Resources Monitor
    #programs.eww.enable = true;	  # Cool Widgets
    programs.fzf.enable = true;	  
    programs.lsd.enable = true;	  # Ls relacement
    #pkgs.skim	
    programs.starship.enable = true; # Fast & Cross Plattaform Terminal Prompt  
    programs.navi.enable = true;

    programs.zoxide.enable = true;   # Cd replacement

    #Git it
    programs.git.enable = true; 

    programs.hyfetch.enable = true; # Neofetch-like fetcher 
    
    programs.fuzzel.enable = true; # App Launcher
    #programs.waybar ={
#		      enable = true;
#		      style =  lib.fileContents ../waybar/style.css;
#		      settings = lib.fileContents ../waybar/config;
 #   };

    programs.mpv.enable = true; 
    #programs.imv.enable = true; 

    services.fnott.enable = true;
    
    services.kdeconnect = {
			    enable = true;
			    indicator = true;
    };

    gtk = {
    enable = true;
    theme = {
      name = "Catppuccin";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
           };
    };
    font = {
      name = "Roboto";
      package = pkgs.roboto;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    };

    home.pointerCursor = { 
    name = "Catpuccin";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
    };

    programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
    patches = (oa.patches or []) ++ [
      (pkgs.fetchpatch {
        name = "fix waybar hyprctl";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
        sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
      })
    ];
  });
  };

  home.file."${config.xdg.dataHome}/fonts/ProductSans".source = lib.cleanSourceWith {
    filter = name: _: (lib.hasSuffix ".ttf" (baseNameOf (toString name)));
    src = pkgs.fetchzip {
      url = "https://befonts.com/wp-content/uploads/2018/08/product-sans.zip";
      sha256 = "sha256-PF2n4d9+t1vscpCRWZ0CR3X0XBefzL9BAkLHoqWFZR4=";
      stripRoot = false;
    };
  };

  /*imports = [inputs.fufexan.homeManagerModules.eww-hyprland];

  programs.eww-hyprland = {
    enable = true;

    # default package
    package = pkgs.eww-wayland;

    # if you want to change colors
    colors = builtins.readFile ./latte.scss;

    # set to true to reload on change
    autoReload = false; 
  };*/
}
