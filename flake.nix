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
            
            node = pkgs.nodejs_20;
            gatsby = pkgs.nodePackages_latest.gatsby-cli;
            pnpm = pkgs.pnpm;
            yarn = pkgs.yarn-berry

            starship = pkgs.starship;
        in {
            devShells = {
                
                default = pkgs.mkShell {
                    # Packages included in the environment
                    buildInputs = [ starship node gatsby pnpm yarn ];
                    
                    # Run when the shell is started up
                    shellHook = ''
                    # Set the prompt to starship
                    eval "$(starship init bash)"

                    # create a starship.toml file in the current directory if it doesn't exist
                    if [ ! -f "starship.toml" ]; then
                        echo "🚀 Starship config does not exist. Creating it..."
                        touch starship.toml
                    else
                        echo "🚀 Starship config already exists."
                    fi

                    # set the STARSHIP_CONFIG environment variable to the starship.toml file in the current directory
                    export STARSHIP_CONFIG=$(pwd)/starship.toml

                    # set the preset to pastel-powerline on the config file
                    starship preset pastel-powerline -o starship.toml
                    echo "Loading 🚀 Starship config."
                    '';                    
                };
            };
        }
    );
}


