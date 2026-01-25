#!/bin/bash
# =============================================================================
# Update Issue Template Config with Repository URL
# =============================================================================
# This script automatically updates .github/ISSUE_TEMPLATE/config.yml with
# the correct discussions URL based on the repository's git remote.
#
# Usage:
#   ./scripts/update-issue-template.sh
#
# What it does:
#   1. Extracts repository owner/name from git remote
#   2. Replaces YOUR_USERNAME/YOUR_REPOSITORY placeholder with actual values
#   3. Creates a backup before making changes
# =============================================================================

set -e

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
# Main Logic
# =============================================================================

CONFIG_FILE=".github/ISSUE_TEMPLATE/config.yml"

log_info "Updating issue template configuration..."

# Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    log_error "Config file not found: $CONFIG_FILE"
    log_error "Please run this script from the repository root"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    log_error "Not in a git repository"
    exit 1
fi

# Check if remote exists
if ! git remote get-url origin &>/dev/null; then
    log_error "No git remote 'origin' configured"
    exit 1
fi

# Extract repository URL
REPO_URL=$(git remote get-url origin)
log_info "Repository URL: $REPO_URL"

# Parse owner/repo from various URL formats
# Supports: https://github.com/owner/repo.git
#           git@github.com:owner/repo.git
#           https://github.com/owner/repo
if [[ "$REPO_URL" =~ github\.com[:/]([^/]+)/(.+?)(\.git)?$ ]]; then
    REPO_OWNER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"
    # Remove .git suffix if present
    REPO_NAME="${REPO_NAME%.git}"
    
    log_info "Repository: $REPO_OWNER/$REPO_NAME"
    
    DISCUSSIONS_URL="https://github.com/$REPO_OWNER/$REPO_NAME/discussions"
    log_info "Discussions URL: $DISCUSSIONS_URL"
    
    # Check if placeholder exists
    if grep -q "YOUR_USERNAME/YOUR_REPOSITORY" "$CONFIG_FILE"; then
        # Create backup
        cp "$CONFIG_FILE" "$CONFIG_FILE.backup"
        log_info "Created backup: $CONFIG_FILE.backup"
        
        # Replace placeholder with actual URL (backup already created above)
        if sed -i '' "s|https://github.com/YOUR_USERNAME/YOUR_REPOSITORY/discussions|$DISCUSSIONS_URL|g" "$CONFIG_FILE" 2>/dev/null ||
           sed -i "s|https://github.com/YOUR_USERNAME/YOUR_REPOSITORY/discussions|$DISCUSSIONS_URL|g" "$CONFIG_FILE"; then
            log_info "✅ Successfully updated $CONFIG_FILE"
            
            # Show the diff
            echo ""
            log_info "Changes made:"
            diff -u "$CONFIG_FILE.backup" "$CONFIG_FILE" || true
            echo ""
            
            log_info "Backup saved as: $CONFIG_FILE.backup"
            log_info "You can delete the backup once you verify the changes"
        else
            log_error "Failed to update $CONFIG_FILE"
            mv "$CONFIG_FILE.backup" "$CONFIG_FILE"
            log_info "Restored from backup"
            exit 1
        fi
    else
        log_info "✅ Config file already updated (no placeholder found)"
        
        # Show current discussions URL
        CURRENT_URL=$(grep "^[[:space:]]*url:" "$CONFIG_FILE" | head -1 | sed 's/^[[:space:]]*url:[[:space:]]*//')
        if [[ -n "$CURRENT_URL" ]]; then
            log_info "Current discussions URL: $CURRENT_URL"
        fi
    fi
else
    log_error "Could not parse GitHub repository from URL: $REPO_URL"
    log_error "Expected format: https://github.com/owner/repo or git@github.com:owner/repo"
    exit 1
fi

echo ""
log_info "Done! Your issue template is now configured."
