cask "shuffleboard" do
  version "0.17.4"
  sha256 "0de5422dbcac8103fb78e5bef4b551015a7ab693dad6ee22532d2600db96cb29"

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
