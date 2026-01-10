#!/bin/bash
# Template verification script
# Ensures all required files exist and are properly formatted

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

PASS=0
FAIL=0
WARN=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pass() {
    echo -e "${GREEN}✓${NC} $1"
    PASS=$((PASS + 1))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    FAIL=$((FAIL + 1))
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    WARN=$((WARN + 1))
}

echo "========================================"
echo "Template Repository Verification"
echo "========================================"
echo ""

# --- Required Files Check ---
echo "Checking required files..."

REQUIRED_FILES=(
    "AI_REPO_GUIDE.md"
    "AGENTS.md"
    "AGENT.md"
    "README.md"
    "install.sh"
    ".cursor/BUGBOT.md"
    ".gemini/styleguide.md"
    ".github/copilot-instructions.md"
    ".github/agents/judge.agent.md"
    ".github/prompts/copilot-onboarding.md"
    ".github/prompts/repo-onboarding.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        pass "$file exists"
    else
        fail "$file is missing"
    fi
done

echo ""

# --- File Content Checks ---
echo "Checking file contents..."

# Check AGENTS.md references AI_REPO_GUIDE.md
if grep -q "AI_REPO_GUIDE.md" AGENTS.md 2>/dev/null; then
    pass "AGENTS.md references AI_REPO_GUIDE.md"
else
    fail "AGENTS.md should reference AI_REPO_GUIDE.md"
fi

# Check install.sh is executable or has shebang
if head -1 install.sh | grep -q "^#!/bin/bash"; then
    pass "install.sh has bash shebang"
else
    fail "install.sh missing bash shebang"
fi

# Check judge.agent.md has required sections
if grep -q "PLAN-GATE" .github/agents/judge.agent.md 2>/dev/null; then
    pass "judge.agent.md has PLAN-GATE section"
else
    warn "judge.agent.md missing PLAN-GATE section"
fi

if grep -q "DIFF-GATE" .github/agents/judge.agent.md 2>/dev/null; then
    pass "judge.agent.md has DIFF-GATE section"
else
    warn "judge.agent.md missing DIFF-GATE section"
fi

# Check for contentReference artifacts (should not be present)
if grep -q -E "contentReference|oaicite" .github/agents/judge.agent.md 2>/dev/null; then
    fail "judge.agent.md contains contentReference artifacts (clean these up)"
else
    pass "judge.agent.md is clean of artifacts"
fi

echo ""

# --- Script Syntax Check ---
echo "Checking script syntax..."

if bash -n install.sh 2>/dev/null; then
    pass "install.sh has valid bash syntax"
else
    fail "install.sh has syntax errors"
fi

if bash -n test.sh 2>/dev/null; then
    pass "test.sh has valid bash syntax"
else
    fail "test.sh has syntax errors"
fi

echo ""

# --- Markdown Structure Checks ---
echo "Checking markdown structure..."

# Check that key files have headers
for file in AI_REPO_GUIDE.md AGENTS.md README.md; do
    if head -5 "$file" | grep -q "^#"; then
        pass "$file has a header"
    else
        warn "$file missing header"
    fi
done

echo ""

# --- Summary ---
echo "========================================"
echo "Summary"
echo "========================================"
echo -e "${GREEN}Passed:${NC} $PASS"
echo -e "${YELLOW}Warnings:${NC} $WARN"
echo -e "${RED}Failed:${NC} $FAIL"
echo ""

if [[ $FAIL -gt 0 ]]; then
    echo -e "${RED}Template verification FAILED${NC}"
    exit 1
elif [[ $WARN -gt 0 ]]; then
    echo -e "${YELLOW}Template verification PASSED with warnings${NC}"
    exit 0
else
    echo -e "${GREEN}Template verification PASSED${NC}"
    exit 0
fi
