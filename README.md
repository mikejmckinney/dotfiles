<!-- TEMPLATE_PLACEHOLDER: GENERATED FROM mikejmckinney/dotfiles. -->
<!-- THIS REPO IS NOT THE TEMPLATE ITSELF. Replace this README for the actual project. -->

# AI-Ready Repository Template

A template repository for GitHub Codespaces that provides pre-configured AI agent prompts and automatic development environment setup. Use this as a starting point for new repositories or link it to your Codespaces settings.

## 🚀 Features

- **AI Agent Prompts** - Pre-configured prompts for onboarding AI assistants to any codebase
- **Automatic Extension Installation** - Essential VS Code extensions installed on Codespace start
- **Multi-Platform Support** - Works with Cursor, GitHub Copilot, Gemini Code Assist, and more
- **Verification Scripts** - Built-in testing to ensure template integrity

## 📁 Repository Structure

```
/
├── AI_REPO_GUIDE.md              # Canonical AI reference (create in target repos)
├── AGENTS.md                     # Root agent instructions
├── AGENT.md                      # Deprecated redirect
├── README.md                     # This file
├── install.sh                    # Codespace bootstrap script
├── test.sh                       # Template verification script
│
├── .cursor/
│   └── BUGBOT.md                 # Cursor Bugbot PR review rules
│
├── .gemini/
│   └── styleguide.md             # Gemini Code Assist style guide
│
└── .github/
    ├── copilot-instructions.md   # GitHub Copilot instructions (auto-read)
    ├── agents/
    │   └── judge.agent.md        # GitHub Copilot plan/diff gate agent
    └── prompts/
        ├── copilot-onboarding.md # Guide for customizing copilot-instructions.md
        └── repo-onboarding.md    # Comprehensive repo onboarding prompt
```

## 🤖 AI Agent Files

### Agent Instructions (auto-loaded by AI tools)

| File | Platform | Purpose |
|------|----------|---------|
| `AGENTS.md` | Most AI tools | Root instructions, references AI_REPO_GUIDE.md |
| `.github/copilot-instructions.md` | GitHub Copilot | Copilot-specific instructions |
| `.cursor/BUGBOT.md` | Cursor Bugbot | Strict PR review rules with verification |
| `.gemini/styleguide.md` | Gemini Code Assist | PR review with severity labels |
| `.github/agents/judge.agent.md` | GitHub Copilot | Plan-gate + diff-gate reviewer |

### Prompts (user-triggered)

| File | Purpose |
|------|---------|
| `.github/prompts/copilot-onboarding.md` | Guide for customizing copilot-instructions.md |
| `.github/prompts/repo-onboarding.md` | Comprehensive onboarding workflow |

## 📦 Included VS Code Extensions

| Extension | Description |
|-----------|-------------|
| [Cline](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev) | AI coding assistant |
| [Live Preview](https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server) | Live server for web development |
| [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) | Code formatter |
| [Live Share](https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare) | Real-time collaborative development |

## 🔧 Setup

### Option 1: Use as Codespaces Dotfiles

1. Go to [GitHub Codespaces settings](https://github.com/settings/codespaces)
2. Under "Dotfiles", select this repository
3. Check "Automatically install dotfiles"
4. Your next Codespace will automatically run `install.sh`

### Option 2: Copy to New Repository

1. Clone this repository
2. Copy desired files to your new project
3. Customize `install.sh` with your preferred extensions
4. Create an `AI_REPO_GUIDE.md` specific to your project

## ✅ Verification

Run the verification script to ensure all template files are present and valid:

```bash
./test.sh
```

Expected output:
```
========================================
Template Repository Verification
========================================

Checking required files...
✓ AI_REPO_GUIDE.md exists
✓ AGENTS.md exists
...

========================================
Summary
========================================
Passed: 15
Warnings: 0
Failed: 0

Template verification PASSED
```

## 🧪 Testing Your Setup

### Manual Verification

```bash
# Check all files exist
ls -la AI_REPO_GUIDE.md AGENTS.md install.sh test.sh

# Validate shell script syntax
bash -n install.sh
bash -n test.sh

# Run the test suite
./test.sh

# Test install script (safe to run locally)
bash install.sh
```

### In a Codespace

1. Create a new Codespace with this as your dotfiles repo
2. Check that extensions are installed: `code --list-extensions`
3. Verify prompts are copied to workspace

## 📝 Customization

### Adding Extensions

Edit `install.sh` to add more extensions:

```bash
EXTENSIONS=(
    "your.extension-id"
    # ... existing extensions
)
```

### Adding Prompts

1. Create new prompt files in `.github/prompts/`
2. Update `install.sh` to copy them if needed
3. Update `test.sh` to verify them

### Platform-Specific Files

- **Cursor**: Add files to `.cursor/`
- **Gemini**: Add files to `.gemini/`
- **GitHub Copilot**: Add files to `.github/agents/` or `.github/prompts/`

## 📋 Best Practices

When using this template in a new repository:

1. **Create AI_REPO_GUIDE.md** - Document your project's specific structure, commands, and conventions
2. **Keep AGENTS.md minimal** - It should just point to AI_REPO_GUIDE.md
3. **Update prompts** - Customize prompts for your project's needs
4. **Run tests** - Use `./test.sh` to verify your customizations

## 📄 License

MIT - Feel free to fork and customize for your own workflow!
