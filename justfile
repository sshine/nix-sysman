
# List available commands
list:
  @just --list --unsorted

# Initialize repository
init:
  nix run 'github:numtide/system-manager' -- init

# Switch system configuration (first time)
switch-init:
  nix --extra-experimental-features 'nix-command flakes' \
    run 'github:numtide/system-manager' -- switch --sudo --flake .

# Switch system configuration
switch:
  sudo system-manager switch --flake .
