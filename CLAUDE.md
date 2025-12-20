# CLAUDE.md

## Architecture

Bare git repo with worktrees. `context` branch = metadata/config, `master` = source code.

## Worktree Pattern

- **Never touch `../master` directly**
- Create branches in `./worktree/{feature,fix,chore}-<name>/`
- Nested worktrees are gitignored, keeping context clean

## Configuration

| File | Scope | Contains |
|------|-------|----------|
| `settings.json` | Shared | Plugins, skills, commands |
| `settings.local.json` | Personal (gitignored) | Permissions |

## Commands

Use `worktree-context` plugin:
- `/worktree-context:wt-list` - List worktrees
- `/worktree-context:wt-add <branch>` - Create worktree from master
- `/worktree-context:wt-remove <branch>` - Remove worktree
