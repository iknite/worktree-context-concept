---
description: Remove a worktree and optionally delete its branch
allowed-tools: Bash(git worktree:*), Bash(git branch:*), Bash(ls:*)
argument-hint: <branch-name> [--delete-branch]
---

# Remove Worktree

Remove the worktree for branch `$1`.

## Current worktrees
!`git worktree list`

## Task
1. Remove the worktree using: `git worktree remove worktree/$1`
2. If `--delete-branch` or `-d` is in the arguments, also delete the branch: `git branch -d $1`
3. If removal fails due to uncommitted changes, inform the user and ask if they want to force removal
4. After removal, list remaining worktrees to confirm

## Safety
- Never force remove without user confirmation
- Warn if the branch has unmerged changes before deleting
