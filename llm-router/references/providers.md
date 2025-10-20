# LLM Provider Reference

This document provides detailed information about supported LLM providers, their configurations, models, and capabilities.

## Supported Providers

### OpenAI (Default)

**Provider ID:** `openai` (or empty string)
**Base URL:** Default OpenAI endpoint
**Environment Variable:** `OPENAI_API_KEY`

#### Popular Models

- **GPT-5** (`gpt-5`, `gpt-5-mini`, `gpt-5-nano`) - Latest generation with advanced reasoning
  - `gpt-5`: Complex reasoning, broad world knowledge, code-heavy tasks
  - `gpt-5-mini`: Cost-optimized reasoning and chat
  - `gpt-5-nano`: High-throughput, simple instruction-following
- **GPT-4** (`gpt-4o`, `gpt-4o-mini`) - Multimodal, balanced performance
- **GPT-3.5** (`gpt-3.5-turbo`) - Fast and economical

#### Configuration Example

```bash
swiftopenai config set provider ""
swiftopenai config set base-url ""
swiftopenai config set api-key sk-...
swiftopenai config set default-model gpt-5-mini
```

#### Agent Mode

Supports full agent mode with MCP tools, session management, and auto-compaction.

---

### xAI (Grok)

**Provider ID:** `xai`
**Base URL:** `https://api.x.ai/v1`
**Environment Variable:** `XAI_API_KEY`

#### Popular Models

- **Grok-4** (`grok-4-0709`) - Latest Grok model with enhanced reasoning
- **Grok-3** (`grok-3`) - General purpose language model
- **Grok Code Fast** (`grok-code-fast-1`) - Optimized for code generation

#### Configuration Example

```bash
swiftopenai config set provider xai
swiftopenai config set base-url https://api.x.ai/v1
swiftopenai config set api-key xai-...
swiftopenai config set default-model grok-4-0709
```

#### Agent Mode

Fully supported with agent mode capabilities.

---

### Groq

**Provider ID:** `groq`
**Base URL:** `https://api.groq.com/openai/v1`
**Environment Variable:** `GROQ_API_KEY`

#### Popular Models

- **Llama 3.3** (`llama-3.3-70b-versatile`) - Versatile open-source model
- **Mixtral** (`mixtral-8x7b-32768`) - Mixture of experts architecture
- Various other open-source models with ultra-fast inference

#### Configuration Example

```bash
swiftopenai config set provider groq
swiftopenai config set base-url https://api.groq.com/openai/v1
swiftopenai config set api-key gsk_...
swiftopenai config set default-model llama-3.3-70b-versatile
```

#### Agent Mode

Supported with agent mode capabilities.

---

### DeepSeek

**Provider ID:** `deepseek`
**Base URL:** `https://api.deepseek.com`
**Environment Variable:** `DEEPSEEK_API_KEY`

#### Popular Models

- **DeepSeek Chat** (`deepseek-chat`) - General purpose conversational model
- **DeepSeek Coder** (`deepseek-coder`) - Specialized for coding tasks
- **DeepSeek Reasoner** (`deepseek-reasoner`) - Advanced reasoning capabilities

#### Configuration Example

```bash
swiftopenai config set provider deepseek
swiftopenai config set base-url https://api.deepseek.com
swiftopenai config set api-key sk-...
swiftopenai config set default-model deepseek-reasoner
```

#### Agent Mode

Supported with agent mode capabilities.

---

### OpenRouter

**Provider ID:** `openrouter`
**Base URL:** `https://openrouter.ai/api/v1`
**Environment Variable:** `OPENROUTER_API_KEY`

#### Popular Models

OpenRouter provides access to 300+ models from various providers:

- **Anthropic:** `anthropic/claude-3.5-sonnet`, `anthropic/claude-3.5-haiku`
- **OpenAI:** `openai/gpt-4`, `openai/gpt-4-turbo`
- **Google:** `google/gemini-pro`, `google/gemini-pro-vision`
- **Meta:** `meta-llama/llama-3.1-405b`
- And many more...

#### Configuration Example

```bash
swiftopenai config set provider openrouter
swiftopenai config set base-url https://openrouter.ai/api/v1
swiftopenai config set api-key sk-or-v1-...
swiftopenai config set default-model anthropic/claude-3.5-sonnet
```

#### Agent Mode

Supported with agent mode capabilities.

---

## Agent Mode Features

SwiftOpenAI-CLI's agent mode provides:

- **MCP Integration** - Connect to external tools via Model Context Protocol
- **Conversation Memory** - Maintains context within sessions
- **Auto-Compaction** - Automatically summarizes long conversations
- **Session Management** - Continue conversations with `--session-id`
- **Tool Calling** - Execute built-in and MCP tools
- **Multiple Output Formats** - plain, json, stream-json

### Agent Mode Usage

```bash
# Simple agent command
swiftopenai agent "Calculate 25 * 37 and tell me today's date"

# With specific model
swiftopenai agent "Explain quantum computing" --model gpt-5

# Interactive mode
swiftopenai agent --interactive

# With MCP tools
swiftopenai agent "Read config.json" \
  --mcp-servers filesystem \
  --allowed-tools "mcp__filesystem__*"
```

## Common Configuration Commands

### View Current Configuration

```bash
swiftopenai config list
```

### Get Specific Setting

```bash
swiftopenai config get default-model
swiftopenai config get provider
```

### Set Configuration Values

```bash
swiftopenai config set <key> <value>
```

### Interactive Configuration Setup

```bash
swiftopenai config setup
```

## Temperature and Parameters

Control response randomness and behavior:

```bash
# Set default temperature (0.0-2.0)
swiftopenai config set temperature 0.7

# Override per command
swiftopenai chat "Write a poem" --temperature 1.5

# Set max tokens
swiftopenai config set max-tokens 2000
```

## Managing Multiple Provider API Keys

### Best Practice: Use Provider-Specific Environment Variables

To seamlessly use multiple providers without constantly reconfiguring API keys, set all provider keys as environment variables in your shell profile.

**Add to `~/.zshrc` or `~/.bashrc`:**

```bash
# API Keys for LLM Providers
export OPENAI_API_KEY=sk-...
export XAI_API_KEY=xai-...
export GROQ_API_KEY=gsk_...
export DEEPSEEK_API_KEY=sk-...
export OPENROUTER_API_KEY=sk-or-v1-...
```

**Benefits:**
- ✅ All keys available at once
- ✅ Automatic key selection based on provider
- ✅ No need to reconfigure when switching providers
- ✅ Keys persist across terminal sessions
- ✅ More secure than storing in config file

**After adding, reload your shell:**
```bash
source ~/.zshrc  # or source ~/.bashrc
```

### How SwiftOpenAI-CLI Selects API Keys

When you configure a provider, SwiftOpenAI-CLI uses this priority:

1. **Provider-specific environment variable** (e.g., `XAI_API_KEY` for Grok)
2. Config file `api-key` setting (if set)
3. Generic `OPENAI_API_KEY` fallback (for OpenAI provider only)

**Example Flow:**
```bash
# Configure for Grok
swiftopenai config set provider xai

# CLI automatically uses XAI_API_KEY environment variable
swiftopenai agent "Hello, world!"

# Switch to OpenAI
swiftopenai config set provider ""

# CLI automatically uses OPENAI_API_KEY environment variable
swiftopenai agent "Hello, world!"
```

### Config File Limitation

The config file (`~/.swiftopenai/config.json`) only stores **ONE** api-key value. If you use `swiftopenai config set api-key <key>`, it will be used for **all providers** (unless overridden by a provider-specific env var).

This is why environment variables are recommended for multiple providers.

## Debug Mode

Enable debug mode to see HTTP details:

```bash
swiftopenai config set debug true
```

Shows:
- HTTP status codes and headers
- Full API requests (when built in debug mode)
- Response details

## Troubleshooting

### Authentication Errors

- Verify API key is set correctly
- Check environment variable is exported
- Ensure provider configuration matches your API key

### Model Not Available

- Verify model name is correct for the provider
- Use `swiftopenai models` to list available models
- Check provider documentation for model availability

### Connection Issues

- Verify base URL is correct
- Check network connectivity
- Ensure API service is operational
