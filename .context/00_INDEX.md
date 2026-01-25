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
├── 00_INDEX.md          # This file - start here
├── roadmap.md           # Phase-by-phase plan with acceptance criteria
├── rules/               # Immutable constraints and domain rules
│   └── domain_*.md      # Domain-specific rules (e.g., domain_auth.md)
├── state/               # Mutable progress tracking
│   └── active_task.md   # Current task being worked on
└── vision/              # Design artifacts (mockups, diagrams)
    ├── mockups/         # UI/UX mockups and wireframes
    └── architecture/    # System architecture diagrams
```

## Quick Start for Agents

1. Read this file first
2. Read `roadmap.md` to understand project phases
3. Check `state/active_task.md` for current work
4. Reference `rules/` for constraints that must not be violated
5. Reference `vision/` for design guidance

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
