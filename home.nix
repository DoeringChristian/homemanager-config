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
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = ["mesa" "nvidia" "nvidiaPrime"];

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
    (config.lib.nixGL.wrap kitty)
    (config.lib.nixGL.wrap tev)

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

  # XDG configuration files
  xdg.configFile = {
    "fish/completions" = {
      source = ./.config/fish/completions;
      recursive = true;
    };
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Add custom paths
  home.sessionPath = [
    "$HOME/.pixi/bin"
  ];
  home.shell = {
    enableFishIntegration = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      direnv = {
        disabled = false;
      };
    };
  };
  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  programs.eza = {
    enable = true;
    git = true;
  };
  programs.bat = {
    enable = true;
  };
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };
  programs.claude-code = {
    enable = true;
  };
  programs.atuin = {
    enable = true;
    settings = {
      keymap_mode = "vim-insert";
    };
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = ''
      set -gx fish_key_bindings fish_user_key_bindings
    '';
    interactiveShellInit = ''
      set -gx fish_key_bindings fish_user_key_bindings
    '';
    functions = {
      fish_user_key_bindings = {
        body = ''
          fish_vi_key_bindings

          # Emulates vim's cursor shape behavior
          # Set the normal and visual mode cursors to a block
          set fish_cursor_default block
          # Set the insert mode cursor to a line
          set fish_cursor_insert line
          # Set the replace mode cursor to an underscore
          set fish_cursor_replace_one underscore
          # The following variable can be used to configure cursor shape in
          # visual mode, but due to fish_cursor_default, is redundant here
          set fish_cursor_visual block

          # Set timeout
          set -g fish_sequence_key_delay_ms 200

          # Mapping for jk to escape
          bind --mode insert --sets-mode default jk cancel repaint-mode
          # Mapping for jj to j
          bind -M insert jj 'commandline -i j'

          #Mapping for clipboard in vim mode
          bind yy fish_clipboard_copy
          bind Y fish_clipboard_copy
          bind p fish_clipboard_paste

          # Accept auto suggestions with `l`
          bind -M default l accept-autosuggestion
        '';
      };
      tb.body = "tensorboard $argv --samples_per_plugin images=1000000";
      "...".body = "../..";
      "....".body = "../../..";
    };
    shellAliases = {
      l = "eza -l -g --icons";
      ll = "l -a";
      la = "ll";
      jn = "jupyter notebook";
      jt = "jupytext --update --to notebook";
      je = "jupyter execute";
      cookie = "cookiecutter my --directory";
      jpg2webm = "ffmpeg -r 30 -i %d.jpg output.webmm";
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
  #
  programs.fzf = {
    enable = true;
  };
  programs.gh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      core = {
        editor = "nvim";
      };
      user = {
        name = "Christian Döring";
        email = "christian.doering@tum.de";
      };
      credential = {
        helper = "store";
      };
      alias = {
        lg = "log --decorate --graph --abbrev-commit";
        adog = "log --all --decorate --oneline --graph --abbrev-commit";
        adogs = "log --all --decorate --oneline --graph --abbrev-commit --stat";
        dog = "log --decorate --oneline --graph --abbrev-commit";
        dogs = "log --decorate --oneline --graph --abbrev-commit --stat";
      };
      pull = {
        ff = "only";
      };
      merge = {
        ff = "only";
      };
    };
  };
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
