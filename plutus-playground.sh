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

v1.2  2021-04-27  Dino Morelli <dino@ui3.info>

USAGE
)


die () {
  rc="$1"
  shift
  echo "$basename:" "$@" >&2
  exit "$rc"
}

startServer () {
  service="$1"
  cmd="$2"

  systemNixProfilePath="/etc/profile.d/nix.sh"
  userNixProfilePath="$HOME/.nix-profile${systemNixProfilePath}"

  # shellcheck disable=SC1090
  if [ -f "$systemNixProfilePath" ]; then . "$systemNixProfilePath"
  elif [ -f "$userNixProfilePath" ]; then . "$userNixProfilePath"
  else die 1 "Can't continue because Nix environment script not found at either $systemNixProfilePath or $userNixProfilePath. Is Nix installed?"
  fi

  cd "$plutusPlaygroundDir" || die 1 "Can't continue, unable to cd into $plutusPlaygroundDir"
  nix-shell --run "cd plutus-playground-${service} && ${cmd} 2>&1"
}

case "$1" in
  server) startServer server "plutus-playground-server";;
  client) startServer client "npm run start";;
  *) echo "$usage"; exit 0;;
esac
