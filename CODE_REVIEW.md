# Code Review Trigger Guide

This document explains how to trigger code reviews using the three AI review agents configured in this repository: **GitHub Copilot (judge)**, **Cursor AI (BUGBOT)**, and **Gemini Code Assist**.

## Table of Contents
- [GitHub Copilot - Judge Agent](#github-copilot---judge-agent)
- [Cursor AI - BUGBOT](#cursor-ai---bugbot)
- [Gemini Code Assist](#gemini-code-assist)
- [Comparison Chart](#comparison-chart)

---

## GitHub Copilot - Judge Agent

**Location**: `.github/agents/judge.agent.md`

### Prerequisites
- GitHub Copilot subscription
- VS Code or GitHub.com with Copilot enabled
- Repository with this dotfiles configuration

### How to Trigger

#### Method 1: Via GitHub Pull Request (Recommended)
1. Create a pull request in your repository
2. In the PR comment section, type: `@copilot /judge`
3. Copilot will automatically detect the mode:
   - **PLAN-GATE mode**: If you paste an implementation plan (no diff markers)
   - **DIFF-GATE mode**: If PR contains code changes (diffs)
4. The judge agent will review and respond with:
   - `APPROVE` / `REQUEST_CHANGES` / `BLOCK`
   - Detailed feedback based on the mode

#### Method 2: Via VS Code Copilot Chat
1. Open VS Code with Copilot enabled
2. Open the Copilot Chat panel
3. Reference the judge agent: `@judge` or `@workspace /judge`
4. Paste your plan or diff for review
5. The agent will review according to its configured rules

#### Method 3: Manual Invocation
1. Copy the judge agent prompt from `.github/agents/judge.agent.md`
2. In Copilot Chat, paste the prompt followed by your plan/diff
3. Request review

### What the Judge Reviews

**PLAN-GATE mode** (before coding):
- Scope & correctness
- Repo fit & architectural patterns
- Risk management & breaking changes
- Test strategy
- Operational concerns
- Effort control & splitting opportunities

**DIFF-GATE mode** (after coding):
- Correctness vs acceptance criteria
- Repo conventions & consistency
- Test coverage & quality
- Security (secrets, auth, validation, injection)
- Performance & reliability
- Compatibility & migrations
- Documentation updates

### Expected Output Format
```
DECISION: APPROVE | REQUEST_CHANGES | BLOCK
SUMMARY: ...
MAJOR ISSUES:
- ...
MINOR ISSUES:
- ...
VALIDATION:
- Commands to run
```

---

## Cursor AI - BUGBOT

**Location**: `.cursor/BUGBOT.md`

### Prerequisites
- Cursor IDE (download from [cursor.sh](https://cursor.sh))
- This dotfiles repository linked or rules copied to project

### How to Trigger

#### Method 1: Via Cursor Composer/Chat
1. Open your project in Cursor IDE
2. Open the Cursor Chat (Cmd/Ctrl + L) or Composer (Cmd/Ctrl + I)
3. Add context by referencing: `@Codebase` or specific files
4. Type: "Review this PR/diff according to BUGBOT rules" or "@BUGBOT review"
5. Paste your diff or reference files to review
6. Cursor will apply the rules from `.cursor/BUGBOT.md`

#### Method 2: Via Cursor Agent Mode
1. In Cursor, open Agent mode
2. Reference the BUGBOT rules: `Use .cursor/BUGBOT.md rules to review my changes`
3. Provide context (files, diff, or description)
4. The agent will perform review based on BUGBOT criteria

#### Method 3: Via PR Review Request
1. Create a pull request
2. In PR description or comment, mention: "Review using Cursor BUGBOT rules"
3. Use Cursor IDE to open the PR
4. Run Cursor agent review with BUGBOT context

### What BUGBOT Reviews (Priority Order)
1. **Correctness & regressions**: Edge cases, null handling, backward compatibility
2. **Tests & verification**: Required tests, verification commands
3. **Security & privacy**: Secrets, injection, auth/authz, data exposure
4. **Maintainability**: Naming, complexity, duplication, error handling
5. **Performance**: N+1 queries, big-O issues, network calls

### Expected Output Format
```
### Summary
1-3 sentences

### Blockers (must fix)
- [ ] Item — file:line — why — fix — verify

### High priority (should fix)
- [ ] Item — file:line — fix

### Medium / Low
- [ ] Item — file:line — suggestion

### Verification checklist
- Command 1
- Command 2
```

---

## Gemini Code Assist

**Location**: `.gemini/styleguide.md`

### Prerequisites
- Google Cloud Project with Gemini Code Assist enabled
- Cloud Code extension in VS Code or JetBrains IDE
- Or: Gemini API access

### How to Trigger

#### Method 1: Via Cloud Code in VS Code
1. Install "Cloud Code" extension in VS Code
2. Sign in to Google Cloud
3. Enable Gemini Code Assist
4. Open the Gemini panel
5. Reference the style guide: `Use .gemini/styleguide.md to review my changes`
6. Provide the diff or file references
7. Request review

#### Method 2: Via Gemini in Google Cloud Console
1. Go to Google Cloud Console
2. Navigate to "Code Assist" or "Duet AI"
3. Upload or reference your code/diff
4. Include instruction: "Review according to the style guide at .gemini/styleguide.md"
5. Request review

#### Method 3: Via API/CLI
1. Use Google Cloud CLI with Gemini API
2. Include the style guide content as system instructions
3. Submit code for review programmatically

Example using gcloud:
```bash
gcloud ai code-assist review \
  --instructions-file=.gemini/styleguide.md \
  --diff-file=my-changes.diff
```

### What Gemini Reviews (Priority Order)
1. **Correctness & regressions**: Logic errors, edge cases, compatibility
2. **Tests & verification**: Test requirements, commands from AI_REPO_GUIDE.md
3. **Security & privacy**: Secrets, unsafe input, injection, auth/authz
4. **Maintainability & architecture**: Small diffs, consistency, layering
5. **Performance & reliability**: N+1, allocations, timeouts/retries

### Expected Output Format
```
### Overall assessment
One paragraph summary

### Findings
- **Critical**
  - Item — file:line — why — fix — verification
- **High**
  - ...
- **Medium**
  - ...
- **Low**
  - ...

### Verification checklist
- Command 1 with expected outcome
- Command 2 with expected outcome
```

---

## Comparison Chart

| Feature | GitHub Copilot (Judge) | Cursor AI (BUGBOT) | Gemini Code Assist |
|---------|----------------------|-------------------|-------------------|
| **Location** | `.github/agents/judge.agent.md` | `.cursor/BUGBOT.md` | `.gemini/styleguide.md` |
| **Primary Use** | GitHub PRs & VS Code | Cursor IDE | Cloud Code / API |
| **Modes** | Plan-gate & Diff-gate | Single review mode | Single review mode |
| **Trigger** | `@copilot /judge` | Chat with BUGBOT context | Cloud Code panel |
| **Output** | APPROVE/REQUEST_CHANGES/BLOCK | Checklist with severity | Severity-labeled findings |
| **Best For** | GitHub-native workflows | Cursor IDE users | Google Cloud users |
| **Plan Reviews** | ✅ Yes (PLAN-GATE) | ❌ No | ❌ No |
| **Diff Reviews** | ✅ Yes (DIFF-GATE) | ✅ Yes | ✅ Yes |

---

## Best Practices

1. **Use the Right Tool for Your Workflow**
   - Working in GitHub? Use Copilot Judge
   - Using Cursor IDE? Use BUGBOT
   - Google Cloud environment? Use Gemini

2. **Review Both Plans and Code**
   - Use Copilot Judge's PLAN-GATE before implementing
   - Use any agent's diff review after implementation

3. **Maintain AI_REPO_GUIDE.md**
   - All agents reference it for build/test commands
   - Keep it updated with your repo's truth

4. **Combine Multiple Reviews**
   - Different agents may catch different issues
   - Use 2-3 agents for critical changes

5. **Provide Context**
   - Reference the style guide/rules explicitly
   - Include relevant files and diffs
   - Mention what you want reviewed

6. **Act on Feedback**
   - Address blockers/critical issues first
   - Document decisions for non-critical items
   - Re-run reviews after significant changes

---

## Troubleshooting

### GitHub Copilot Judge Not Responding
- Verify Copilot subscription is active
- Check that `.github/agents/judge.agent.md` exists
- Try `@copilot` without `/judge` to test connection
- Ensure PR has changes to review

### Cursor BUGBOT Not Using Rules
- Verify `.cursor/BUGBOT.md` exists in project
- Explicitly reference: "Use rules from .cursor/BUGBOT.md"
- Check Cursor IDE settings for agent configuration
- Try adding @Codebase for context

### Gemini Not Following Style Guide
- Explicitly mention: "Follow .gemini/styleguide.md"
- Check Cloud Code extension is configured
- Verify Gemini Code Assist is enabled in GCP project
- Include the style guide content in your prompt

---

## Additional Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Cursor IDE Documentation](https://cursor.sh/docs)
- [Gemini Code Assist Documentation](https://cloud.google.com/code-assist/docs)
- Repository: [AI_REPO_GUIDE.md](./AI_REPO_GUIDE.md)
