<div align="center">

# I use NixOS btw

</div>

![Screenshot 1](docs/screenshot-01.png)

## What is it, what's in it

This repository is whole NixOS configuration (tl;dr my whole laptop config), it inclues my programs, configs, custom assets, wallpapers and more. My current setup is made to do multiples things, as my main laptop is used both for my studies in CS and also as my personnal gaming rig.

## Hardware config

This flake is made to run on a Framework 16 with those specs:
 - AMD RX7700S dGPU
 - Ryzen 9 7940HS CPU
 - 16GB DDR5 RAM

But this config should work ok with any configuration !

## :snowflake: Installation

```nix
sudo nixos-rebuild switch --flake github:dawoox/nixos#neutron
```