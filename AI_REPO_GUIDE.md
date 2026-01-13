<!-- TEMPLATE_PLACEHOLDER: This file must be regenerated for the actual project repo. -->
<!-- Run .github/prompts/repo-onboarding.md to rebuild this guide from real repo assets. -->

# AI_REPO_GUIDE.md

> **Purpose**: Canonical reference for AI agents working with this template repository.  
> **Last verified**: 2025-01-10

## Overview

This is a **dotfiles template repository** for GitHub Codespaces and AI-assisted development. It provides:
- Pre-configured AI agent prompts for onboarding and code review
- Automatic VS Code extension installation on Codespace startup
- Standardized files that can be copied to new repositories

## Quick Start

```bash
# Verify template files
./test.sh

# Manual install simulation (for testing)
bash install.sh
```

## Repository Structure

```
/
├── AI_REPO_GUIDE.md          # This file - canonical AI reference
├── AGENTS.md                 # Root agent instructions (always read first)
├── AGENT.md                  # Deprecated redirect to AGENTS.md
├── README.md                 # User-facing documentation
├── install.sh                # Codespace bootstrap script
├── test.sh                   # Verification script
├── .cursor/
│   └── BUGBOT.md             # Cursor Bugbot PR review rules
├── .gemini/
│   └── styleguide.md         # Gemini Code Assist review style
└── .github/
    ├── copilot-instructions.md   # GitHub Copilot instructions (auto-read)
    ├── agents/
    │   └── judge.agent.md        # Plan-gate + diff-gate reviewer agent
    └── prompts/
        ├── copilot-onboarding.md # Guide for customizing copilot-instructions.md
        └── repo-onboarding.md    # Comprehensive repo onboarding prompt
```

## Key Files by Purpose

### Agent Instructions (read by AI assistants automatically)
| File | Tool/Platform | Purpose |
|------|--------------|---------|
| `AGENTS.md` | Most AI tools | Root instructions, points to this file |
| `.github/copilot-instructions.md` | GitHub Copilot | Copilot-specific instructions |
| `.cursor/BUGBOT.md` | Cursor Bugbot | PR review rules |
| `.gemini/styleguide.md` | Gemini Code Assist | PR review style guide |
| `.github/agents/judge.agent.md` | GitHub Copilot | Plan/diff gate agent |

### Prompts (user-triggered, not auto-loaded)
| File | Purpose |
|------|---------|
| `.github/prompts/copilot-onboarding.md` | Guide for customizing copilot-instructions.md |
| `.github/prompts/repo-onboarding.md` | Comprehensive repo onboarding workflow |

### Setup Scripts
| File | Purpose |
|------|---------|
| `install.sh` | Runs on Codespace start; installs extensions, copies prompts |
| `test.sh` | Verifies template integrity |

## Conventions

### File Naming
- Agent instruction files: `AGENTS.md`, `*.agent.md`, or tool-specific paths
- Prompts: `*.prompt.md` or in `.github/prompts/`
- Style guides: `styleguide.md` in tool-specific directories

### Content Guidelines
- Keep instructions concise (aim for < 2 pages per file)
- Include verification commands where applicable
- Use structured output formats (checklists, tables)
- Reference this file (`AI_REPO_GUIDE.md`) for canonical commands

## Verification Commands

```bash
# Check all required files exist
./test.sh

# Validate shell scripts
shellcheck install.sh test.sh

# List all markdown files in the repository
find . -name "*.md" -exec echo "Found: {}" \;
```

## Using This Template

1. **For new repos**: Copy desired files to your new repository
2. **For Codespaces**: Link this repo in GitHub Codespaces settings
3. **Customize**: Update `install.sh` with your preferred extensions

## Gotchas / Known Issues

- `install.sh` requires the `$DOTFILES` environment variable (set automatically by GitHub Codespaces)
- The `code` command may not be available outside of VS Code/Codespaces environments
- Some AI tools only read files from specific paths (see tool documentation)

## Updating This Guide

When making changes to this template:
1. Update this file if structure/commands/conventions change
2. Run `./test.sh` to verify integrity
3. Update README.md if user-facing behavior changes
