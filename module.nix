{ self }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.oomf-time;
in
{
  options.programs.oomf-time = {
    enable = lib.mkEnableOption "oomf-time";
    package = lib.mkPackageOption pkgs "oomf-time" { };
  };

  config = {
    nixpkgs.overlays = [ self.overlays.default ];

    launchd.user.agents.oomf-time = lib.mkIf cfg.enable {
      command = lib.getExe cfg.package;

      serviceConfig = {
        RunAtLoad = true;
        ProcessType = "Interactive";
      };
    };
  };
}
