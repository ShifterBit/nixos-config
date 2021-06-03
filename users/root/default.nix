{ lib, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;
in
{
  users.users.root.hashedPassword = fileContents ../../secrets/root;
}
