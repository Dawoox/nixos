let
  dawoox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMi7cl+b1+kWmwe71O9CFwbGdv9/FzZqJM2KQddYPPGf me@antoinebellanger.fr";
  users = [ dawoox ];

  laptop-antoine = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINgRaMFScv1hdl73DEkd7THEksFA/q1t7P57NjfzfRQg root@nixos";
  systems = [ laptop-antoine ];
in
{
  "wakatime_api_key.age".publicKeys = users ++ systems;
}
