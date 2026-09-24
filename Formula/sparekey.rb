class Sparekey < Formula
  desc "Let an AI agent unlock your Mac, do its work, and lock it again"
  homepage "https://github.com/yoonpooh/sparekey"
  url "https://github.com/yoonpooh/sparekey/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7078f7e6820480556954173945f77d3577f111dd4bfe98e63e8aa7c2a1479f14"
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

      Rerun `sparekey setup` after every `brew upgrade sparekey`.
    EOS
  end

  test do
    assert_match "sparekey #{version}", shell_output("#{bin}/sparekey --version")
    assert_match "Usage:", shell_output("#{bin}/sparekey --help")
  end
end
