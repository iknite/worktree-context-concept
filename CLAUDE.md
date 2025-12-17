# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a git worktree branch (`context`) of the parent repository at `/home/iknite/work/iknite/worktree-context-concept`. It appears to be an experimental setup for exploring git worktree concepts.

## Git Worktree Structure

This repository uses git worktrees:
- **Bare repo**: `/home/iknite/work/iknite/worktree-context-concept`
- **This worktree**: `context` branch
- **Sibling worktree**: `master` branch at `../master`

## Commands

```bash
# List all worktrees
git worktree list

# Navigate between worktrees
cd ../master  # switch to master worktree
```
