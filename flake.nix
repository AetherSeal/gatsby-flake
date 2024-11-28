{
  description = "A Nix-flake-based Node | Gatsby development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        zsh = pkgs.zsh;
        node = pkgs.nodejs_latest;
        gatsby = pkgs.nodePackages_latest.gatsby-cli;
        pnpm = pkgs.pnpm;
        ohMyZsh = pkgs.oh-my-zsh;
        powerlevel10k = pkgs.zsh-powerlevel10k;

      in {
        devShells = {
          
          default = pkgs.mkShell {
            # Packages included in the environment
            buildInputs = [ zsh node gatsby pnpm ohMyZsh powerlevel10k];

            # Run when the shell is started up
            shellHook = ''
              echo "=> Resume ---------------------------------------------"
              echo "zsh => `${zsh}/bin/zsh --version`"
              echo "node => `${node}/bin/node --version`"
              echo "gatsby-cli => `${gatsby}/bin/gatsby --version`"
              echo "pnpm => `${pnpm}/bin/pnpm --version`"
              echo "-------------------------------------------------------"
              export SHELL=$(which zsh)
              
              echo "Welcome to the development environment that uses Zsh and avoids the config prompt!";

              # Create a .zshrc file to avoid interactive configuration
              if [ ! -f ~/.zshrc ]; then
                echo "Creating .zshrc file..."
                cat > ~/.zshrc <<EOF
                # Zsh configurations
                export ZSH=\$HOME/.oh-my-zsh
                export ZSH_THEME="powerlevel10k/powerlevel10k"
                plugins=(git)
                source \$ZSH/oh-my-zsh.sh
                EOF
              fi
              # Ensure we're using Zsh
              if [ -z "$ZSH_VERSION" ]; then
                echo "Not using Zsh. Switching to Zsh..."
                exec zsh
              fi

              # Set up Oh My Zsh
              export ZSH="$HOME/.oh-my-zsh"
              source $ZSH/oh-my-zsh.sh

              # Load Powerlevel10k theme
              source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
              
              # Config git
              git config --global user.name "Alejandro Castro"
              git config --global user.email "alejandro.castro.q@gmail.com"

              echo "Done!"

            '';

          };
        };
      }
    );
}


