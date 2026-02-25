{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "ccboard";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "FlorianBruniaux";
    repo = "ccboard";
    rev = "v0.10.0";
    hash = "sha256-Xq2JLAhWBVb5XP6EAEPIzjzQsSYlMO4kVheIlp/OKD0=";
  };

  cargoLock.lockFile = ./ccboard-Cargo.lock;

  postPatch = ''
    cp ${./ccboard-Cargo.lock} Cargo.lock
  '';

  cargoBuildFlags = [ "-p" "ccboard" ];
  cargoTestFlags = [ "-p" "ccboard" ];

  meta = {
    description = "TUI dashboard for Claude Code session monitoring";
    homepage = "https://github.com/FlorianBruniaux/ccboard";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "ccboard";
  };
}
