---
description: Create a new worktree branch from master inside worktree/ folder
allowed-tools: Bash(git worktree:*), Bash(git branch:*), Bash(git symbolic-ref:*), Bash(ls:*)
argument-hint: <branch-name> [base-branch]
---

# Create New Worktree

Create a new git worktree for branch `$1`.

## Detect default branch
!`git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || (git branch -l main master 2>/dev/null | head -1 | tr -d '* ')`

## Current worktrees
!`git worktree list`

## Rules
1. All worktrees MUST be created inside the `worktree/` folder
2. Branch names should follow the pattern: `feature/`, `fix/`, `chore/`, etc.
3. If no base branch is specified, use the repository's default branch (main or master)

## Task

### Step 1: Determine the base branch
- If `$2` is provided, use it as the base branch
- Otherwise, detect the default branch using:
  ```bash
  git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git branch -l main master 2>/dev/null | head -1 | tr -d '* '
  ```

### Step 2: Create the worktree
For a new branch:
```bash
git worktree add -b $1 worktree/$1 <base-branch>
```

If the branch already exists:
```bash
git worktree add worktree/$1 $1
```

### Step 3: Verify
After creation, confirm the worktree was created successfully by listing all worktrees.
