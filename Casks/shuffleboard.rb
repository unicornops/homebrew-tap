cask "shuffleboard" do
  version "0.26.0"
  sha256 "4b893e64f437395a277493674eb51e1a71a8a7fca6419007b318dd62d42c51c5"

  url "https://github.com/unicornops/shuffleboard/releases/download/v#{version}/Shuffleboard-#{version}.dmg"
  name "Shuffleboard"
  desc "Unofficial client for Nextcloud Deck"
  homepage "https://github.com/unicornops/shuffleboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Shuffleboard.app"

  zap trash: [
    "~/Library/Application Scripts/ie.unicornops.shuffleboard",
    "~/Library/Containers/ie.unicornops.shuffleboard",
  ]
end
