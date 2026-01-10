# AGENTS.md

## Always do this first
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
