{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    helix
    git
  ];

  systemd.services.cardano-node = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Cardano node";
    serviceConfig = {
      ExecStart = "${pkgs.nix}/bin/nix run github:intersectmbo/cardano-node -- run --topology /home/cardano/cn-stake-pool/mainnet/topology.json --database-path /home/cardano/cn-stake-pool/mainnet/db --socket-path //home/cardano/cn-stake-pool/mainnet/node.socket --port 3001 --config /home/cardano/cn-stake-pool/mainnet/config.json";
      # Restart = "on-failure";
      RestartSec = 5;
      StartLimitBurst = 3;
      StartLimitInterval = 10;
    };
  };


  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "ubuntu-4gb-nbg1-1";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZqMO9avwTAOyHFxMhdJ+hoec9XDLU0V5d4uvGNzL3OxbpplNd12tTbmqkKZP2ASBUMD/D8OTA1U8zC65KajVlxM6Mn6GoiApHkkY0EMCyQ5vxZQa72/CLJV1+EFNrA72nvXI6gm7VedMQd1ancVXN1qrV1Fg08pimuv0KbnG9xLPnnSF9er5AeYw5iEw3MeljVBfZkeEwUr2CI2rITmfAEytoasqHyQEe+oCnl9gE6p3rkBXrZtenaKiOVXI3anu3dGU9qqTM5D5ajg0NbdBIzLgYkHKKP0Z5hFmFjJH9I5zS/4OU0FuhKi7P8LuNDLWRb8LnUIBZWE3MemFzYs3WRx1yv/RP6W/PV7YBHg5e6/1+RGh9YyiJycrIMMLN3gJK7tfalTXFqNHdzhqDInwQzUbVg2GOmLrqSAubeQuUpcmV2UfnBYOmB9UZaUmBA5lHaIK7Ns2SgTKYlxhajVS2tgl6BtarsIVJ3omS1DYTP0AgbUWx0i6+t7ZSos0pKjM='' ];
  system.stateVersion = "23.11";
}
