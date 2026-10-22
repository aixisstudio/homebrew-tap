# Snitch — Homebrew formula template (rendered by release.yml →
# aixisstudio/homebrew-tap). 1.6.3/024c3748681efd20893c8bb646c2127e3a272a43a3bcfc04ed9086c33e7e7355 are CI placeholders.
# FR: Modèle de formule Homebrew (rendu par release.yml vers le tap).
class Snitch < Formula
  desc "Local-first network observability and outbound firewall"
  homepage "https://github.com/aixisstudio/Snitch"
  url "https://github.com/aixisstudio/Snitch/archive/refs/tags/v1.6.3.tar.gz"
  sha256 "024c3748681efd20893c8bb646c2127e3a272a43a3bcfc04ed9086c33e7e7355"
  license "AGPL-3.0-or-later"
  head "https://github.com/aixisstudio/Snitch.git", branch: "main"

  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install resources
    # EN: the backend is the product — install the tree, link a launcher.
    # FR: le backend est le produit — installer l'arbre, lier un lanceur.
    libexec.install "backend"
    # EN: `snitchd`, not `snitch` — karol-broda/snitch (an ss/netstat
    #     replacement) already owns the bare CLI name for packagers.
    # FR: « snitchd », pas « snitch » — karol-broda/snitch (remplaçant
    #     de ss/netstat) possède déjà le nom CLI nu pour les packageurs.
    (bin/"snitchd").write_env_script libexec/"bin/python",
      "-m uvicorn api.main:app --host 127.0.0.1 --port 8000",
      PYTHONPATH: libexec/"backend", SNITCH_DATA_DIR: var/"snitch"
  end

  service do
    run [opt_bin/"snitchd"]
    keep_alive true
    log_path var/"log/snitch.log"
    error_log_path var/"log/snitch.log"
  end

  test do
    system bin/"snitchd", "--help"
  end
end
