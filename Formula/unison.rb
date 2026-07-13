class Unison < Formula
  desc "Play sound through every speaker at once, control volume and brightness everywhere"
  homepage "https://github.com/etibarrustam/Unison"
  url "https://github.com/etibarrustam/Unison/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "6a74294fda2337082712f2d83ebfd2f3f98d822039a1ed39e0df9be032714089"
  license "MIT"
  head "https://github.com/etibarrustam/Unison.git", branch: "main"

  depends_on macos: :sonoma

  def install
    ENV["CONFIG"] = "release"
    ENV["SWIFT_FLAGS"] = "--disable-sandbox"
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
