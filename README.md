# Context Branch

This branch holds shared Claude Code configuration for collaborative development.

## Shared vs Personal Configuration

The `.claude/` folder contains two types of settings:

| File | Tracked | Purpose |
|------|---------|---------|
| `settings.json` | Shared | Plugins, skills, commands - built together by the team |
| `settings.local.json` | Personal | Permissions and allowed actions - your risk tolerance |

### Example Configurations

**Daredevil** (`.claude/settings.local.json`):
```json
{ "permissions": { "allow": [ "Bash(*)", "Edit(*)", "Write(*)" ] }
}
```

**Conservative** (`.claude/settings.local.json`):
```json
{ "permissions": { "allow": [], "deny": ["Bash(*)", "Write(*)", "Edit(*):!*.md"] } }
```

Both developers share the same agents, skills, and commands from `settings.json` while maintaining their own permission boundaries.

## Getting Started

1. Clone or checkout the `context` branch
3. Contribute shared configurations to `.claude/settings.json`
2. Create your personal `.claude/settings.local.json` with your preferred permissions
