---
description: Create a GitHub PR from a worktree branch
allowed-tools: Bash(git:*), Bash(gh:*)
argument-hint: <branch-name> [base-branch]
---

# Create PR from Worktree

Create a GitHub Pull Request for branch `$1` targeting `${2:-master}`.

## Current status of the branch
!`cd worktree/$1 2>/dev/null && git status || echo "Worktree not found at worktree/$1"`

## Recent commits on this branch
!`cd worktree/$1 2>/dev/null && git log --oneline -5 || echo ""`

## Task
1. Navigate to the worktree: `worktree/$1`
2. Check for uncommitted changes - if any, ask user what to do
3. Push the branch to remote: `git push -u origin $1`
4. Create the PR using `gh pr create`:
   - Title: derive from branch name or recent commits
   - Body: summarize changes with a test plan
   - Base: `${2:-master}`

## PR Body Template
```
## Summary
<bullet points of changes>

## Test plan
<how to verify the changes>

---
Generated with [Claude Code](https://claude.ai/code)
```
