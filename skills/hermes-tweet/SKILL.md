---
name: hermes-tweet
description: Configure and operate Hermes Tweet, the Hermes Agent X/Twitter plugin. Use this skill when users ask to install Hermes Tweet, set XQUIK_API_KEY, use tweet_explore, use tweet_read, gate tweet_action, or troubleshoot Hermes Agent plugin discovery.
---

# Hermes Tweet

## Overview

Configure Hermes Tweet for Hermes Agent so users can explore X/Twitter tools, run guarded read workflows, and enable write-capable actions only after explicit confirmation.

**Built for:**
- Hermes Agent plugin setup
- X/Twitter research and read-only workflows
- Public-safe plugin documentation
- Guarded social media action workflows

---

## Quick Start

### 1. Install Hermes Tweet

Install into the Hermes Agent runtime so plugin discovery can find it:

```bash
hermes plugins install Xquik-dev/hermes-tweet --enable
```

If the project uses a manually managed Hermes runtime, install with that runtime's Python and then enable the plugin:

```bash
~/.hermes/hermes-agent/venv/bin/python -m pip install hermes-tweet
hermes plugins enable hermes-tweet
```

Public package sources:
- GitHub: `https://github.com/Xquik-dev/hermes-tweet`
- PyPI: `https://pypi.org/project/hermes-tweet/`

### 2. Configure Runtime Access

Set the API key in the Hermes Agent runtime environment. Use placeholders in documentation:

```bash
export XQUIK_API_KEY="xq_..."
```

Never paste, print, log, or commit real API keys.

### 3. Explore Before Reading

Start with the no-network orientation tool:

```text
Use tweet_explore to list available Hermes Tweet tools and safe next steps.
```

Then use `tweet_read` only after `XQUIK_API_KEY` is available.

### 4. Gate Actions

Only use `tweet_action` when all prerequisites pass:

1. The user explicitly requested the action.
2. `XQUIK_API_KEY` is available in the runtime.
3. `HERMES_TWEET_ENABLE_ACTIONS=true` is set.
4. The action target, text, and timing are confirmed.
5. The request complies with platform and user policies.

If any prerequisite fails, stop and state the missing requirement.

---

## Core Workflow

### Phase 1: Confirm Hermes Agent Context

1. Verify the user is working with Hermes Agent.
2. Read the existing plugin configuration before changing it.
3. Preserve current plugin entries, environment variables, and comments.
4. Confirm whether the plugin should be installed from PyPI or source.

### Phase 2: Install and Enable

1. Install and enable Hermes Tweet in the Hermes Agent runtime.
2. Confirm Hermes Agent can discover the plugin.
3. Keep project-local plugin loading enabled only when the project expects it.
4. Do not alter unrelated Hermes plugins.

### Phase 3: Configure Reads

1. Confirm `XQUIK_API_KEY` is set in the runtime environment.
2. Use `tweet_explore` for tool discovery and guidance.
3. Use `tweet_read` for account, keyword, URL, or status ID reads.
4. Summarize results without exposing credentials, raw session material, or private implementation details.

### Phase 4: Configure Actions

1. Keep actions disabled by default.
2. Enable actions only with `HERMES_TWEET_ENABLE_ACTIONS=true`.
3. Confirm the exact action before execution.
4. Report the JSON result without adding unsupported claims.

---

## Troubleshooting

**Plugin not listed**
- Check the install path.
- Check Hermes Agent plugin enablement.
- Restart or reload the Hermes runtime if needed.

**`tweet_read` unavailable**
- Confirm `XQUIK_API_KEY` is set in the same runtime that launches Hermes Agent.
- Re-run `tweet_explore` to inspect available tools.

**`tweet_action` unavailable**
- Confirm `XQUIK_API_KEY`.
- Confirm `HERMES_TWEET_ENABLE_ACTIONS=true`.
- Confirm the user explicitly requested a write-capable operation.

**Unexpected JSON error**
- Preserve the returned error string.
- Avoid retry loops unless the user asks for a retry.
- Check `references/safety-checklist.md` before publishing any updated instructions.

---

## Output Template

```markdown
## Hermes Tweet Status

- Plugin: installed | missing | unknown
- Runtime key: configured | missing | not checked
- Read tools: ready | blocked
- Action tools: disabled | enabled after confirmation | blocked

## Next Step

<one concrete command or configuration change>

## Safety Notes

- <credential, action, or publication constraint>
```

---

## Reference Materials

- `references/safety-checklist.md` - Publication and action-gating checklist
