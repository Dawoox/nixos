{
  appimageTools,
  lib,
  requireFile,
  makeWrapper,
  ...
}:

appimageTools.wrapType2 rec {
  pname = "Cider";
  version = "2.6.0";

  src = requireFile {
    name = "Cider-linux-appimage-x64.AppImage";
    url = "https://cidercollective.itch.io/cider";
    sha256 = "RZtFmlgu7qm92lU/IvRuHXnWgQDbpNUDhTmitEZzItE=";
  };

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands =
    let
      contents = appimageTools.extract {
        inherit version src;
        inherit pname;
      };
    in
    ''
      wrapProgram $out/bin/${pname} \
         --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}" \
         --add-flags "--no-sandbox --disable-gpu-sandbox" # Cider 2 does not start up properly without these from my preliminary testing

      install -m 444 -D ${contents}/${pname}.desktop $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-warn 'Exec=Cider' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  meta = {
    description = "Powerful music player that allows you listen to your favorite tracks with style";
    homepage = "https://cider.sh";
    license = lib.licenses.unfree;
    mainProgram = "${pname}";
    maintainers = with lib.maintainers; [ itsvic-dev ];
    platforms = [ "x86_64-linux" ];
  };
}