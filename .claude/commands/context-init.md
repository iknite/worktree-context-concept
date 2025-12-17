---
description: Initialize context branch methodology on a new or existing repository
allowed-tools: Bash(git:*), Bash(mkdir:*), Bash(ls:*), Write, Edit
argument-hint: [repo-path]
---

# Initialize Context Branch Methodology

Set up the separation of concerns structure for AI context and project code.

## Target
Repository at: `${1:-.}` (current directory if not specified)

## Task
Initialize the context branch methodology:

### Step 1: Check if already initialized
- Look for existing `context` branch
- Check for existing worktree structure

### Step 2: Create orphan context branch (if needed)
```bash
git checkout --orphan context
git reset --hard
git commit --allow-empty -m "init: context branch for AI configuration"
```

### Step 3: Set up context branch structure
Create these files:
- `CLAUDE.md` - Basic project instructions
- `.gitignore` - With `worktree/**/` pattern
- `.claude/` directory for settings

### Step 4: Create worktree directory
```bash
mkdir -p worktree
```

### Step 5: Verify setup
- List branches to confirm `context` exists
- Show the final structure

## Output
Provide clear instructions on next steps:
1. How to create worktrees for development
2. How to switch between context and code
