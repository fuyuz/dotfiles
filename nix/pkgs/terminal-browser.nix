{ stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "terminal-browser";
  version = "0.4.9";

  src = fetchurl {
    url = "https://terminal-browser.sh/install/dl/stable/v${finalAttrs.version}/terminal-browser-darwin-arm64.tar.gz";
    hash = "sha256-amfynlTwESZcM8Du+pVbpd3LtevSkcPcv2tMWP9KxRE=";
  };

  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  # The bundled launcher resolves the app root relative to $0, which breaks
  # when only bin/ is linked into a profile; wrap it with an absolute path
  installPhase = ''
    runHook preInstall
    mkdir -p $out/libexec/terminal-browser $out/bin
    cp -R . $out/libexec/terminal-browser
    cat > $out/bin/terminal-browser <<EOF
    #!/bin/sh
    exec "$out/libexec/terminal-browser/bin/terminal-browser" "\$@"
    EOF
    chmod +x $out/bin/terminal-browser
    runHook postInstall
  '';

  meta = {
    description = "Browser that runs directly inside your existing terminal";
    homepage = "https://github.com/zenbu-labs/terminal-browser";
    platforms = [ "aarch64-darwin" ];
  };
})
