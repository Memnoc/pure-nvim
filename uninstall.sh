#!/usr/bin/env bash
#
#  PureNvim Uninstaller
#

set -e

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/PureNvim"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/PureNvim"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/PureNvim"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/PureNvim"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "Uninstalling PureNvim..."
echo ""

for dir in "$CONFIG_DIR" "$DATA_DIR" "$STATE_DIR" "$CACHE_DIR"; do
  if [ -d "$dir" ]; then
    rm -rf "$dir"
    echo -e "${GREEN}✓${NC} Removed $dir"
  fi
done

echo ""
echo -e "${GREEN}PureNvim removed.${NC}"
echo ""
echo "Remove these lines from your shell config:"
echo ""
echo "  # PureNvim"
echo '  alias pvim="NVIM_APPNAME=PureNvim nvim"'
echo ""
