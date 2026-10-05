cask "snitch" do
  # EN: Snitch is not notarized (no paid Apple Developer ID), so Gatekeeper
  #     still prompts on first open. Install with --no-quarantine to skip it:
  #       brew install --cask --no-quarantine aixisstudio/tap/snitch
  # FR: Snitch n'est pas notarisé (pas de Developer ID payant), donc
  #     Gatekeeper demande confirmation au premier lancement. Installer avec
  #     --no-quarantine pour l'éviter :
  #       brew install --cask --no-quarantine aixisstudio/tap/snitch
  version "1.0.1"
  sha256 "a013f9c0048f76ea8678ad4a502e147f547776c83704041c97822e18a96ba531"

  url "https://github.com/aixisstudio/Snitch/releases/download/v#{version}/Snitch-#{version}-macos-arm64.zip"
  name "Snitch"
  desc "Local-first, privacy-focused real-time network traffic visualizer"
  homepage "https://aixisstudio.github.io/Snitch/"

  # EN: Apple Silicon only for now / FR: Apple Silicon uniquement pour l'instant
  depends_on arch: :arm64

  app "Snitch.app"

  # EN: On first launch Snitch asks for the admin password ONCE — the packet
  #     capture backend needs it to observe network traffic (same as
  #     tcpdump/Wireshark). The UI itself stays unprivileged.
  # FR: Au premier lancement, Snitch demande le mot de passe admin UNE fois —
  #     le backend de capture en a besoin pour observer le trafic réseau
  #     (comme tcpdump/Wireshark). L'UI reste non privilégiée.
  caveats <<~EOS
    Snitch is ad-hoc signed, not notarized. If macOS says the app
    "cannot be opened", run:  xattr -dr com.apple.quarantine "#{appdir}/Snitch.app"
    (or install this cask with --no-quarantine).
    First launch asks for your admin password once — packet capture
    requires it (same as tcpdump/Wireshark).

    Snitch est signé ad-hoc, pas notarisé. Si macOS dit que l'app
    « ne peut pas être ouverte », lancez : xattr -dr com.apple.quarantine "#{appdir}/Snitch.app"
    (ou installez ce cask avec --no-quarantine).
    Le premier lancement demande une fois le mot de passe admin —
    la capture de paquets l'exige (comme tcpdump/Wireshark).
  EOS
end
