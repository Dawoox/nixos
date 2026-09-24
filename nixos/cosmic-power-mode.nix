{ pkgs, ... }:

let
  ppd = pkgs.power-profiles-daemon;

  powerMode = pkgs.writeTextFile {
    name = "cosmic-power-mode";
    destination = "/bin/cosmic-power-mode";
    executable = true;
    text = ''
#!/bin/sh
set -eu

# Absolute store path — works from udev, systemd, or anywhere
PPDCTL="${ppd}/bin/powerprofilesctl"

online=0
for f in /sys/class/power_supply/*/online; do
  [ -f "$f" ] || continue
  if [ "$(cat "$f")" = "1" ]; then online=1; fi
done

if [ "$online" = "1" ]; then
  "$PPDCTL" set performance
else
  "$PPDCTL" set balanced
fi
    '';
  };
in
{
  # Power-profiles-daemon: what the Cosmic power applet follows
  services.power-profiles-daemon.enable = true;

  # Trigger on AC plug / unplug. udev fires ACTION=online / ACTION=offline
  # for power_supply devices, and NixOS already sets ENV{PATH} for udev jobs.
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ACTION=="online",  RUN+="${powerMode}/bin/cosmic-power-mode"
    SUBSYSTEM=="power_supply", ACTION=="offline", RUN+="${powerMode}/bin/cosmic-power-mode"
  '';

  systemd.services.cosmic-power-mode-boot = {
    description = "Sync Cosmic power profile with AC state";
    wantedBy = [ "multi-user.target" ];
    wants = [ "power-profiles-daemon.service" ];
    after  = [ "power-profiles-daemon.service" ];
    serviceConfig.ExecStart = "${powerMode}/bin/cosmic-power-mode";
  };
}
