#!/bin/bash
 
# This script will run automatically every time a Codespace starts. 
# Use it to force-install your extensions and copy your prompt file into the workspace.

# 1. Install Global Extensions
# These will install in EVERY Codespace you open
code --install-extension saoudrizwan.claude-dev       # Cline (formerly Claude Dev)
code --install-extension ms-vscode.live-server        # Live Preview
code --install-extension esbenp.prettier-vscode       # Prettier
code --install-extension ms-vsliveshare.vsliveshare   # live share
#code --install-extension ritwickdey.liveserver        # (Optional) The other Live Server


# 2. Inject your "Onboard" Prompt
# This copies your prompt file from the dotfiles repo to the root of your workspace
# The $DOTFILES path is automatically set by GitHub
cp "$DOTFILES/onboard-repo.prompt.md" "$HOME/workspace/onboard-repo.prompt.md"

echo "✅ Extensions installed and Prompt file copied!"
