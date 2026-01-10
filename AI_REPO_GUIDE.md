# AI_REPO_GUIDE.md

## Overview
This is a personal dotfiles repository for GitHub Codespaces that automatically configures AI-assisted development environments. It installs VS Code extensions and provides pre-configured AI agent prompts for code review and repository onboarding.

## Tech Stack
- **Platform**: GitHub Codespaces
- **Shell**: Bash
- **Extensions**: VS Code extensions (Cline, Live Preview, Prettier, Live Share)
- **AI Tools**: GitHub Copilot, Cursor AI, Gemini Code Assist

## Repository Structure
```
dotfiles/
├── .github/
│   ├── agents/
│   │   └── judge.agent.md          # GitHub Copilot review agent
│   └── prompts/
│       ├── copilot-onboarding.md   # Copilot onboarding instructions
│       └── repo-onboarding.md      # General repo onboarding prompt
├── .cursor/
│   └── BUGBOT.md                   # Cursor AI review rules
├── .gemini/
│   └── styleguide.md               # Gemini Code Assist review guide
├── install.sh                      # Codespace startup script
├── AGENTS.md                       # Agent working rules
├── AGENT.md                        # Deprecated, kept for compatibility
└── README.md                       # Main documentation
```

## Key Files

### install.sh
- Runs automatically on Codespace startup
- Installs VS Code extensions via `code --install-extension`
- Copies onboarding prompt to workspace

### Review Agents
Three AI code review agents with different configurations:

1. **GitHub Copilot Judge** (`.github/agents/judge.agent.md`)
   - Two modes: PLAN-GATE (before coding) and DIFF-GATE (after coding)
   - Read-only tools: read, search, fetch, githubRepo, usages
   - Outputs: APPROVE / REQUEST_CHANGES / BLOCK

2. **Cursor BUGBOT** (`.cursor/BUGBOT.md`)
   - Strict code review judge
   - Focuses on blockers, build failures, and regressions
   - Priority: Correctness > Tests > Security > Maintainability > Performance

3. **Gemini Code Assist** (`.gemini/styleguide.md`)
   - Merge gate reviewer
   - Severity labels: Critical / High / Medium / Low
   - Similar focus areas as Cursor but different output format

## How to Use

### Setup (One-time)
1. Go to [GitHub Codespaces settings](https://github.com/settings/codespaces)
2. Under "Dotfiles", select this repository
3. Check "Automatically install dotfiles"
4. Future Codespaces will automatically run `install.sh`

### Triggering Code Reviews
See [CODE_REVIEW.md](./CODE_REVIEW.md) for detailed instructions on how to trigger reviews with each AI tool.

## Build/Test Commands
This is a configuration repository with no build or test steps. Changes can be validated by:
1. Creating a new Codespace
2. Verifying extensions are installed
3. Checking that prompt files are copied correctly

## Conventions
- Keep review agent prompts focused and actionable
- All agents should reference AI_REPO_GUIDE.md when it exists
- Maintain consistency in output formats across agents
- Agent files use markdown format with YAML frontmatter (for GitHub Copilot)

## Common Gotchas
- `install.sh` uses `$DOTFILES` environment variable (set by GitHub automatically)
- Extensions install at Codespace startup, not immediately visible in running Codespaces
- Review agents are configuration files, not executable scripts
- AGENT.md is deprecated - use AGENTS.md instead
