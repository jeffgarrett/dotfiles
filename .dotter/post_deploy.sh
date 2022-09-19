set -ex

# Install or update rustup
rustup_dir="${HOME}/.cargo/bin"
rustup="${rustup_dir}/rustup"

if ! [ -x "${rustup}" ]; then
  echo "installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "updating rustup"
  "${rustup}" self update
fi

# Install or update toolchains
rustup set profile default
rustup component add miri rust-analyzer
rustup toolchain install stable nightly
rustup default nightly

# Cargo-installable utilities
cargo install --quiet cargo-nextest
cargo install --quiet fd-find
cargo install --quiet ripgrep
cargo install --quiet stylua
