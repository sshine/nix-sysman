{ inputs, ... }:
{
  flake.nixosModules.packages =
    { lib, pkgs, system-manager, ... }:
    {
      config = {
        environment.systemPackages = let
	  system = pkgs.stdenv.hostPlatform.system;
	in [
          pkgs.claude-code
          inputs.claudebox.packages.${system}.default
        ];
      };
    };
}
