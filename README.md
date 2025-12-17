# Worktree Context Plugin for Claude Code

A Claude Code plugin that enforces **separation of concerns** between AI configuration and project source code using git worktrees.

## Quick Start

```bash
# Create a new feature worktree
/wt-new feature/my-feature

# List all worktrees
/wt-list

# Create a PR from your feature
/wt-pr feature/my-feature

# Remove a completed worktree
/wt-remove feature/my-feature --delete-branch
```

## The Problem

When using AI coding assistants like Claude Code, projects accumulate:
- `CLAUDE.md` files with instructions
- `.claude/` directories with settings and configurations
- Custom slash commands and hooks

These files clutter project history and mix AI tooling concerns with source code.

## The Solution: Context Branch Methodology

This plugin enforces a clean separation using **two independent git histories**:

```
bare-repo/
├── root/
│   ├── context/              # context branch (AI configuration)
│   │   ├── CLAUDE.md         # Project instructions for Claude
│   │   ├── .claude/          # Claude Code settings
│   │   │   ├── commands/     # Slash commands
│   │   │   ├── agents/       # Subagents
│   │   │   └── skills/       # Agent skills
│   │   ├── .gitignore        # Ignores worktree/**/
│   │   └── worktree/         # All project worktrees live here
│   │       └── feature/
│   │           └── my-feature/  # Actual code (from master lineage)
│   └── master/               # master branch (optional direct access)
```

**Key insight**: The `context` branch ignores `worktree/**/`, so nested code worktrees don't pollute AI config history.

### Key Concepts

| Branch | Purpose | History |
|--------|---------|---------|
| `context` | AI context, CLAUDE.md, .claude/ settings | Independent orphan branch |
| `master` | Project source code | Normal project history |
| `feature/*` | Feature branches | Descendants of master |

## Installation

### Option 1: Initialize a new repository

```bash
# Clone your repo as bare
git clone --bare git@github.com:user/repo.git my-project
cd my-project

# Create root directory structure
mkdir -p root

# Create worktree for default branch (main or master)
git worktree add root/master master  # or root/main main

# Create orphan context branch
git checkout --orphan context
git reset --hard
git commit --allow-empty -m "init: context branch for AI configuration"

# Create context worktree
git worktree add root/context context

# Set up context structure
cd root/context
mkdir -p worktree .claude/{commands,agents,skills}
echo 'worktree/**/' > .gitignore

# Copy plugin files (from this repo or download)
# cp -r <plugin-source>/.claude/* .claude/

git add .
git commit -m "init: add context branch plugin"
```

### Option 2: Add to existing context branch

If you already have the context branch methodology set up:

```bash
cd root/context
cp -r <plugin-source>/.claude/* .claude/
git add .claude/
git commit -m "feat: add worktree context plugin"
```

### Option 3: Use /context-init command

If you have Claude Code running with this plugin already installed elsewhere:

```bash
/context-init /path/to/your/repo
```

### Verify installation

After installation, these commands should be available:
```bash
/wt-list      # List all worktrees
/wt-status    # Show status of all worktrees
/wt-new       # Create new worktree
```

## Commands

| Command | Description |
|---------|-------------|
| `/wt-new <branch> [base]` | Create a new worktree from base (default: main/master) |
| `/wt-list` | List all worktrees |
| `/wt-status` | Show status of all worktrees (uncommitted, unpushed, behind) |
| `/wt-remove <branch> [-d]` | Remove worktree, optionally delete branch |
| `/wt-pr <branch> [base]` | Create GitHub PR for a worktree branch |
| `/context-init [path]` | Initialize methodology on a repo |

## Components

### Slash Commands (`.claude/commands/`)
User-invoked commands for explicit worktree operations.

### Hooks (`.claude/settings.json`)
Automatic guardrails that:
- Block direct edits to `root/master/`
- Remind about PR workflow on commit-related prompts

### Subagent (`.claude/agents/worktree-manager.md`)
Specialized agent for complex operations:
- Bulk worktree cleanup
- Migration to methodology
- Troubleshooting worktree issues

### Skill (`.claude/skills/context-methodology/`)
Knowledge base that Claude discovers automatically when you ask about:
- Worktree structure
- Branch organization
- The separation of concerns pattern

## Workflow Example

```bash
# 1. Start from context worktree
cd root/context

# 2. Create feature worktree
/wt-new feature/user-auth

# 3. Work on your feature
cd worktree/feature/user-auth
# ... make changes ...

# 4. Commit your work
git add . && git commit -m "feat: add user authentication"

# 5. Create PR (from context worktree)
cd ../..  # back to context
/wt-pr feature/user-auth

# 6. After merge, cleanup
/wt-remove feature/user-auth --delete-branch
```

## Rules Enforced

1. **No direct master edits** - Hooks block edits to `root/master/`
2. **Worktrees in `worktree/`** - Commands create worktrees in the right place
3. **PRs for all changes** - PR command encourages proper workflow
4. **Feature branches from master** - Commands default to master as base

## Plugin Features

- [x] Initialize context branch methodology on existing repos
- [x] Automatically create worktrees with proper structure
- [x] Validate worktree hierarchy (via hooks)
- [x] PR workflow integration
- [x] Clean up merged worktrees

## Troubleshooting

**Worktree already exists for branch**
```bash
# Use existing branch without -b flag
git worktree add worktree/feature/name feature/name
```

**Broken worktree reference**
```bash
git worktree prune
```

**Need complex worktree operations**
Ask Claude to use the `worktree-manager` agent for bulk operations or migrations.

---
with <3 @iknite
