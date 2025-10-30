{
  config,
  pkgs,
  lib,
  nixgl,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "doeringc";
  home.homeDirectory = "/home/doeringc";

  # allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  # nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = ["mesa"];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Development tools
    git
    vim
    neovim
    tmux
    htop
    tree
    ripgrep
    fd
    fzf
    jq
    curl
    wget

    # Utilities
    unzip
    zip
    gzip
    which
    file
    less

    # System monitoring
    btop
    ncdu
    duf

    # Terminal utilities
    bat
    eza
    starship
    direnv
    (config.lib.nixGL.wrapOffload kitty)

    # Network tools
    net-tools
    inetutils
    nmap
    traceroute
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

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  #
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  #
  # programs.fzf = {
  #   enable = true;
  #   enableBashIntegration = true;
  # };
  #
  # programs.bat = {
  #   enable = true;
  #   config = {
  #     theme = "TwoDark";
  #     number = true;
  #   };
  # };
  #
  # programs.eza = {
  #   enable = true;
  #   enableBashIntegration = true;
  # };
  #
  # # Ubuntu-specific: fontconfig for better font rendering
  # fonts.fontconfig.enable = true;
}
