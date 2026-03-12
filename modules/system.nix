{ inputs, ... }:
{
  systems = [ "x86_64-linux" ];

  flake.systemConfigs.default = inputs.system-manager.lib.makeSystemConfig {
    modules = [
      (
        { lib, pkgs, system-manager, ... }:
        {
          config = {
            nixpkgs.hostPlatform = "x86_64-linux";

            nix.settings = {
              build-users-group = "nixbld";
              trusted-users = [ "root" "sshine" ];
            };

            # Enable and configure services
            services = {
              # nginx.enable = true;
            };

            environment = {
              # Packages that should be installed on a system
              systemPackages = [
                pkgs.just
                system-manager
              ];

              # Add directories and files to `/etc` and set their permissions
              etc = {
                # with_ownership = {
                #   text = ''
                #     This is just a test!
                #   '';
                #   mode = "0755";
                #   uid = 5;
                #   gid = 6;
                # };
                #
                # with_ownership2 = {
                #   text = ''
                #     This is just a test!
                #   '';
                #   mode = "0755";
                #   user = "nobody";
                #   group = "users";
                # };
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
