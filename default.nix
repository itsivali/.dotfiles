# default.nix
{ pkgs ? import <nixpkgs> { 
    config = {
      allowUnfree = true;
    }; 
  }
}:

#pkgs.mkShell {
 # buildInputs = [
  #  pkgs.vim                  # Example free software
   # pkgs.google-chrome         # Example nonfree software
    #pkgs.spotify               # Another example of nonfree software
    #pkgs.wget                  # Another free software example
   # pkgs.ffmpeg                # Free software
  #];
#}
