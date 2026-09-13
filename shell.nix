let
  # Pin to a specific nixpkgs commit for true reproducibility (optional but recommended)
  # pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  packages = [
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.prettier
    pkgs.jq
  ];
  shellHook = ''
    set -euo pipefail

    mkdir -p ./collections

    if [ ! -f "./collections.yml" ]; then
      echo "Installing Ansible collections into ./collections ..."
      ansible-galaxy collection install -r ./collections.yml -p ./collections
    fi
  '';
}
