cask "unison" do
  version "0.2.2"
  sha256 "cf5f2fc6df093183d0ad0c8f30631f8fd2f43ca616e03387236c55dca83f1b22"

  url "https://github.com/etibarrustam/Unison/archive/refs/tags/v#{version}.tar.gz"
  name "Unison"
  desc "Play sound through every speaker at once, control volume and brightness everywhere"
  homepage "https://github.com/etibarrustam/Unison"

  depends_on macos: :sonoma

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
