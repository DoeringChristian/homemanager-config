{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "doeringc";
  home.homeDirectory = "/home/doeringc";

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

    # Build tools
    gcc
    gnumake
    cmake
    pkg-config

    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv

    # Node.js
    nodejs
    nodePackages.npm

    # Utilities
    unzip
    zip
    gzip
    tar
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
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable and configure programs
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # Custom aliases
      alias ll='ls -la'
      alias la='ls -A'
      alias l='ls -CF'
      alias ..='cd ..'
      alias ...='cd ../..'

      # Git aliases
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit'
      alias gp='git push'
      alias gl='git log --oneline --graph'

      # Safety aliases
      alias rm='rm -i'
      alias cp='cp -i'
      alias mv='mv -i'
    '';
  };

  programs.git = {
    enable = true;
    userName = "Your Name"; # Replace with your name
    userEmail = "your.email@example.com"; # Replace with your email
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      number = true;
    };
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
  };

  # Ubuntu-specific: fontconfig for better font rendering
  fonts.fontconfig.enable = true;
}

