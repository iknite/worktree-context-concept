---
description: Create a GitHub PR from a worktree branch
allowed-tools: Bash(git:*), Bash(gh:*)
argument-hint: <branch-name> [base-branch]
---

# Create PR from Worktree

Create a GitHub Pull Request for branch `$1`.

## Detect default branch
!`git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || (git branch -l main master 2>/dev/null | head -1 | tr -d '* ')`

## Current status of the branch
!`cd worktree/$1 2>/dev/null && git status || echo "Worktree not found at worktree/$1"`

## Recent commits on this branch
!`cd worktree/$1 2>/dev/null && git log --oneline -5 || echo ""`

## Task

### Step 1: Determine the base branch
- If `$2` is provided, use it as the PR base
- Otherwise, detect the default branch (main or master) using:
  ```bash
  git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git branch -l main master 2>/dev/null | head -1 | tr -d '* '
  ```

### Step 2: Navigate to the worktree
```bash
cd worktree/$1
```

### Step 3: Check for uncommitted changes
If any uncommitted changes exist, ask user what to do.

### Step 4: Push the branch
```bash
git push -u origin $1
```

### Step 5: Create the PR
```bash
gh pr create --base <detected-base-branch> --title "..." --body "..."
```
- Title: derive from branch name or recent commits
- Body: summarize changes with a test plan

## PR Body Template
```
## Summary
<bullet points of changes>

## Test plan
<how to verify the changes>

---
Generated with [Claude Code](https://claude.ai/code)
```
