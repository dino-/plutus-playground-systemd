#! /bin/bash

# Set this to where you have the `plutus` project cloned
plutusPlaygroundDir="$HOME/dev/iog/plutus"

basename=$(basename "$0")
usage=$(cat <<USAGE
Start Plutus Playground server or client

usage:
  $basename server
  $basename client
  $basename -h
  $basename --help

v1.0  2021-04-16  Dino Morelli <dino@ui3.info>

USAGE
)

startServer () {
  service="$1"
  cmd="$2"

  . $HOME/.nix-profile/etc/profile.d/nix.sh
  cd "$plutusPlaygroundDir"
  nix-shell --run "cd plutus-playground-${service} && ${cmd} 2>&1"
}

case "$1" in
  server) startServer server "plutus-playground-server";;
  client) startServer client "npm run start";;
  *) echo "$usage"; exit 0;;
esac
