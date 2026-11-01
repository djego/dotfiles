# nvm (Node Version Manager) — shell setup, portable across macOS and Arch Linux.
#
# Stowed to ~/.config/nvm/nvm.zsh. Source it from ~/.zshrc:
#
#   [ -r "$HOME/.config/nvm/nvm.zsh" ] && source "$HOME/.config/nvm/nvm.zsh"

export NVM_DIR="$HOME/.nvm"

# Locate the nvm install. First match wins:
#   - Homebrew, Apple Silicon      /opt/homebrew/opt/nvm
#   - Homebrew, Intel              /usr/local/opt/nvm
#   - Arch Linux (pacman/AUR)      /usr/share/nvm   (init-nvm.sh sources nvm.sh + completion)
#   - Upstream install script      ~/.nvm
for _nvm_prefix in /opt/homebrew/opt/nvm /usr/local/opt/nvm /usr/share/nvm "$NVM_DIR"; do
  if [ -s "$_nvm_prefix/nvm.sh" ]; then
    if [ -s "$_nvm_prefix/init-nvm.sh" ]; then
      \. "$_nvm_prefix/init-nvm.sh"
    else
      \. "$_nvm_prefix/nvm.sh"
      [ -s "$_nvm_prefix/etc/bash_completion.d/nvm" ] && \. "$_nvm_prefix/etc/bash_completion.d/nvm"
    fi
    break
  fi
done
unset _nvm_prefix

# Alternative: lazy load (faster shell startup, first `nvm`/`node`/`npm`/`npx` call pays the cost).
# Replace the block above with this if startup time matters.
#
# nvm() {
#   unset -f nvm node npm npx
#   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#   nvm "$@"
# }
# node() { nvm >/dev/null; node "$@"; }
# npm()  { nvm >/dev/null; npm "$@"; }
# npx()  { nvm >/dev/null; npx "$@"; }
