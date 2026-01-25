# Context Files Explained

> **Purpose**: Understand the different documentation files in this template and when to use each.

## Overview

This template has multiple documentation files that serve different audiences and purposes. This guide explains how they relate.

## File Hierarchy

```
┌─────────────────────────────────────────────────────────────┐
│                    For Humans                                │
│  README.md                                                   │
│  "What is this project? How do I set it up?"                │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    For AI Agents                             │
│  AI_REPO_GUIDE.md                                           │
│  "Quick reference: commands, structure, conventions"        │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                  Context Pack (.context/)                    │
│                                                              │
│  00_INDEX.md ─────── The Map (start here)                   │
│       │                                                      │
│       ├── roadmap.md ─────── The Plan (project phases)      │
│       ├── rules/ ─────────── Constraints (never violate)    │
│       ├── state/ ─────────── Current Work (tasks)           │
│       ├── sessions/ ───────── History (lessons learned)     │
│       └── vision/ ─────────── Design (mockups, diagrams)    │
└─────────────────────────────────────────────────────────────┘
```

## File Comparison

### Project Documentation

| File | Audience | Purpose | Update Frequency |
|------|----------|---------|------------------|
| `README.md` | Humans | Project intro, setup, features, badges | When features change |
| `AI_REPO_GUIDE.md` | Agents | Commands, structure, conventions | When structure changes |
| `docs/**` | Humans | Deep documentation, guides, ADRs | As needed |

**Key Distinction**: README.md can be verbose with images and badges. AI_REPO_GUIDE.md is concise to save tokens.

### Context Pack Files

| File | Question It Answers | Scope | Update Frequency |
|------|---------------------|-------|------------------|
| `00_INDEX.md` | "What's in this context pack?" | Project overview | When context structure changes |
| `roadmap.md` | "What are we building and in what order?" | Project phases | When phases complete/change |
| `rules/*.md` | "What rules must I follow?" | Domain constraints | Rarely |
| `state/task_*.md` | "What am I working on?" | Current tasks | During development |
| `sessions/*.md` | "What happened before?" | Session history | End of each session |
| `vision/**` | "What should this look like?" | Design artifacts | When designs change |

### The Key Distinction: Tasks vs Sessions

| `state/task_*.md` | `sessions/*.md` |
|-------------------|-----------------|
| **What** you're doing | **What happened** and **what you learned** |
| Task-scoped (tracks one task) | Session-scoped (tracks one work session) |
| Progress checklist | Decisions and failures |
| "Continue from step 3" | "Don't try approach X, it failed" |
| May span multiple sessions | Captured at end of each session |

**Example**:
- A task "Implement auth" might take 3 sessions
- `task_auth.md` tracks cumulative progress across all 3
- `sessions/` captures what happened in each individual session

## Subdirectory READMEs

These are NOT redundant with project docs—they explain their specific directories:

| File | Purpose |
|------|---------|
| `.context/state/README.md` | How to create and manage task files |
| `.context/sessions/README.md` | How to create session summaries |
| `scripts/README.md` | Available scripts and usage |
| `config/README.md` | Platform recommendations |
| `docs/README.md` | Documentation structure |

## Reading Order for Agents

1. `AI_REPO_GUIDE.md` — Quick reference
2. `.context/00_INDEX.md` — Project overview
3. `.context/state/` — Find active task(s)
4. `.context/sessions/latest_summary.md` — Recent history
5. Load other files on-demand (rules, vision) as needed

## When to Update Each File

| Event | Files to Update |
|-------|-----------------|
| Project structure changes | `AI_REPO_GUIDE.md`, `README.md` |
| Starting a new task | Create `state/task_<id>.md` |
| Making progress on task | Update `state/task_<id>.md` |
| Ending a coding session | Update `sessions/latest_summary.md` |
| Making a design decision | Add to `sessions/`, optionally create ADR |
| Phase complete | Update `roadmap.md` |
| Adding a domain constraint | Create `rules/domain_<area>.md` |
