{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "hyperion-sddm";
  version = "1.0";
  dontBuild = true;

  src = pkgs.fetchFromGitHub {
    owner = "Raumsegler1"; # Replace with the actual owner
    repo = "hyperion-sddm"; # Replace with the actual repository
    rev = "main"; # Replace with the desired branch, tag, or commit
    sha256 = "your-theme-hash"; # Replace with the actual sha256 hash
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/$pname
    cp -r $src/* $out/share/sddm/themes/$pname
  '';
}