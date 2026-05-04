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
      system = pkgs.stdenv.hostPlatform.system;
      llm-pkgs = inputs.llm-agents.packages.${system};
      bubble-pkgs = inputs.bubblebox.packages.${system};
    in
    {
      config = {
        environment.systemPackages = [
          llm-pkgs.claude-code
          llm-pkgs.rtk
          bubble-pkgs.claudebox
        ];
      };
    };
}
