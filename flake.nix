{
  description = "Julia environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # julia = pkgs.julia.withPackages [
        #   "LanguageServer"
        #   "Aqua"
        #   "Colors"
        #   "Coverage"
        #   "CSV"
        #   "DataFrames"
        #   "Dates"
        #   #"Distributions" # broken on default nixos
        #   "Documenter"
        #   "JuliaFormatter"
        #   #"Plots" # broken on default nixos, requires binary dependencies
        #   #"PyPlot" # broken on default nixos, requires binary dependencies
        #   "Random"
        #   "Suppressor"
        #   "Test"
        #   "BenchmarkTools"
        # ];
        julia = pkgs.julia-bin.overrideDerivation (oldAttrs: { doInstallCheck = false; });
      in
      {
        # development environment
        devShells.default = pkgs.mkShell {
          packages = [
            julia
          ];

          shellHook = ''
            export JULIA_NUM_THREADS="auto"
            export JULIA_PROJECT="turing"
          '';
        };
      }
    );
}