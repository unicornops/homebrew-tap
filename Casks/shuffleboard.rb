cask "shuffleboard" do
  version "0.25.0"
  sha256 "d9415cf7ae597e4a9cc9292c2a403b7be4b93a681a7c934a271fa9bb1412f5a1"

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
