{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "172.31.1.1";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="116.203.222.234"; prefixLength=32; }
        ];
        ipv6.addresses = [
          { address="2a01:4f8:1c1e:7475::1"; prefixLength=64; }
{ address="fe80::9400:3ff:fe1b:e38d"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "172.31.1.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "fe80::1"; prefixLength = 128; } ];
      };
                                                                                
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:03:1b:e3:8d", NAME="eth0"
                                                                                
  '';
}
