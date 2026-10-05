cask "snitch" do
  # EN: Snitch is not notarized (no paid Apple Developer ID), so Gatekeeper
  #     would prompt on first open. Homebrew 7 removed --no-quarantine, so
  #     this cask strips the quarantine attribute itself in postflight —
  #     installing from this tap is explicit user consent.
  # FR: Snitch n'est pas notarisé (pas de Developer ID payant), donc
  #     Gatekeeper demanderait confirmation au premier lancement. Homebrew 7
  #     a supprimé --no-quarantine, donc ce cask retire lui-même l'attribut de
  #     quarantaine en postflight — installer depuis ce tap est un
  #     consentement explicite de l'utilisateur.
  version "1.0.4"
  sha256 "e6c4257c5b22c1e1fc175bf9fc5dc93798db7ea6ee7d09b6d9de4c37b8082f2e"

  url "https://github.com/aixisstudio/Snitch/releases/download/v#{version}/Snitch-#{version}-macos-arm64.zip"
  name "Snitch"
  desc "Local-first, privacy-focused real-time network traffic visualizer"
  homepage "https://aixisstudio.github.io/Snitch/"

  # EN: Apple Silicon only for now / FR: Apple Silicon uniquement pour l'instant
  depends_on arch: :arm64

  app "Snitch.app"

  postflight_steps do
    # EN: Homebrew 7 removed --no-quarantine; strip the quarantine attribute
    #     ourselves so Gatekeeper never prompts. `run` executes without sudo.
    # FR: Homebrew 7 a supprimé --no-quarantine ; on retire nous-mêmes
    #     l'attribut de quarantaine pour que Gatekeeper ne demande rien.
    #     `run` s'exécute sans sudo.
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Snitch.app"]
  end

  # EN: On first launch Snitch asks for the admin password ONCE — the packet
  #     capture backend needs it to observe network traffic (same as
  #     tcpdump/Wireshark). The UI itself stays unprivileged.
  # FR: Au premier lancement, Snitch demande le mot de passe admin UNE fois —
  #     le backend de capture en a besoin pour observer le trafic réseau
  #     (comme tcpdump/Wireshark). L'UI reste non privilégiée.
  caveats <<~EOS
    First launch asks for your admin password once — packet capture
    requires it (same as tcpdump/Wireshark). The app is ad-hoc signed
    and already de-quarantined by this tap.

    Le premier lancement demande une fois le mot de passe admin —
    la capture de paquets l'exige (comme tcpdump/Wireshark). L'app
    est signée ad-hoc et déjà dé-quarantainée par ce tap.
  EOS
end
