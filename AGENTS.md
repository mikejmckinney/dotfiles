# AGENTS.md

## Template detection (important)
- Determine the current repository name (e.g., via `git remote -v` or folder name).
- If the repo is named `dotfiles` (or `mikejmckinney/dotfiles`):
  - Treat README.md and AI_REPO_GUIDE.md as the template’s docs; do NOT regenerate/overwrite them.
- Otherwise:
  - If README.md or AI_REPO_GUIDE.md contains `TEMPLATE_PLACEHOLDER`, treat them as stubs:
    replace README.md with project-specific README, and regenerate AI_REPO_GUIDE.md from the repo’s real assets (./.context/**, ./docs/**, source).

## Onboarding procedure
- Read `/AI_REPO_GUIDE.md`.
- If missing or stale: follow `.github/prompts/repo-onboarding.md` to rebuild context and update AI_REPO_GUIDE.md.

## Ongoing maintenance
- If your PR changes build/run/test/lint commands, layout, entry points, configs, conventions, or troubleshooting:
  update `/AI_REPO_GUIDE.md` in the same PR (or explicitly say "AI_REPO_GUIDE.md: no changes required").

## Validation
- Run the repo's verification commands (prefer those documented in AI_REPO_GUIDE.md) before declaring done.

## Review guidelines
- Block on failing CI/tests or missing test coverage for changed behavior.
- Require exact repro/verification commands for any functional change.
- Prefer minimal diffs; avoid drive-by refactors.
- No secrets/PII in logs.
- Call out risk areas: authz, data migrations, concurrency, perf regressions.
