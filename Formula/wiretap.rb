# Wiretap - Homebrew formula (rendered by release.yml -> aixisstudio/homebrew-tap).
# FR: Formule Homebrew Wiretap (rendue par release.yml vers le tap).
class Wiretap < Formula
  desc "Local-first application firewall and network observer"
  homepage "https://github.com/aixisstudio/Wiretap"
  url "https://github.com/aixisstudio/Wiretap/archive/refs/tags/v1.6.4.tar.gz"
  sha256 "e75861f325692c0fdfa5b26bd5d786683c4e518fdd03619a8bb44b7a5de25918"
  license "AGPL-3.0-or-later"
  head "https://github.com/aixisstudio/Wiretap.git", branch: "main"

  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install resources
    # EN: the backend is the product - install the tree, link a launcher.
    # FR: le backend est le produit - installer l'arbre, lier un lanceur.
    libexec.install "backend"
    (bin/"wiretapd").write_env_script libexec/"bin/python",
      "-m uvicorn api.main:app --host 127.0.0.1 --port 8000",
      PYTHONPATH: libexec/"backend", WIRETAP_DATA_DIR: var/"wiretap"
  end

  service do
    run [opt_bin/"wiretapd"]
    keep_alive true
    log_path var/"log/wiretap.log"
    error_log_path var/"log/wiretap.log"
  end

  test do
    system bin/"wiretapd", "--help"
  end
end
