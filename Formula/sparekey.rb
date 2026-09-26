class Sparekey < Formula
  desc "Let an AI agent unlock your Mac, do its work, and lock it again"
  homepage "https://github.com/yoonpooh/sparekey"
  url "https://github.com/yoonpooh/sparekey/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f6e2b82bb1038573bd02b4fe29a437072e4777d95e059fe7b36ced2575d90628"
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
