class Unison < Formula
  desc "Play sound through every speaker at once, control volume and brightness everywhere"
  homepage "https://github.com/etibarrustam/Unison"
  url "https://github.com/etibarrustam/Unison/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "eff79eee0eeaaf36f9b1a40d00e3404aaf801b4170fa98c033446f174f25a863"
  license "MIT"
  head "https://github.com/etibarrustam/Unison.git", branch: "main"

  depends_on macos: :sonoma

  def install
    ENV["CONFIG"] = "release"
    system "./Scripts/build-app.sh"
    prefix.install "build/Unison.app"
  end

  def caveats
    <<~EOS
      Copy the app to your Applications folder and open it:
        cp -R "#{opt_prefix}/Unison.app" /Applications/
        open /Applications/Unison.app

      macOS will ask for two permissions on first launch:
      Accessibility for the volume and brightness keys, and
      System Audio Recording for playing through several devices.
      Unison never uses the microphone.
    EOS
  end

  test do
    assert_predicate prefix/"Unison.app/Contents/MacOS/Unison", :exist?
  end
end
