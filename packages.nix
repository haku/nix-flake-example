{ withSystem, inputs, ... }:
{
  perSystem = { pkgs, lib, ... }:
  let
    server-env = (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      # package deps go here.
    ]));
    hello-world-package = pkgs.stdenv.mkDerivation rec {
      name = "hello-world";
      src = ./.;
      propagatedBuildInputs = [ server-env ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      installPhase = ''
        runHook preInstall

        sp="$out/${server-env.sitePackages}"
        bin="$out/bin"
        mkdir -p "$sp" "$bin"
        install -m644 *.py "$sp"

        makeWrapper "${lib.getExe server-env}" $bin/hello-world --add-flags "$sp/hello-world.py"

        runHook postInstall
      '';
      meta.mainProgram = name;
    };
  in
  {
    packages = {
      hello-world = hello-world-package;
    };

    make-shells.default = {
      packages = [
        server-env
      ];
    };
  };
}
