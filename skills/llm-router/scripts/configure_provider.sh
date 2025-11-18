#!/usr/bin/env bash
# Script to configure swiftopenai-cli to use a specific LLM provider

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROVIDER_NAME="$1"
MODEL="$2"

# Function to get provider configuration
get_provider_config() {
  case "$1" in
    openai)
      echo "||gpt-4o,gpt-5,gpt-5-mini"
      ;;
    grok)
      echo "xai|https://api.x.ai/v1|grok-4-0709,grok-3,grok-code-fast-1"
      ;;
    groq)
      echo "groq|https://api.groq.com/openai/v1|llama-3.3-70b-versatile,mixtral-8x7b-32768"
      ;;
    deepseek)
      echo "deepseek|https://api.deepseek.com|deepseek-chat,deepseek-coder,deepseek-reasoner"
      ;;
    openrouter)
      echo "openrouter|https://openrouter.ai/api/v1|anthropic/claude-3.5-sonnet,openai/gpt-4"
      ;;
    *)
      echo ""
      ;;
  esac
}

usage() {
  echo -e "${BLUE}Usage: $0 <provider> [model]${NC}"
  echo ""
  echo "Supported providers:"
  echo "  openai      - OpenAI (GPT-4, GPT-5, etc.)"
  echo "  grok        - xAI Grok models"
  echo "  groq        - Groq (Llama, Mixtral, etc.)"
  echo "  deepseek    - DeepSeek models"
  echo "  openrouter  - OpenRouter (300+ models)"
  echo ""
  echo "Examples:"
  echo "  $0 grok grok-4-0709"
  echo "  $0 groq llama-3.3-70b-versatile"
  echo "  $0 deepseek deepseek-reasoner"
  echo "  $0 openai gpt-5"
  exit 1
}

if [ -z "$PROVIDER_NAME" ]; then
  usage
fi

# Normalize provider name to lowercase
PROVIDER_NAME=$(echo "$PROVIDER_NAME" | tr '[:upper:]' '[:lower:]')

# Get provider configuration
PROVIDER_CONFIG=$(get_provider_config "$PROVIDER_NAME")

# Check if provider is supported
if [ -z "$PROVIDER_CONFIG" ]; then
  echo -e "${RED}❌ Unsupported provider: $PROVIDER_NAME${NC}"
  usage
fi

# Parse provider configuration
IFS='|' read -r PROVIDER_ID BASE_URL DEFAULT_MODELS <<< "$PROVIDER_CONFIG"

echo -e "${BLUE}🔧 Configuring SwiftOpenAI-CLI for $PROVIDER_NAME${NC}"
echo ""

# Configure provider
if [ "$PROVIDER_NAME" = "openai" ]; then
  echo "📝 Setting provider to OpenAI (default)"
  swiftopenai config set provider "" 2>/dev/null || true
  swiftopenai config set base-url "" 2>/dev/null || true
else
  echo "📝 Setting provider to $PROVIDER_ID"
  swiftopenai config set provider "$PROVIDER_ID"

  if [ -n "$BASE_URL" ]; then
    echo "📝 Setting base URL to $BASE_URL"
    swiftopenai config set base-url "$BASE_URL"
  fi
fi

# Set model if provided
if [ -n "$MODEL" ]; then
  echo "📝 Setting default model to $MODEL"
  swiftopenai config set default-model "$MODEL"
elif [ -n "$DEFAULT_MODELS" ]; then
  # Use first default model
  DEFAULT_MODEL=$(echo "$DEFAULT_MODELS" | cut -d',' -f1)
  echo "📝 Setting default model to $DEFAULT_MODEL"
  swiftopenai config set default-model "$DEFAULT_MODEL"
fi

echo ""
echo -e "${GREEN}✅ Configuration complete!${NC}"
echo ""
echo "Current configuration:"
swiftopenai config list

echo ""

# Check if API key is set
API_KEY_SET=false
CONFIG_API_KEY=$(swiftopenai config get api-key 2>/dev/null || echo "")
API_KEY_SOURCE=""

# Check provider-specific environment variable
case "$PROVIDER_NAME" in
  openai)
    ENV_VAR="OPENAI_API_KEY"
    ;;
  grok)
    ENV_VAR="XAI_API_KEY"
    ;;
  groq)
    ENV_VAR="GROQ_API_KEY"
    ;;
  deepseek)
    ENV_VAR="DEEPSEEK_API_KEY"
    ;;
  openrouter)
    ENV_VAR="OPENROUTER_API_KEY"
    ;;
esac

# Check if API key is available (either in config or provider-specific env var)
if [ -n "$CONFIG_API_KEY" ] && [ "$CONFIG_API_KEY" != "not set" ] && [ "$CONFIG_API_KEY" != "****" ]; then
  API_KEY_SET=true
  API_KEY_SOURCE="config file"
elif [ -n "${!ENV_VAR}" ]; then
  API_KEY_SET=true
  API_KEY_SOURCE="environment variable $ENV_VAR"
fi

if [ "$API_KEY_SET" = true ]; then
  echo -e "${GREEN}✅ API key is configured ($API_KEY_SOURCE)${NC}"
  echo ""
  echo -e "${GREEN}🚀 Ready to use! Test with:${NC}"
  echo "   swiftopenai agent \"Hello, world!\""
else
  echo -e "${RED}⚠️  API KEY NOT SET${NC}"
  echo ""
  echo "You need to set an API key for $PROVIDER_NAME before using the CLI."
  echo ""
  echo -e "${GREEN}Recommended - Set via environment variable (best for multiple providers):${NC}"
  echo "   export $ENV_VAR=<your-api-key>"
  echo ""
  echo "   To persist across sessions, add to your shell profile:"
  echo "   echo 'export $ENV_VAR=<your-api-key>' >> ~/.zshrc"
  echo "   source ~/.zshrc"
  echo ""
  echo -e "${YELLOW}Alternative - Set via config (only if using one provider):${NC}"
  echo "   swiftopenai config set api-key <your-api-key>"
  echo ""
  echo -e "${BLUE}💡 Tip: Set ALL provider keys as environment variables for easy switching:${NC}"
  echo "   export OPENAI_API_KEY=sk-..."
  echo "   export XAI_API_KEY=xai-..."
  echo "   export GROQ_API_KEY=gsk_..."
  echo "   export DEEPSEEK_API_KEY=sk-..."
  echo "   export OPENROUTER_API_KEY=sk-or-..."
  echo ""
  echo -e "${YELLOW}After setting the API key, run the configuration again to verify.${NC}"
  exit 1
fi
