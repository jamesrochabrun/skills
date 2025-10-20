#!/bin/bash
# Script to check if swiftopenai-cli is installed and install/update if needed

set -e

REQUIRED_VERSION="1.4.4"
PACKAGE_NAME="swiftopenai-cli"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Checking SwiftOpenAI-CLI installation..."

# Check if swiftopenai command exists
if ! command -v swiftopenai &> /dev/null; then
  echo -e "${YELLOW}SwiftOpenAI-CLI is not installed.${NC}"
  echo "📦 Installing swiftopenai-cli via npm..."
  npm install -g swiftopenai-cli
  echo -e "${GREEN}✅ SwiftOpenAI-CLI installed successfully!${NC}"
  swiftopenai --version
  exit 0
fi

# Get current version
CURRENT_VERSION=$(swiftopenai --version 2>&1 | tr -d '\n')

echo "📌 Current version: $CURRENT_VERSION"
echo "📌 Latest known version: $REQUIRED_VERSION"

# Function to compare versions
version_ge() {
  # Returns 0 if $1 >= $2
  printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

# Check if update is available
echo "🔍 Checking for updates..."
LATEST_VERSION=$(npm view swiftopenai-cli version 2>/dev/null || echo "$REQUIRED_VERSION")

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
  echo -e "${GREEN}✅ SwiftOpenAI-CLI is up to date (v$CURRENT_VERSION)${NC}"
elif version_ge "$CURRENT_VERSION" "$REQUIRED_VERSION"; then
  echo -e "${GREEN}✅ SwiftOpenAI-CLI version is acceptable (v$CURRENT_VERSION >= v$REQUIRED_VERSION)${NC}"
  echo -e "${YELLOW}⚠️  A newer version (v$LATEST_VERSION) is available. Consider updating with:${NC}"
  echo "   npm update -g swiftopenai-cli"
else
  echo -e "${YELLOW}⚠️  SwiftOpenAI-CLI is outdated (v$CURRENT_VERSION < v$REQUIRED_VERSION)${NC}"
  echo "🔄 Updating to latest version..."
  npm update -g swiftopenai-cli
  NEW_VERSION=$(swiftopenai --version 2>&1 | tr -d '\n')
  echo -e "${GREEN}✅ Updated to version $NEW_VERSION${NC}"
fi

# Verify installation
echo ""
echo "🔧 SwiftOpenAI-CLI is ready to use!"
echo "   Location: $(which swiftopenai)"
echo "   Version: $(swiftopenai --version 2>&1)"
