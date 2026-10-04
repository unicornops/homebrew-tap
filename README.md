# UnicornOps Homebrew tap

Homebrew casks for apps by [UnicornOps](https://github.com/unicornops).

## Shuffleboard

[Shuffleboard](https://github.com/unicornops/shuffleboard) is an unofficial native macOS client for Nextcloud Deck. It is an independent project and is not affiliated with or endorsed by Nextcloud.

```bash
brew install --cask unicornops/tap/shuffleboard
```

Shuffleboard updates itself (Sparkle) from version 0.16.0. Earlier versions are upgraded with `brew upgrade --cask shuffleboard`.

## How the cask stays current

[`Update Shuffleboard`](.github/workflows/update-shuffleboard.yml) runs daily (or by hand). It reads the latest Shuffleboard release, takes the DMG's SHA-256 from the release's `checksums.txt`, regenerates [`Casks/shuffleboard.rb`](Casks/shuffleboard.rb) with [`scripts/update-shuffleboard.py`](scripts/update-shuffleboard.py), and commits any change. [`CI`](.github/workflows/ci.yml) runs `brew style`, `brew audit --strict --online` and a real install on macOS for every change.
