{ stdenv, fetchgit }:

let
  rev = "8ca1a742dd104b8b59b8cbdc7dfc6a5c5c0374bd";
in

stdenv.mkDerivation {
  name = "snap";

  src = fetchgit {
    url = https://github.com/cmakesnap/snap.git;
    inherit rev;
    #sha256 = "cdbe4ca6d4b639fcd66a3d1cf9c2816b4755655c9d81bdd2417263f413aa7096";
  };

  buildInputs =  [stdenv];
  
  installPhase = ''
    cp -r . $out   
  '';  
}
