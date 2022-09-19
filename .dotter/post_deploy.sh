set -ex

# Cargo-installable utilities
cargo install --quiet cargo-nextest
cargo install --quiet fd-find
cargo install --quiet ripgrep
cargo install --quiet stylua

# wezterm
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm-nightly
brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
