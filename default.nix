# This file defines a function that takes a single optional argument 'pkgs'
# If pkgs is not set, it defaults to importing the nixpkgs found in NIX_PATH
{ pkgs ? import <nixpkgs> {} }:
let
   # Convenience alias for the standard environment
   stdenv = pkgs.stdenv;
in rec {  
  
  snap = pkgs.callPackage ./git_snap.nix { };
  
  testnixlib = pkgs.callPackage ./testnixlib.nix { inherit snap; };
  
    
}