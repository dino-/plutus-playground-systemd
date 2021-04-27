# plutus-playground-systemd


## Synopsis

systemd service units to manage the Plutus Playground server and client


## Description

This project was made to assist Plutus contract developers with running the
local Plutus Playground server and client. It's useful for Linux distributions
that use systemd like Ubuntu, most Debians, Arch Linux, etc. We also have
reports this works with WSL2 and Ubuntu if systemd is set up.


## Installation

Copy the script to your home

    mkdir -p $HOME/.local/bin
    cp plutus-playground.sh $HOME/.local/bin

Edit the `plutusPlaygroundDir` variable near the top of the script to the path
where you cloned `plutus`, it looks something like this

    plutusPlaygroundDir="$HOME/dir/where/you/put/plutus"

Copy the unit files

    mkdir -p $HOME/.config/systemd/user
    cp plutus-playground{,-server}.service $HOME/.config/systemd/user

Reload the systemd daemon

    systemctl --user daemon-reload


## Usage

Before starting the first time you will need to have performed the `plutus`
set-up and gotten past the `nix-build -f ...` point.

For more info on getting to this point, please see
[Plutus Community Documentation - Ubuntu setup](https://docs.plutus-community.com/docs/setup/Ubuntu.html)

Starting the service is simple

    systemctl --user start plutus-playground

This start-up may take some time, especially the first time and after doing a
`nix-build`, even though the systemd status says it's started. You can use the
journal to keep an eye on it.

    journalctl --user -u plutus-playground -f

When you see a line like this in the journal, it's operational:

    Apr 26 10:20:34 ubuntu1 plutus-playground.sh[9553]: i [wdm]: Compiled successfully.

You should now be able to access the playground at <https://localhost:8009>

Stopping the playground will automatically stop the `plutus-playground-server`
service

    systemctl --user stop plutus-playground

If you'd like to view the output of the `plutus-playground-server` service
(which is different than the client):

    journalctl --user -u plutus-playground-server -f

### Updating your `plutus` repository

When upstraem changes need to be pulled into your Plutus Playground, follow
this procedure:

    systemctl --user stop plutus-playground
    cd plutus  # if you're not in the dir already
    git pull
    git checkout <commit hash required for plutus-pioneer-program>  # May not be required
    nix build -f default.nix plutus.haskell.packages.plutus-core
    systemctl --user start plutus-playground

## Contact

Dino Morelli <[dino@ui3.info](mailto:dino@ui3.info)>
