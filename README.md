# dotfiles

Personal dotfiles repository for GitHub Codespaces configuration. This repo automatically sets up your development environment with essential VS Code extensions and AI-assisted development prompts.

## 🚀 Features

- **Automatic Extension Installation** - Essential VS Code extensions are installed every time a Codespace starts
- **AI Agent Prompts** - Pre-configured prompts for AI-assisted development workflows
- **Seamless Setup** - Just link this repo to your Codespaces settings and you're ready to go

## 📦 Included Extensions

| Extension | Description |
|-----------|-------------|
| [Cline](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev) | AI coding assistant (formerly Claude Dev) |
| [Live Preview](https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server) | Live server for web development |
| [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) | Code formatter |
| [Live Share](https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare) | Real-time collaborative development |

## 📁 Repository Structure

```
dotfiles/
├── install.sh              # Auto-runs on Codespace start
├── judge.agent.md          # AI agent for plan/diff review
├── onboard-repo.prompt.md  # AI prompt for repo onboarding
└── README.md
```

## 🤖 AI Prompts

### Onboard Repo Prompt
A comprehensive prompt that helps AI assistants understand and work with any codebase. It guides the AI to:
- Build a mental model of the repository before making changes
- Create/maintain an `AI_REPO_GUIDE.md` for persistent repo memory
- Make minimal, well-tested changes

### Judge Agent
A review-only AI agent that operates in two modes:
- **Plan-Gate Mode** - Reviews implementation plans before coding
- **Diff-Gate Mode** - Reviews code changes and PRs

Outputs: `APPROVE` | `REQUEST_CHANGES` | `BLOCK`

## 🔧 Setup

1. Go to your [GitHub Codespaces settings](https://github.com/settings/codespaces)
2. Under "Dotfiles", select this repository
3. Check "Automatically install dotfiles"
4. Your next Codespace will automatically run `install.sh`

## 📄 License

Feel free to fork and customize for your own workflow!