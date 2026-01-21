#!/usr/bin/env bash
# Shows sync state of Claude Code configurations

MEDIUMORCHID='\033[38;5;207m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${MEDIUMORCHID}Claude Code Configuration Status${NC}"
echo "=================================="
echo ""

# Check if .claude directory exists
if [ ! -d ~/.claude ]; then
    echo -e "${RED}✗ ~/.claude directory not found${NC}"
    echo "  Claude Code doesn't appear to be set up yet"
    exit 1
fi

# Check .claude.json
echo "Configuration Files:"
if [ -f ~/.claude.json ]; then
    echo -e "  ${YELLOW}! .claude.json: LOCAL ONLY (not tracked in dotfiles)${NC}"
    echo -e "    ${YELLOW}→${NC} This is a runtime state file and should not be synced"
else
    echo -e "  ${RED}✗ .claude.json: MISSING${NC}"
fi

# Check for skills
echo ""
echo "Skills:"
if [ -d ~/.claude/skills ]; then
    skill_count=$(find ~/.claude/skills -maxdepth 1 -type d | tail -n +2 | wc -l | xargs)
    if [ "$skill_count" -gt 0 ]; then
        for skill in ~/.claude/skills/*; do
            if [ -d "$skill" ]; then
                skill_name=$(basename "$skill")
                echo -e "  ${GREEN}✓${NC} $skill_name: installed"
            fi
        done
    else
        echo "  No skills installed"
    fi
else
    echo "  No skills directory found"
fi

# Check for MCP servers
echo ""
echo "MCP Configuration:"
if [ -f ~/.claude/mcp.json ]; then
    echo -e "  ${GREEN}✓${NC} mcp.json: configured"
    server_count=$(grep -c '"name"' ~/.claude/mcp.json 2>/dev/null || echo "0")
    echo "    $server_count MCP server(s) configured"
else
    echo "  No MCP servers configured"
fi

# Tracked config files
echo ""
echo "Tracked Configuration Files:"
tracked_configs=(
    ".zshenv"
    ".zshrc"
    ".zsh_aliases"
    ".zsh_exports"
    ".vimrc"
    ".p10k.zsh"
    ".config/gh/config.yml"
    ".config/karabiner/karabiner.json"
    ".config/ghostty/themes"
)

for config in "${tracked_configs[@]}"; do
    if [ -e ~/"$config" ]; then
        echo -e "  ${GREEN}✓${NC} $config: present"
    else
        echo -e "  ${RED}✗${NC} $config: missing"
    fi
done

echo ""
echo -e "${MEDIUMORCHID}Tip:${NC} Run bootstrap.sh to set up your development environment"
