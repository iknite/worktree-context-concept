---
description: List all git worktrees with their status
allowed-tools: Bash(git worktree:*), Bash(git branch:*), Bash(git log:*)
---

# List Worktrees

Show all worktrees in this repository with their current status.

## Current worktrees
!`git worktree list`

## Task
Provide a summary of:
1. All active worktrees and their branches
2. Which worktrees are inside `worktree/` (following methodology)
3. Which worktrees are outside (legacy or root worktrees)
4. Any worktrees that might need cleanup (merged branches)

Format the output clearly for the user.
