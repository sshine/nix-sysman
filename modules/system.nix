{ inputs, config, ... }:
{
  systems = [ "x86_64-linux" ];

  flake.systemConfigs.default = inputs.system-manager.lib.makeSystemConfig {
    modules = [
      config.flake.nixosModules.packages
      (
        {
          lib,
          pkgs,
          system-manager,
          ...
        }:
        {
          config = {
            nixpkgs.hostPlatform = "x86_64-linux";
            nixpkgs.config.allowUnfree = true;

            nix.settings = {
              build-users-group = "nixbld";
              trusted-users = [
                "root"
                "sshine"
              ];
              extra-substituters = [ "https://cache.numtide.com" ];
              extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
              experimental-features = [
                "nix-command"
                "flakes"
              ];
              accept-flake-config = true;
              warn-dirty = false;
            };

            # Enable and configure services
            services = {
              # nginx.enable = true;
              userborn.enable = true;
            };

            users.users.sshine = {
              isNormalUser = true;
              extraGroups = [ "wheel" ];
            };

            environment = {
              # Add directories and files to `/etc` and set their permissions
              etc = {
                "sudoers.d/wheel-nopasswd" = {
                  text = "%wheel ALL=(ALL:ALL) NOPASSWD: ALL\n";
                  mode = "0440";
                  user = "root";
                  group = "root";
                };
              };
            };

            # Enable and configure systemd services
            systemd.services = { };

            # Configure systemd tmpfile settings
            systemd.tmpfiles = {
              # rules = [
              #   "D /var/tmp/system-manager 0755 root root -"
              # ];
              #
              # settings.sample = {
              #   "/var/tmp/sample".d = {
              #     mode = "0755";
              #   };
              # };
            };
          };
        }
      )
    ];
  };
}
