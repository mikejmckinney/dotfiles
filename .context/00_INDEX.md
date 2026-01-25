<!-- TEMPLATE_PLACEHOLDER: Replace with actual project context index -->

# Context Pack Index

> **Purpose**: This is the entry point for AI agents to understand the project's direction, constraints, and current state.

## How to Use This Directory

The `.context/` directory contains **canonical project truth**. 

### Priority Order (when conflicts arise)
1. `.context/**` takes precedence over `/docs/**` (highest priority)
2. `/docs/**` takes precedence over code comments
3. Code comments take precedence over inferred behavior

## Directory Structure

```
.context/
├── 00_INDEX.md          # This file - start here (The Map)
├── roadmap.md           # Phase-by-phase plan with acceptance criteria (The Plan)
├── rules/               # Immutable constraints and domain rules
│   └── domain_*.md      # Domain-specific rules (e.g., domain_auth.md)
├── sessions/            # Session history to prevent repeating mistakes
│   └── latest_summary.md # Most recent session summary
├── state/               # Mutable progress tracking
│   └── active_task.md   # Current task being worked on (The Cursor)
└── vision/              # Design artifacts (mockups, diagrams)
    ├── mockups/         # UI/UX mockups and wireframes
    └── architecture/    # System architecture diagrams (use Mermaid.js)
```

## Quick Start for Agents (Lazy Load Pattern)

1. Read this file first (The Map)
2. Check `state/active_task.md` for current work (The Cursor)
3. Read `sessions/latest_summary.md` for what happened last session
4. Read `roadmap.md` to understand project phases (The Plan)
5. Reference `rules/` ONLY when making changes to those domains
6. Reference `vision/` for design guidance

**Note:** Don't read everything at once. This index tells you what exists; load files on-demand to save tokens.

## Project Summary

<!-- Replace this section with actual project summary -->

**Project Name**: [TBD]  
**Description**: [TBD]  
**Current Phase**: [TBD]  
**Tech Stack**: [TBD]

## Key Decisions Log

| Date | Decision | Rationale | Files Affected |
|------|----------|-----------|----------------|
| YYYY-MM-DD | Example decision | Why it was made | `path/to/file` |

## Next Steps

- [ ] Replace this placeholder with actual project context
- [ ] Define roadmap phases
- [ ] Add domain rules
- [ ] Add initial design mockups if available
