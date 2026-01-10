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
├── .github/
│   ├── agents/
│   │   └── judge.agent.md          # GitHub Copilot review agent
│   └── prompts/
│       ├── copilot-onboarding.md   # Instructions for creating copilot-instructions.md
│       └── repo-onboarding.md      # General repo onboarding prompt
├── .cursor/
│   └── BUGBOT.md                   # Cursor AI review rules
├── .gemini/
│   └── styleguide.md               # Gemini Code Assist guide
├── install.sh                      # Auto-runs on Codespace start
├── AI_REPO_GUIDE.md                # Repository memory/guide
├── CODE_REVIEW.md                  # How to trigger code reviews
├── AGENTS.md                       # Agent working rules
└── README.md
```

## 🤖 AI Code Review Agents

This repository includes three AI code review agents for different platforms:

### 1. GitHub Copilot - Judge Agent
**Location**: `.github/agents/judge.agent.md`
- Two modes: **Plan-Gate** (before coding) and **Diff-Gate** (after coding)
- Trigger: `@copilot /judge` in GitHub PRs
- Outputs: `APPROVE` | `REQUEST_CHANGES` | `BLOCK`

### 2. Cursor AI - BUGBOT
**Location**: `.cursor/BUGBOT.md`
- Strict code review judge focused on blockers and regressions
- Trigger: Reference BUGBOT rules in Cursor Chat/Composer
- Outputs: Checklist with blockers, high/medium/low priority items

### 3. Gemini Code Assist
**Location**: `.gemini/styleguide.md`
- Merge gate reviewer with severity labels
- Trigger: Via Cloud Code extension or Gemini API
- Outputs: Findings categorized as Critical/High/Medium/Low

**📖 [See CODE_REVIEW.md for detailed instructions on triggering reviews](./CODE_REVIEW.md)**

## 🤖 AI Onboarding Prompts

### Copilot Onboarding Prompt
**Location**: `.github/prompts/copilot-onboarding.md`

Instructions for creating a `.github/copilot-instructions.md` file in any repository. This one-time task helps Copilot coding agents understand and work more efficiently with a new codebase.

### Repo Onboarding Prompt
**Location**: `.github/prompts/repo-onboarding.md`

A comprehensive prompt that helps AI assistants (like Claude, Cline, etc.) understand and work with any codebase. It guides the AI to:
- Build a mental model of the repository before making changes
- Create/maintain an `AI_REPO_GUIDE.md` for persistent repo memory
- Make minimal, well-tested changes

## 🔧 Setup

1. Go to your [GitHub Codespaces settings](https://github.com/settings/codespaces)
2. Under "Dotfiles", select this repository
3. Check "Automatically install dotfiles"
4. Your next Codespace will automatically run `install.sh`

## 📄 License

Feel free to fork and customize for your own workflow!