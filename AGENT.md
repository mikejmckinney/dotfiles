# AGENT.md

## Required context (read first)
1) Always read `./AI_REPO_GUIDE.md` before planning or making changes.
2) Treat it as the canonical “repo memory” for:
   - architecture map / key flows
   - where to make changes
   - golden path commands (build/test/lint)
   - conventions + gotchas

If `AI_REPO_GUIDE.md` is missing or stale:
- Create/update it as the first step.
- Prefer repo truth (actual scripts/configs) over guesses; document corrections in `AI_REPO_GUIDE.md`.

## Working rules
- Minimize diffs; follow existing patterns.
- Verify with the repo’s documented commands (see `AI_REPO_GUIDE.md`).
- If instructions conflict, call it out and propose a resolution.
