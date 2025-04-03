# If import path points to a directory, the file default.nix in that directory is used instead.

{
  system = ./system;
  users = {
    squeakbug = ./home;
    root = {...}: {};
  };
}