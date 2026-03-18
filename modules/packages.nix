{ inputs, ... }:
{
  flake.nixosModules.packages =
    {
      lib,
      pkgs,
      system-manager,
      ...
    }:
    let
      walltime-rs = inputs.walltime-rs.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      config = {
        environment.systemPackages = [
          system-manager
          pkgs.just
          pkgs.dig
          pkgs.tree
          pkgs.proton-pass-cli
          walltime-rs.default
        ];
      };
    };
}
