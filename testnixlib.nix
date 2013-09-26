{ stdenv, cmake, snap }:

stdenv.mkDerivation {
  name = "testnixlib";
  
  
  # exclude local git repo from source set
  src = builtins.filterSource
    (path: type: type != "directory" || baseNameOf path != ".git")
    ./base64/..;  # TODO: how to refer to current directory directly?  The parent of a subdir is CWD but this is such a hack!
  
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
