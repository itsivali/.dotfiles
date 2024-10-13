{ pkgs ? import <nixpkgs> { 
    config = {
      allowUnfree = true; 
    }; 
  }
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    vim
    google-chrome
    spotify
    notepad-next
    ffmpeg
    vlc
  ];
}
