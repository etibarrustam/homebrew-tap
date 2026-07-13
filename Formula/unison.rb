class Unison < Formula
  desc "Play sound through every speaker at once, control volume and brightness everywhere"
  homepage "https://github.com/etibarrustam/Unison"
  url "https://github.com/etibarrustam/Unison/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "8395ecc10715eb8861b304d0dac76da0ca7905df5c915ec43ed653de51d6b28e"
  license "MIT"
  head "https://github.com/etibarrustam/Unison.git", branch: "main"

  depends_on macos: :sonoma

  def install
    ENV["CONFIG"] = "release"
    ENV["SWIFT_FLAGS"] = "--disable-sandbox"
    system "./Scripts/build-app.sh"
    prefix.install "build/Unison.app"
  end

  def post_install
    # A formula cannot ship straight into /Applications, but nobody looks
    # for an app inside the Cellar. Copy it where apps live.
    app = Pathname("/Applications/Unison.app")
    app.rmtree if app.exist?
    cp_r prefix/"Unison.app", "/Applications/"
  end

  def caveats
    <<~EOS
      Unison was copied to /Applications. Start it with:
        open /Applications/Unison.app

      macOS will ask for two permissions on first launch:
      Accessibility for the volume and brightness keys, and
      System Audio Recording for playing through several devices.
      Unison never uses the microphone.

      brew uninstall does not touch /Applications/Unison.app;
      delete it there as well if you remove Unison.
    EOS
  end

  test do
    assert_predicate prefix/"Unison.app/Contents/MacOS/Unison", :exist?
  end
end
