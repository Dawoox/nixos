{ ... }:
let
  onePassPath = "~/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        ForwardAgent = "false";
        HashKnownHosts = "yes";
        IdentityAgent = onePassPath;
        ConnectTimeout = 10;
        ServerAliveInterval = 30;
      };
      "otter" = {
        # otter is the outside gateway for VIU CSCI services
        # if on a public network csci.viu.ca will resolve to otter.csci.viu.ca
        # if on private VIU network, we cannot go trough otter so go directly to csci.viu.ca
        HostName = "csci.viu.ca";
        User = "bellanap";
        WarnWeakCrypto = "false";
      };
      "csci" = {
        HostName = "cscidb.csci.viu.ca";
        User = "csciadm";
        IdentityFile = "~/.ssh/csci";
        IdentitiesOnly = "yes";
        ProxyJump = "otter";
        WarnWeakCrypto = "false";
      };
      "tuxworld" = {
        HostName = "tuxworld.csci.viu.ca";
        User = "bellanap";
        ProxyJump = "otter";
        DynamicForward = 27000;
        WarnWeakCrypto = "false";
      };
    };
  };
}