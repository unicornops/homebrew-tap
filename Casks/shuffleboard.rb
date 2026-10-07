cask "shuffleboard" do
  version "0.17.0"
  sha256 "c63013290dde2929d1146de1b67753c57e39c5f91b7295120e27714d0f29270f"

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
