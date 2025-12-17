---
description: Initialize context branch methodology on a new or existing repository
allowed-tools: Bash(git:*), Bash(mkdir:*), Bash(ls:*), Write, Edit
argument-hint: [repo-path]
---

# Initialize Context Branch Methodology

Set up the separation of concerns structure for AI context and project code.

## Target
Repository at: `${1:-.}` (current directory if not specified)

## Standard Structure

All worktrees live inside a `/root` folder within the bare repository:

```
bare-repo/
└── root/
    ├── context/              # context branch (AI configuration)
    │   ├── CLAUDE.md
    │   ├── .claude/
    │   ├── .gitignore        # Contains: worktree/**/
    │   └── worktree/         # All code worktrees here
    │       └── feature/...
    └── master/               # master/main branch (direct access)
```

## Task

### Step 1: Detect repository type
- Check if target is a bare repo, regular repo, or needs cloning
- Identify the main branch name (master or main)

### Step 2: Convert to bare repo structure (if needed)
If the repo is not bare:
```bash
# Clone as bare
git clone --bare <repo-url> <repo-name>
cd <repo-name>
```

### Step 3: Create the /root directory structure if not exists
```bash
mkdir -p root
```

### Step 4: Create master/main worktree
```bash
# Detect main branch name
MAIN_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "master")
git worktree add root/$MAIN_BRANCH $MAIN_BRANCH
```

### Step 5: Create orphan context branch and worktree
```bash
# Create orphan branch
git checkout --orphan context
git reset --hard
git commit --allow-empty -m "init: context branch for AI configuration"

# Add as worktree
git worktree add root/context context
```

### Step 6: Set up context branch structure
In `root/context/`, create:
- `CLAUDE.md` - Basic project instructions template
- `.gitignore` - With `worktree/**/` to ignore nested worktrees
- `.claude/` directory for commands, agents, skills
- `worktree/` directory for code worktrees

### Step 7: Verify setup
```bash
git worktree list
```

Expected output:
```
/path/to/bare-repo              (bare)
/path/to/bare-repo/root/context [context]
/path/to/bare-repo/root/master  [master]
```

## Output

Provide clear next steps:
1. `cd root/context` to work with AI configuration
2. Use `/wt-new feature/name` to create feature worktrees
3. All code work happens in `root/context/worktree/`
4. Never edit `root/master/` directly - use worktrees instead
