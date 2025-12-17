# Worktree Context Concept for Agents

A Claude Code plugin that implements a **separation of concerns** between AI context/configuration and project source code using git worktrees.

## The Problem

When working with AI coding assistants like Claude Code, you often need:
- `CLAUDE.md` files with project-specific instructions
- `.claude/` directories with settings and configurations
- Custom slash commands and hooks

These files clutter your project history and mix AI tooling concerns with your actual source code.

## The Solution: Context Branch Methodology

This plugin enforces a clean separation using **two independent git histories**:

```
bare-repo/
├── root/
│   ├── context/              # context branch (AI configuration)
│   │   ├── CLAUDE.md         # Project instructions for Claude
│   │   ├── .claude/          # Claude Code settings
│   │   ├── .gitignore        # Ignores worktree/**/
│   │   └── worktree/         # All project worktrees live here
│   │       └── feature/
│   │           └── my-feature/  # Actual code (from master lineage)
│   └── master/               # master branch (optional direct access)
```

### Key Concepts

| Branch | Purpose | History |
|--------|---------|---------|
| `context` | AI context, CLAUDE.md, .claude/ settings | Independent orphan branch |
| `master` | Project source code | Normal project history |
| `feature/*` | Feature branches | Descendants of master |

### How It Works

1. **The `context` branch** is an orphan branch with its own history - it never merges with `master`
2. **All code worktrees** are created inside `context/worktree/` and descend from `master`
3. **The `.gitignore`** in context ignores `worktree/**/`, so nested worktrees don't pollute context commits
4. **Claude Code** runs from the `context` worktree, seeing both the AI configuration AND the nested code worktrees

## Installation

```bash
# Clone as bare repository
git clone --bare <repo-url> my-project
cd my-project

# Set up the context branch structure
# (Plugin will automate this)
```

## Usage

```bash
# Create a new feature branch (from context worktree)
git worktree add -b feature/my-feature worktree/feature/my-feature master

# Work on your feature
cd worktree/feature/my-feature
# ... make changes ...

# Claude Code sees both:
# - Context from parent (CLAUDE.md, .claude/)
# - Your feature code
```

## Plugin Features (Planned)

- [ ] Initialize context branch methodology on existing repos
- [ ] Automatically create worktrees with proper structure
- [ ] Validate worktree hierarchy
- [ ] Sync context across worktrees
- [ ] Clean up merged worktrees

## Repository Structure

This repository itself uses the context branch methodology:

- **`context` branch**: Contains this documentation context and Claude Code configuration
- **`master` branch**: Contains the plugin source code
- **Feature branches**: Development happens in `worktree/feature/*`

---
with <3 @iknite
