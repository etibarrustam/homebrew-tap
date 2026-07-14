cask "unison" do
  version "0.1.7"
  sha256 "c4faf35b35c9f34c13e3a9452944af4ae1369346bb14ca7815be83294ad04dd2"

  url "https://github.com/etibarrustam/Unison/archive/refs/tags/v#{version}.tar.gz"
  name "Unison"
  desc "Play sound through every speaker at once, control volume and brightness everywhere"
  homepage "https://github.com/etibarrustam/Unison"

  depends_on macos: ">= :sonoma"

  installer script: {
    executable: "Unison-#{version}/Scripts/cask-install.sh"
  }

  uninstall delete: "/Applications/Unison.app"

  zap trash: [
    "~/Library/Caches/com.unison.app",
    "~/Library/HTTPStorages/com.unison.app",
    "~/Library/Preferences/com.unison.app.plist",
    "~/Library/Saved Application State/com.unison.app.savedState",
  ]

  caveats <<~EOS
    The app was built on this machine and placed in /Applications.
    Open it once; macOS will ask for two permissions:
    Accessibility for the volume and brightness keys, and
    System Audio Recording for playing through several devices.
    Unison never uses the microphone.
  EOS
end
