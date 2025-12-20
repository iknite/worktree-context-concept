# Iknite's Claude Code Marketplace

A Claude Code Marketplace for some use cases that i couldn't find :)


## Quick Start

Add this marketplace to Claude Code:

```bash
/plugin marketplace add iknite/claude-code-marketplace
```

Then browse and install individual plugins (commands or agents):

```bash
/plugin
```

Install a specific Plugin:
```bash
/plugin install worktree-context@iknite-cc-marketplace
```

## Available Plugins

| Plugin | Description |
|--------|-------------|
| [worktree-context](./worktree-context/) | Bootstrap projects with **separation of concerns** between AI configuration and source code using git worktrees. Keeps `CLAUDE.md` and `.claude/` in a dedicated `context` branch while your project code stays clean in `main`/`master`. |

### worktree-context

Provides commands for managing git worktrees with a focus on AI-assisted development:

- `/worktree-context:context-init` - Bootstrap a repo with the context branch methodology
- `/worktree-context:wt-new` - Create a new worktree for a feature branch
- `/worktree-context:wt-list` - List all worktrees
- `/worktree-context:wt-status` - Show status of all worktrees (uncommitted changes, sync state)
- `/worktree-context:wt-pr` - Create a GitHub PR from a worktree branch
- `/worktree-context:wt-remove` - Clean up a worktree after merge
