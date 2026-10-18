class Sparekey < Formula
  desc "Let an AI agent unlock your Mac, do its work, and lock it again"
  homepage "https://github.com/yoonpooh/sparekey"
  url "https://github.com/yoonpooh/sparekey/archive/refs/tags/v0.3.8.tar.gz"
  sha256 "f45893c9af9970d41aabed976a90d5c52670d668bff588f38655ab22c7d21fce"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/sparekey"
  end

  def caveats
    <<~EOS
      Finish setup in a local terminal while your Mac is unlocked:
        sparekey setup --skill codex   # or --skill claude, --no-skill

      Codex and Claude Code install standalone skills.
      Only legacy plugin migration requires Codex CLI on PATH.
      Start a new Codex thread after setup.

      Rerun `sparekey setup` after every `brew upgrade sparekey`.
    EOS
  end

  test do
    assert_match "sparekey #{version}", shell_output("#{bin}/sparekey --version")
    assert_match "Usage:", shell_output("#{bin}/sparekey --help")
  end
end
