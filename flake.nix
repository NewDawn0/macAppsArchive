{
  description = "Useful mac apps archived";

  inputs.utils.url = "github:NewDawn0/nixUtils";

  outputs = { self, utils, ... }: {
    overlays.default = final: prev: {
      mac-apps = self.packages.${prev.system}.default;
    };
    packages =
      utils.lib.eachSystem { systems = [ "x86_64-darwin" "aarch64-darwin" ]; }
      (pkgs: {
        default = pkgs.stdenv.mkDerivation {
          name = "mac-apps-archive";
          src = ./.;
          installPhase = ''
            mkdir -p $out/Applications
            mv apps/* $out/Applications/
          '';
          meta = with pkgs.lib; {
            description = "Useful mac apps archived";
            homepage = "https://github.com/NewDawn0/macAppsArchive";
            platforms = platforms.darwin;
          };
        };
      });
  };
}
