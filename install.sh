#!/usr/bin/env bash
#
#  PureNvim Installer
#  Single-file Neovim config for systems programming
#

set -e

REPO="https://github.com/memnoc/PureNvim"
INSTALL_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/PureNvim"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/PureNvim"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
cat << 'EOF'
  ____                  _   _       _           
 |  _ \ _   _ _ __ ___ | \ | |_   _(_)_ __ ___  
 | |_) | | | | '__/ _ \|  \| \ \ / / | '_ ` _ \ 
 |  __/| |_| | | |  __/| |\  |\ V /| | | | | | |
 |_|    \__,_|_|  \___|_| \_| \_/ |_|_| |_| |_|
                                                
EOF
echo -e "${NC}"
echo -e "${BLUE}Single-file Neovim for C / C++ / Rust${NC}"
echo ""

# Check Neovim
check_nvim() {
  if ! command -v nvim &> /dev/null; then
    echo -e "${RED}Error: Neovim not found${NC}"
    echo "Install Neovim 0.12+ first"
    echo "Recommended: https://github.com/MordechaiHadad/bob"
    exit 1
  fi

  NVIM_VERSION=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+')
  MAJOR=$(echo "$NVIM_VERSION" | cut -d. -f1)
  MINOR=$(echo "$NVIM_VERSION" | cut -d. -f2)

  if [ "$MAJOR" -lt 1 ] && [ "$MINOR" -lt 12 ]; then
    echo -e "${RED}Warning: Neovim 0.12+ recommended (found $NVIM_VERSION)${NC}"
    echo "Some features may not work. Continue anyway? [y/N]"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
      exit 1
    fi
  else
    echo -e "${GREEN}✓${NC} Neovim $NVIM_VERSION"
  fi
}

# Check dependencies
check_deps() {
  local missing=()

  for cmd in git rg fd cc; do
    if command -v "$cmd" &> /dev/null; then
      echo -e "${GREEN}✓${NC} $cmd"
    else
      echo -e "${RED}✗${NC} $cmd"
      missing+=("$cmd")
    fi
  done

  if [ ${#missing[@]} -gt 0 ]; then
    echo ""
    echo -e "${RED}Missing: ${missing[*]}${NC}"
    echo ""
    echo "Install with:"
    echo "  macOS:  brew install ripgrep fd"
    echo "  Arch:   sudo pacman -S ripgrep fd"
    echo "  Ubuntu: sudo apt install ripgrep fd-find"
    echo ""
    echo "Continue without them? [y/N]"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
      exit 1
    fi
  fi
}

# Install
install() {
  echo ""
  if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing installation..."
    git -C "$INSTALL_DIR" pull --ff-only
  else
    echo "Cloning PureNvim..."
    git clone --depth 1 "$REPO" "$INSTALL_DIR"
  fi

  mkdir -p "$DATA_DIR"
  echo -e "${GREEN}✓${NC} Installed to $INSTALL_DIR"
}

# Setup alias
setup_alias() {
  local shell_config=""
  local alias_line='alias pvim="NVIM_APPNAME=PureNvim nvim"'

  if [ -f "$HOME/.zshrc" ]; then
    shell_config="$HOME/.zshrc"
  elif [ -f "$HOME/.bashrc" ]; then
    shell_config="$HOME/.bashrc"
  fi

  if [ -n "$shell_config" ]; then
    if ! grep -q "NVIM_APPNAME.*PureNvim" "$shell_config" 2>/dev/null; then
      echo "" >> "$shell_config"
      echo "# PureNvim" >> "$shell_config"
      echo "$alias_line" >> "$shell_config"
      echo -e "${GREEN}✓${NC} Added 'pvim' alias to $shell_config"
    else
      echo -e "${GREEN}✓${NC} Alias already exists"
    fi
  fi
}

# Main
main() {
  echo "Checking requirements..."
  echo ""
  check_nvim
  check_deps
  install
  setup_alias

  echo ""
  echo -e "${GREEN}Installation complete!${NC}"
  echo ""
  echo "Start PureNvim:"
  echo -e "  ${CYAN}pvim${NC}                           (after restarting shell)"
  echo -e "  ${CYAN}NVIM_APPNAME=PureNvim nvim${NC}     (now)"
  echo ""
  echo "First launch:"
  echo "  1. Treesitter parsers will auto-install"
  echo "  2. Run :Mason to install LSP servers"
  echo "     - clangd (C/C++)"
  echo "     - rust-analyzer (Rust)"
  echo "     - lua-language-server (Lua)"
  echo ""
}

main "$@"
