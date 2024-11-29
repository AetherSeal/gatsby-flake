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
        
        node = pkgs.nodejs_latest;
        gatsby = pkgs.nodePackages_latest.gatsby-cli;
        pnpm = pkgs.pnpm;
        
        in {
            devShells = {
                
                default = pkgs.mkShell {
                    # Packages included in the environment
                    buildInputs = [ node gatsby pnpm ];
                    
                    # Run when the shell is started up
                    shellHook = ''
                    echo "=> Resume ---------------------------------------------"
                    echo "node => `${node}/bin/node --version`"
                    echo "gatsby-cli => `${gatsby}/bin/gatsby --version`"
                    echo "pnpm => `${pnpm}/bin/pnpm --version`"
                    echo "-------------------------------------------------------"
                    '';                    
                };
            };
        }
    );
}


