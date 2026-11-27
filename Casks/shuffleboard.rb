cask "shuffleboard" do
  version "0.27.1"
  sha256 "d19f449019a55f224d1930a4d93171c65540a92a1fb650364717f21c9099cbbc"

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
