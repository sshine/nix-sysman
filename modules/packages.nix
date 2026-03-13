{ inputs, ... }:
{
  flake.nixosModules.packages =
    { lib, pkgs, system-manager, ... }:
    {
      config = {
        environment.systemPackages = [
          pkgs.just
          pkgs.tree
          pkgs.lastpass-cli
          system-manager
        ];
      };
    };
}
