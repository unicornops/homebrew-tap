#!/usr/bin/env python3
"""Write Casks/shuffleboard.rb for the latest Shuffleboard release.

Reads the latest (non-draft, non-pre-release) release of unicornops/shuffleboard from the GitHub API, takes
the DMG's SHA-256 from the release's checksums.txt, and writes the cask. The cask only declares
`auto_updates true` when the release ships a Sparkle appcast.xml: older releases can't update themselves,
and Homebrew doesn't upgrade auto-updating casks by default.

Prints the version written. Exits non-zero if the release is missing the DMG or its checksum.
"""

import json
import os
import re
import sys
import urllib.request
from pathlib import Path

REPO = "unicornops/shuffleboard"
CASK = Path(__file__).resolve().parent.parent / "Casks" / "shuffleboard.rb"


def fetch(url: str) -> bytes:
    request = urllib.request.Request(url, headers={"Accept": "application/vnd.github+json"})
    token = os.environ.get("GITHUB_TOKEN")
    if token and url.startswith("https://api.github.com/"):
        request.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(request, timeout=30) as response:
        return response.read()


def render(version: str, sha256: str, auto_updates: bool) -> str:
    auto = "\n  auto_updates true\n" if auto_updates else "\n"
    return f'''cask "shuffleboard" do
  version "{version}"
  sha256 "{sha256}"

  url "https://github.com/{REPO}/releases/download/v#{{version}}/Shuffleboard-#{{version}}.dmg"
  name "Shuffleboard"
  desc "Unofficial client for Nextcloud Deck"
  homepage "https://github.com/{REPO}"

  livecheck do
    url :url
    strategy :github_latest
  end
{auto}  depends_on macos: :sonoma

  app "Shuffleboard.app"

  zap trash: [
    "~/Library/Application Scripts/ie.unicornops.shuffleboard",
    "~/Library/Containers/ie.unicornops.shuffleboard",
  ]
end
'''


def main() -> int:
    release = json.loads(fetch(f"https://api.github.com/repos/{REPO}/releases/latest"))
    version = release["tag_name"].removeprefix("v")
    assets = {asset["name"]: asset["browser_download_url"] for asset in release["assets"]}
    dmg = f"Shuffleboard-{version}.dmg"
    if dmg not in assets or "checksums.txt" not in assets:
        print(f"Release {version} has no {dmg} or checksums.txt yet", file=sys.stderr)
        return 1

    checksums = fetch(assets["checksums.txt"]).decode()
    match = re.search(rf"^([0-9a-f]{{64}})\s+\*?{re.escape(dmg)}$", checksums, re.MULTILINE)
    if not match:
        print(f"checksums.txt has no SHA-256 for {dmg}", file=sys.stderr)
        return 1

    CASK.parent.mkdir(parents=True, exist_ok=True)
    CASK.write_text(render(version, match.group(1), auto_updates="appcast.xml" in assets))
    print(version)
    return 0


if __name__ == "__main__":
    sys.exit(main())
