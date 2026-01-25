# Agent Best Practices

> **Purpose**: Guidance for working effectively with AI coding agents, including known limitations and mitigations.

## Token Limits and Context Management

### The Problem

AI models have limited context windows (measured in tokens). Large codebases or verbose documentation can exceed these limits, causing:
- Truncated context (agent misses important information)
- Degraded performance (too much irrelevant context)
- Higher costs (more tokens = more cost)

### Mitigations

#### 1. Keep Individual Files Small

| File Type | Target Size | Maximum |
|-----------|-------------|---------|
| Context files (`.context/`) | < 200 lines | 500 lines |
| Documentation | < 300 lines | 1000 lines |
| Code files | < 400 lines | 800 lines |

If a file exceeds these limits, split it:
```
# Instead of one large file:
context/rules.md (800 lines)

# Split into focused files:
context/rules/domain_auth.md (150 lines)
context/rules/domain_data.md (200 lines)
context/rules/domain_api.md (180 lines)
```

#### 2. Use Clear File Names

Agents can selectively load files based on names. Use descriptive names:

```
# Good - agent knows what to load
.context/rules/domain_authentication.md
.context/state/active_task_user_registration.md

# Bad - agent must read to understand
.context/rules/misc.md
.context/state/current.md
```

#### 3. Provide a Context Summary

For large projects, create a summary file that agents can read first:

```markdown
# .context/SUMMARY.md

## Quick Reference
- Auth: See rules/domain_auth.md
- API: See rules/domain_api.md
- Current task: Implementing user registration
- Blocked by: Waiting for design review

## What to Read
1. This file (you're here)
2. state/active_task.md (current work)
3. Only load rules/* files when making changes to those domains
```

#### 4. Use the Priority Hierarchy

Don't duplicate information across files. Reference instead:

```markdown
# Good - reference, don't duplicate
See .context/rules/domain_auth.md for authentication requirements.

# Bad - duplicated content that may get out of sync
Authentication must use bcrypt with cost factor 12...
(same content copied to multiple files)
```

---

## State File Conflict Prevention

### The Problem

If multiple agents work simultaneously (or a human and agent), `.context/state/active_task.md` can have merge conflicts.

### Mitigations

#### 1. One Active Task at a Time

The simplest solution: only one task should be in progress at once. Complete the current task before starting a new one.

#### 2. Multiple Task Files (for parallel work)

If you need parallel task tracking, use separate files:

```
.context/state/
├── active_task.md           # Summary/index
├── task_feature_auth.md     # Task 1 details
├── task_bugfix_api.md       # Task 2 details
└── task_refactor_ui.md      # Task 3 details
```

#### 3. Lock Before Working

Add a simple lock mechanism:

```markdown
# active_task.md

## Lock Status
**Locked By**: agent-cursor-session-abc123
**Locked At**: 2025-01-25T14:30:00Z
**Expected Duration**: 30 minutes

## Current Task
...
```

Agents should check the lock before modifying.

#### 4. Use Git Branches

For significant parallel work, use feature branches. Each branch has its own state:

```bash
# Branch: feature/user-auth
.context/state/active_task.md  # Auth work

# Branch: feature/api-refactor  
.context/state/active_task.md  # API work
```

Merge conflicts only occur when branches merge.

---

## Workflow Secrets Configuration

### Required Secrets

The CI workflows in this template require these GitHub repository secrets:

| Secret | Required By | How to Get It |
|--------|-------------|---------------|
| `BACKEND_URL` | `keep-warm.yml`, `validate-connections.yml` | Your deployed backend URL (e.g., `https://myapp.onrender.com`) |
| `DATABASE_URL` | Optional for `validate-connections.yml` | Connection string from your database provider |

### How to Set Secrets

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:
   - Name: `BACKEND_URL`
   - Value: `https://your-backend-url.com`
5. Click **Add secret**

### Optional Secrets for Deployment

If you add deployment workflows, you may need:

| Secret | Purpose | Where to Get |
|--------|---------|--------------|
| `VERCEL_TOKEN` | Vercel deployments | [Vercel Dashboard](https://vercel.com/account/tokens) |
| `VERCEL_ORG_ID` | Vercel org identifier | Vercel project settings |
| `VERCEL_PROJECT_ID` | Vercel project identifier | Vercel project settings |
| `RAILWAY_TOKEN` | Railway deployments | [Railway Dashboard](https://railway.app/account/tokens) |
| `RENDER_API_KEY` | Render deployments | [Render Dashboard](https://dashboard.render.com/u/settings) |

### Secrets Best Practices

1. **Never commit secrets** to the repository
2. **Use environment-specific secrets** (different values for staging vs. production)
3. **Rotate secrets regularly** (especially after team member departures)
4. **Use secret scanning** (pre-commit hooks or GitHub's built-in scanning)
5. **Limit access** (only give secrets to workflows that need them)

---

## Session Handoff Protocol

When an agent session ends (or a new agent takes over), follow this protocol:

### Ending a Session

1. **Update `active_task.md`** with:
   - What was accomplished
   - What's left to do
   - Any blockers or open questions
   - Files that were modified

2. **Commit work in progress**:
   ```bash
   git add .
   git commit -m "WIP: [task description] - session handoff"
   ```

3. **Leave clear next steps**:
   ```markdown
   ## Next Session Should
   1. Run tests to verify current state: `npm test`
   2. Continue with step 3 of implementation plan
   3. Address the TODO in src/auth.ts:42
   ```

### Starting a Session

1. **Read context in order**:
   1. `AGENTS.md` (instructions)
   2. `AI_REPO_GUIDE.md` (quick reference)
   3. `.context/00_INDEX.md` (project overview)
   4. `.context/state/active_task.md` (current work)

2. **Verify state**:
   ```bash
   git status
   ./test.sh  # or npm test
   ```

3. **Acknowledge handoff**:
   Update `active_task.md` with your session start.

---

## Common Pitfalls

### 1. Assuming Instead of Verifying

**Wrong**: "The API probably uses REST"
**Right**: Check `AI_REPO_GUIDE.md` or search for API patterns in the codebase

### 2. Making Sweeping Changes

**Wrong**: "Let me refactor the entire auth system while fixing this bug"
**Right**: Make minimal, focused changes. Create separate tasks for refactoring.

### 3. Ignoring CI Failures

**Wrong**: Mark task complete even though CI is red
**Right**: Read CI logs, fix issues, verify green before completing

### 4. Not Updating Documentation

**Wrong**: Change behavior without updating docs
**Right**: Update `AI_REPO_GUIDE.md` if commands, structure, or conventions change

### 5. Duplicating Context

**Wrong**: Copy the same information to multiple files
**Right**: Put it in one authoritative place and reference it elsewhere
