{ pkgs, ... }:

{
  services.dnscrypt-proxy = {
    enable = true;

    settings = {
      server_names = [
        #"adguard-dns-doh"
        "cloudflare"
      ];

      ipv6_servers = false;
      require_dnssec = true;
      require_nofilter = true;

      sources.public_resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public_resolvers.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      block_ipv6 = true;

      anonymized_dns.routes = [{
        server_name = "*";
        via = [ "cloudflare" ];
      }];
      anonymized_dns.skip_incompatible = true;
    };
  };

  launchd.daemons.dnscrypt-proxy.serviceConfig.UserName = pkgs.lib.mkForce "root";
}
