#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# CONFIGURATION
# Keep in sync with: nvim/lua/core/env.lua (the nvim-side twin)
# ============================================================

PYTHON_VENV="$HOME/py-env/.venv"      # env.lua: M.python_venv
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"      # env.lua: M.nvm_dir
GOROOT="${GOROOT:-/usr/local/go}"     # env.lua: M.goroot
GOPATH="${GOPATH:-$HOME/go}"          # env.lua: M.gopath
NVIM_BIN="${NVIM_BIN:-/opt/nvim/nvim}"

NERD_FONT="FiraCode"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$SCRIPT_DIR/nvim"
TARGET="$HOME/.config/nvim"

info()  { printf "\033[1;34m[INFO]\033[0m  %s\n" "$1"; }
warn()  { printf "\033[1;33m[WARN]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[OK]\033[0m    %s\n" "$1"; }
fail()  { printf "\033[1;31m[FAIL]\033[0m  %s\n" "$1"; }

errors=0

check_bin() {
  local name="$1"
  local path="$2"

  if [ -n "$path" ] && [ -x "$path" ]; then
    ok "$name found at $path"
    return 0
  elif command -v "$name" &>/dev/null; then
    ok "$name found at $(command -v "$name")"
    return 0
  else
    fail "$name not found (checked: $path, PATH)"
    errors=$((errors + 1))
    return 1
  fi
}

# ----------------------------------------------------------
# Phase 1: Verify prerequisites
# ----------------------------------------------------------
verify_prerequisites() {
  info "Checking prerequisites..."
  echo

  # Neovim
  if [ -x "$NVIM_BIN" ]; then
    local nvim_ver
    nvim_ver="$("$NVIM_BIN" --version | head -1)"
    ok "neovim: $nvim_ver (at $NVIM_BIN)"
  elif command -v nvim &>/dev/null; then
    NVIM_BIN="$(command -v nvim)"
    local nvim_ver
    nvim_ver="$(nvim --version | head -1)"
    ok "neovim: $nvim_ver (at $NVIM_BIN)"
  else
    fail "neovim not found at $NVIM_BIN or on PATH"
    errors=$((errors + 1))
  fi

  # Python venv
  if [ -x "$PYTHON_VENV/bin/python" ]; then
    ok "python venv: $PYTHON_VENV/bin/python"
  else
    fail "python venv not found at $PYTHON_VENV/bin/python"
    errors=$((errors + 1))
  fi

  # Node (via nvm or PATH)
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    # shellcheck source=/dev/null
    source "$NVM_DIR/nvm.sh"
    if command -v node &>/dev/null; then
      ok "node: $(node --version) (via nvm)"
    else
      fail "nvm loaded but no node version active — run: nvm install --lts"
      errors=$((errors + 1))
    fi
  elif command -v node &>/dev/null; then
    ok "node: $(node --version) (from PATH)"
  else
    fail "node not found (checked nvm at $NVM_DIR, PATH)"
    errors=$((errors + 1))
  fi

  # Go
  if [ -x "$GOROOT/bin/go" ]; then
    ok "go: $("$GOROOT/bin/go" version) (GOROOT=$GOROOT)"
  elif command -v go &>/dev/null; then
    ok "go: $(go version) (from PATH)"
  else
    warn "go not found — gopls LSP won't work until go is installed"
  fi

  # System tools
  check_bin "git" ""
  check_bin "rg" ""
  check_bin "curl" ""
  check_bin "unzip" ""

  # fd (Ubuntu ships it as fdfind)
  if command -v fd &>/dev/null; then
    ok "fd found at $(command -v fd)"
  elif command -v fdfind &>/dev/null; then
    ok "fd found as fdfind (will create symlink)"
  else
    fail "fd/fdfind not found — needed by telescope"
    errors=$((errors + 1))
  fi

  # xclip (for clipboard on X11)
  if [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
    if command -v xclip &>/dev/null || command -v xsel &>/dev/null || command -v wl-copy &>/dev/null; then
      ok "clipboard tool available"
    else
      warn "no clipboard tool (xclip/xsel/wl-copy) — clipboard may not work"
    fi
  fi

  echo
  if [ "$errors" -gt 0 ]; then
    fail "$errors prerequisite(s) missing. Fix them and re-run."
    exit 1
  fi

  ok "All prerequisites satisfied."
  echo
}

# ----------------------------------------------------------
# Phase 2: Ensure py-env has pynvim
# ----------------------------------------------------------
ensure_pynvim() {
  info "Checking pynvim in $PYTHON_VENV..."

  if "$PYTHON_VENV/bin/python" -c "import pynvim" 2>/dev/null; then
    ok "pynvim already installed"
  else
    info "Installing pynvim..."
    if command -v uv &>/dev/null; then
      uv pip install --python "$PYTHON_VENV/bin/python" pynvim
    elif [ -x "$PYTHON_VENV/bin/pip" ]; then
      "$PYTHON_VENV/bin/pip" install pynvim
    else
      fail "Neither uv nor pip found — cannot install pynvim"
      return 1
    fi
    ok "pynvim installed"
  fi
}

# ----------------------------------------------------------
# Phase 3: Create fd symlink if needed
# ----------------------------------------------------------
ensure_fd_symlink() {
  if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    local bin_dir="$HOME/.local/bin"
    mkdir -p "$bin_dir"
    ln -sf "$(command -v fdfind)" "$bin_dir/fd"
    ok "Created symlink: $bin_dir/fd -> $(command -v fdfind)"
    info "Make sure $bin_dir is on your PATH"
  fi
}

# ----------------------------------------------------------
# Phase 4: Install Nerd Font
# ----------------------------------------------------------
install_font() {
  local font_dir="$HOME/.local/share/fonts/$NERD_FONT"

  if [ -d "$font_dir" ] && [ "$(ls -A "$font_dir" 2>/dev/null)" ]; then
    ok "$NERD_FONT Nerd Font already installed"
    return
  fi

  info "Installing $NERD_FONT Nerd Font..."
  mkdir -p "$font_dir"
  curl -fsSL "$NERD_FONT_URL" -o "/tmp/$NERD_FONT.zip"
  unzip -qo "/tmp/$NERD_FONT.zip" -d "$font_dir"
  rm -f "/tmp/$NERD_FONT.zip"
  fc-cache -fv >/dev/null 2>&1
  ok "$NERD_FONT Nerd Font installed to $font_dir"
}

# ----------------------------------------------------------
# Phase 5: Symlink nvim config
# ----------------------------------------------------------
link_config() {
  if [ -L "$TARGET" ]; then
    warn "Removing existing symlink: $TARGET -> $(readlink "$TARGET")"
    rm "$TARGET"
  elif [ -e "$TARGET" ]; then
    warn "Backing up existing config to ${TARGET}.bak"
    mv "$TARGET" "${TARGET}.bak"
  fi

  mkdir -p "$(dirname "$TARGET")"
  ln -s "$NVIM_CONFIG" "$TARGET"
  ok "Linked: $TARGET -> $NVIM_CONFIG"
}

# ----------------------------------------------------------
# Phase 6: Install plugins and LSP servers
# ----------------------------------------------------------
install_plugins() {
  info "Installing plugins via lazy.nvim (this may take a minute)..."
  "$NVIM_BIN" --headless "+Lazy! sync" +qa 2>/dev/null
  ok "Plugins installed"

  info "Installing LSP servers via Mason..."
  "$NVIM_BIN" --headless "+MasonInstall pyright vtsls eslint gopls clangd html-lsp css-lsp dockerfile-language-server" +qa 2>/dev/null
  ok "LSP servers installed"
}

# ----------------------------------------------------------
# Main
# ----------------------------------------------------------
main() {
  echo
  echo "  ╔══════════════════════════════════════╗"
  echo "  ║   Neovim VSCode-like Setup           ║"
  echo "  ╚══════════════════════════════════════╝"
  echo

  verify_prerequisites
  ensure_pynvim
  ensure_fd_symlink
  install_font
  link_config
  install_plugins

  echo
  ok "Done! Open nvim and verify with :checkhealth"
  info "Set your terminal font to '$NERD_FONT Nerd Font'"
  echo
}

main "$@"
