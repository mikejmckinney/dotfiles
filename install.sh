#!/bin/bash
# =============================================================================
# Codespace Dotfiles Install Script
# =============================================================================
# This script runs automatically when a GitHub Codespace starts.
# It installs VS Code extensions and copies AI prompts to the workspace.
#
# Environment:
#   $DOTFILES - Path to dotfiles repo (set automatically by GitHub Codespaces)
#   $HOME     - User home directory
#
# Usage:
#   Automatic: Linked via GitHub Codespaces settings
#   Manual:    DOTFILES=/path/to/dotfiles bash install.sh
# =============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    printf "${GREEN}[INFO]${NC} %s\n" "$1"
}

log_warn() {
    printf "${YELLOW}[WARN]${NC} %s\n" "$1"
}

log_error() {
    printf "${RED}[ERROR]${NC} %s\n" "$1"
}

# =============================================================================
# Pre-flight Checks
# =============================================================================

# Check if we're in a Codespace or VS Code environment
if ! command -v code &> /dev/null; then
    log_warn "'code' command not found. Extension installation will be skipped."
    log_warn "This is expected outside of VS Code/Codespaces environments."
    SKIP_EXTENSIONS=true
else
    SKIP_EXTENSIONS=false
fi

# Determine dotfiles path
if [[ -z "$DOTFILES" ]]; then
    # Fallback: use script's directory
    DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    log_warn "DOTFILES not set. Using script directory: $DOTFILES"
fi

# Determine workspace path
if [[ -z "$WORKSPACE" ]]; then
    if [[ -d "/workspaces" ]]; then
        # GitHub Codespaces default
        WORKSPACE=$(find /workspaces -maxdepth 1 -type d ! -name workspaces | head -1)
    elif [[ -d "$HOME/workspace" ]]; then
        WORKSPACE="$HOME/workspace"
    else
        WORKSPACE="$PWD"
    fi
fi

# Validate workspace path is not empty
if [[ -z "$WORKSPACE" ]]; then
    log_error "Could not determine workspace path. Please set WORKSPACE environment variable."
    exit 1
fi

log_info "Dotfiles path: $DOTFILES"
log_info "Workspace path: $WORKSPACE"

# =============================================================================
# 1. Install VS Code Extensions
# =============================================================================

EXTENSIONS=(
    "saoudrizwan.claude-dev"       # Cline (formerly Claude Dev) - AI assistant
    "ms-vscode.live-server"        # Live Preview for web development
    "esbenp.prettier-vscode"       # Prettier - code formatter
    "ms-vsliveshare.vsliveshare"   # Live Share - collaborative development
)

if [[ "$SKIP_EXTENSIONS" == "false" ]]; then
    log_info "Installing VS Code extensions..."
    
    for ext in "${EXTENSIONS[@]}"; do
        ext_name="$ext"
        if code --install-extension "$ext_name" 2>/dev/null; then
            log_info "  ✓ Installed: $ext_name"
        else
            log_warn "  ⚠ Failed to install: $ext_name"
        fi
    done
else
    log_info "Skipping extension installation (no 'code' command)"
fi

# =============================================================================
# 2. Copy AI Prompts to Workspace
# =============================================================================

log_info "Setting up AI prompts..."

# Create .github/prompts directory if it doesn't exist
PROMPTS_DIR="$WORKSPACE/.github/prompts"
if [[ ! -d "$PROMPTS_DIR" ]]; then
    mkdir -p "$PROMPTS_DIR"
    log_info "  Created: $PROMPTS_DIR"
fi

# Copy repo-onboarding prompt
ONBOARD_SRC="$DOTFILES/.github/prompts/repo-onboarding.md"
ONBOARD_DST="$PROMPTS_DIR/repo-onboarding.md"
ONBOARD_SRC_EXISTS=false

if [[ -f "$ONBOARD_SRC" ]]; then
    ONBOARD_SRC_EXISTS=true
    if [[ -f "$ONBOARD_DST" ]]; then
        log_warn "  ⚠ $ONBOARD_DST already exists, skipping"
    else
        cp "$ONBOARD_SRC" "$ONBOARD_DST"
        log_info "  ✓ Copied: repo-onboarding.md"
    fi
else
    log_warn "  ⚠ Source not found: $ONBOARD_SRC"
fi

# Copy AGENTS.md to workspace root if not present
AGENTS_SRC="$DOTFILES/AGENTS.md"
AGENTS_DST="$WORKSPACE/AGENTS.md"
AGENTS_SRC_EXISTS=false

if [[ -f "$AGENTS_SRC" ]]; then
    AGENTS_SRC_EXISTS=true
    if [[ -f "$AGENTS_DST" ]]; then
        log_warn "  ⚠ $AGENTS_DST already exists, skipping"
    else
        cp "$AGENTS_SRC" "$AGENTS_DST"
        log_info "  ✓ Copied: AGENTS.md"
    fi
fi

# =============================================================================
# 3. Verification
# =============================================================================

log_info "Verifying installation..."

VERIFY_PASS=0
VERIFY_FAIL=0

verify() {
    if [[ -e "$1" ]]; then
        log_info "  ✓ $1"
        VERIFY_PASS=$((VERIFY_PASS + 1))
    else
        log_error "  ✗ $1"
        VERIFY_FAIL=$((VERIFY_FAIL + 1))
    fi
}

if [[ "$SKIP_EXTENSIONS" == "false" ]]; then
    # Verify extensions are installed
    for ext in "${EXTENSIONS[@]}"; do
        ext_name="$ext"
        if code --list-extensions 2>/dev/null | grep -qi "$ext_name"; then
            log_info "  ✓ Extension: $ext_name"
            VERIFY_PASS=$((VERIFY_PASS + 1))
        else
            log_warn "  ⚠ Extension may not be installed: $ext_name"
        fi
    done
fi

# Verify copied files (only if source existed)
if [[ "$ONBOARD_SRC_EXISTS" == "true" ]]; then
    verify "$ONBOARD_DST"
fi
if [[ "$AGENTS_SRC_EXISTS" == "true" ]]; then
    verify "$AGENTS_DST"
fi

# =============================================================================
# Summary
# =============================================================================

echo ""
echo "========================================"
echo "Installation Complete"
echo "========================================"
echo "Dotfiles: $DOTFILES"
echo "Workspace: $WORKSPACE"

if [[ "$SKIP_EXTENSIONS" == "false" ]]; then
    echo "Extensions: ${#EXTENSIONS[@]} configured"
fi

echo ""
log_info "✅ Dotfiles installation complete!"
