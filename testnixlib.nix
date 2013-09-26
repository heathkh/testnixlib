{ stdenv, cmake, snap }:

stdenv.mkDerivation {
  name = "testnixlib";
  
  
  # exclude local git repo from source set
  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path != ".git")
    ../testnixlib;
  
  buildInputs =  [stdenv cmake]; 
  cmakesnap_DIR = snap.out;
  
  # SNAP projects require more than one config phase  
  # Also, the standard CMAKE_INSTALL_PREFIX is broken somehow (it get's reset to tmp build dir instead of out dir)
  # Uses my own variable in the SNAP macros to work around this issue.  
  postConfigure = ''    
    echo "SNAP configure phase 2";
    cmake -DSNAP_INSTALL_PREFIX=$out ..;       
  '';  
  
}
