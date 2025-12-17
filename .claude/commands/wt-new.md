---
description: Create a new worktree branch from master inside worktree/ folder
allowed-tools: Bash(git worktree:*), Bash(git branch:*), Bash(ls:*)
argument-hint: <branch-name> [base-branch]
---

# Create New Worktree

Create a new git worktree for branch `$1` based on `${2:-master}`.

## Current worktrees
!`git worktree list`

## Rules
1. All worktrees MUST be created inside the `worktree/` folder
2. Branch names should follow the pattern: `feature/`, `fix/`, `chore/`, etc.
3. Base branch defaults to `master` if not specified

## Task
Create the worktree with this command structure:
```bash
git worktree add -b $1 worktree/$1 ${2:-master}
```

If the branch already exists (without -b):
```bash
git worktree add worktree/$1 $1
```

After creation, confirm the worktree was created successfully by listing all worktrees.
