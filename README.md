# plutus-playground-systemd


## Synopsis

systemd service units to manage the Plutus Playground server and client


## Description

This project was made to assist Plutus contract developers with running the
local Plutus Playground server and client. It's useful for Linux distributions
that use systemd like Ubuntu, most Debians, Arch Linux, etc.


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


## Use

Before starting these the first time you will need to have performed the
`plutus` set-up and gotten past this point (in the `plutus` directory):

    nix build -f default.nix plutus.haskell.packages.plutus-core

For more info on getting to this point, please see
[Plutus Community Documentation - Ubuntu setup](https://docs.plutus-community.com/docs/setup/Ubuntu.html)

Starting the playground

    systemctl --user start plutus-playground

Stopping the playground (this will also stop the plutus-playground-server)

    systemctl --user stop plutus-playground

View logs

    journalctl --user -u plutus-playground-server -f
    journalctl --user -u plutus-playground -f


## Contact

Dino Morelli <[dino@ui3.info](mailto:dino@ui3.info)>
