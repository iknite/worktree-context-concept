# Worktree Context Plugin for Claude Code

A Claude Code plugin that bootstraps projects with **separation of concerns** between AI configuration and source code using git worktrees.

## Installation

### From Marketplace (Recommended)

```bash
# Add the marketplace
/plugin marketplace add iknite/worktree-context-concept

# Install the plugin
/plugin install worktree-context@worktree-context-marketplace
```

### Manual Installation

```bash
# Clone and copy to user config
git clone https://github.com/iknite/worktree-context-concept.git
cp -r worktree-context-concept/.claude/* ~/.claude/
```

### Verify Installation

```
/wt-list
/wt-status
```

## Usage

### Bootstrap a new project

```
/context-init /path/to/your/repo
```

This sets up the complete worktree structure automatically.

### Daily workflow

```bash
# Check status of all worktrees
/wt-status

# Create a new feature branch
/wt-new feature/my-feature

# Work on your feature in worktree/feature/my-feature
# ... make changes with Claude Code ...

# Create a PR when ready
/wt-pr feature/my-feature

# Clean up after merge
/wt-remove feature/my-feature --delete-branch
```

## Commands

| Command | Description |
|---------|-------------|
| `/context-init [path]` | Bootstrap a repo with the context branch methodology |
| `/wt-new <branch> [base]` | Create a new worktree (auto-detects main/master) |
| `/wt-list` | List all worktrees |
| `/wt-status` | Show status: uncommitted changes, unpushed commits, sync state |
| `/wt-pr <branch> [base]` | Create GitHub PR from a worktree branch |
| `/wt-remove <branch> [-d]` | Remove worktree, optionally delete branch |

## The Methodology

This plugin creates a clean separation using **two independent git histories**:

```
bare-repo/
└── root/
    ├── context/              # AI configuration (CLAUDE.md, .claude/)
    │   ├── .gitignore        # Ignores worktree/**/
    │   └── worktree/         # All feature worktrees live here
    │       └── feature/
    │           └── my-feature/
    └── main/                 # Default branch (read-only reference)
```

**Why?**
- AI config (`CLAUDE.md`, `.claude/`) stays in `context` branch
- Project code stays in `main`/`master` lineage
- Feature branches are nested inside `context` but ignored by it
- Clean project history without AI config noise

## Components

| Component | Purpose |
|-----------|---------|
| **Commands** (`.claude/commands/`) | Slash commands for worktree operations |
| **Hooks** (`.claude/settings.json`) | Guardrails blocking direct edits to `root/main/` |
| **Agent** (`.claude/agents/`) | `worktree-manager` for complex operations |
| **Skill** (`.claude/skills/`) | Knowledge base Claude discovers automatically |

## Plugin Management

```bash
# Update the plugin
/plugin update worktree-context

# Disable temporarily
/plugin disable worktree-context@worktree-context-marketplace

# Uninstall
/plugin uninstall worktree-context@worktree-context-marketplace
```

## Troubleshooting

**Commands not showing up?**
- Run `/plugin` to check installation status
- Try `/plugin update worktree-context`

**Need complex worktree operations?**
Ask Claude: "Use the worktree-manager agent to help me..."

---
with <3 @iknite
