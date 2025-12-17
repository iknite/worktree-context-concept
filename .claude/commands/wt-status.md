---
description: Show status of all worktrees including pending commits and sync state
allowed-tools: Bash(git:*), Bash(ls:*)
---

# Worktree Status

Show the status of all worktrees: context, default branch, and feature branches.

## All worktrees
!`git worktree list`

## Task

Generate a comprehensive status report for all worktrees:

### Step 1: Detect default branch
```bash
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || git branch -l main master 2>/dev/null | head -1 | tr -d '* ')
```

### Step 2: For each worktree, check:

1. **Context branch** (`root/context` or current context location):
   ```bash
   git -C <context-path> status --short
   git -C <context-path> log origin/context..HEAD --oneline 2>/dev/null || echo "No remote tracking"
   ```

2. **Default branch** (`root/$DEFAULT_BRANCH`):
   ```bash
   git -C <default-branch-path> status --short
   git -C <default-branch-path> log origin/$DEFAULT_BRANCH..HEAD --oneline 2>/dev/null
   ```

3. **All feature worktrees** (inside `worktree/`):
   ```bash
   for dir in worktree/*/*; do
     if [ -d "$dir" ]; then
       echo "=== $dir ==="
       git -C "$dir" status --short
       git -C "$dir" log origin/$(git -C "$dir" branch --show-current)..HEAD --oneline 2>/dev/null || echo "No remote tracking"
     fi
   done
   ```

### Step 3: Format output as a table

For each worktree, report:
| Worktree | Branch | Uncommitted | Unpushed | Behind Remote |
|----------|--------|-------------|----------|---------------|

Where:
- **Uncommitted**: Number of modified/untracked files
- **Unpushed**: Commits ahead of remote
- **Behind Remote**: Commits behind remote (needs pull)

### Step 4: Summary

Provide a quick summary:
- Total worktrees
- Worktrees with uncommitted changes
- Worktrees with unpushed commits
- Worktrees that need pulling

Flag any worktrees that need attention.
