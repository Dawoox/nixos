#!/usr/bin/env bash
echo "Reloading Waybar CSS.."
kill -SIGUSR2 $(nix shell nixpkgs#busybox --command pgrep waybar)