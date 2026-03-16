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
      llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      config = {
        environment.systemPackages = [
          llm-agents.claude-code
          llm-agents.claudebox
          llm-agents.rtk
        ];
      };
    };
}
