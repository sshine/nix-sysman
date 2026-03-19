{ self, inputs, ... }:
{
  perSystem =
    {
      config,
      system,
      pkgs,
      lib,
      ...
    }:
    let
      lefthook-check = inputs.lefthook-nix.lib.${system}.run {
        src = self;
        config = {
          pre-commit.commands.treefmt = {
            run = "treefmt --fail-on-change --no-cache {staged_files}";
          };
          pre-push.commands.strip-co-authored-by = {
            run = ".github/hooks/pre-push.sh";
          };
        };
      };
    in
    {
      checks.lefthook-check = lefthook-check;
      devShells.default = pkgs.mkShell {
        inherit (lefthook-check) shellHook;
        packages = [ config.treefmt.build.wrapper ];
        LEFTHOOK_BIN = toString (
          pkgs.writeShellScript "lefthook-dumb-term" ''
            exec env TERM=dumb ${lib.getExe pkgs.lefthook} "$@"
          ''
        );
      };
    };
}
