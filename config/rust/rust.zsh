# Rust (rustup) — shell setup, portable across macOS and Arch Linux.
#
# Stowed to ~/.config/rust/rust.zsh. Source it from ~/.zshenv (not ~/.zshrc) so
# non-interactive shells and editors also get cargo/rustc on PATH:
#
#   [ -r "$HOME/.config/rust/rust.zsh" ] && source "$HOME/.config/rust/rust.zsh"
#
# rustup generates ~/.cargo/env per machine; it only adds ~/.cargo/bin to PATH.
if [ -r "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
elif [ -d "$HOME/.cargo/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$HOME/.cargo/bin:$PATH" ;;
  esac
fi
