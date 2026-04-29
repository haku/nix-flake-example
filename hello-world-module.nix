perSystem:
{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.services.hello-world;
in
{
  options.services.hello-world = {
    enable = mkEnableOption "enable hello-world service.";

    address = mkOption {
      description = "Address to bind to.";
      type = types.nullOr types.str;
      default = null;
    };

    port = mkOption {
      description = "Port to bind to.";
      type = types.int;
    };
  };

  config = mkIf cfg.enable {

    systemd.services.hello-world = {
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = escapeShellArgs(
          [
            "${getExe perSystem.self'.packages.hello-world}"
            "--port" cfg.port
          ]
          ++ optionals (cfg.address != null) [ "--address" cfg.address ]
        );
      };
    };

  };
}
