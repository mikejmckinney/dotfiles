#!/bin/bash
# Description: One-command project setup
# Usage: ./scripts/setup.sh
#
# This script handles:
# 1. Installing dependencies
# 2. Setting up environment variables
# 3. Running database migrations (if applicable)
# 4. Verifying the environment
#
# TEMPLATE_PLACEHOLDER: Customize this for your project

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { printf "${GREEN}[INFO]${NC} %s\n" "$1"; }
log_warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }
log_step() { printf "\n${GREEN}==>${NC} %s\n" "$1"; }

echo "========================================"
echo "Project Setup"
echo "========================================"

# --- Step 1: Environment File ---
log_step "Setting up environment variables"

if [[ -f ".env" ]]; then
    log_info ".env already exists, skipping"
elif [[ -f ".env.example" ]]; then
    cp .env.example .env
    log_info "Created .env from .env.example"
    log_warn "Review .env and update any placeholder values"
else
    log_warn "No .env.example found, skipping environment setup"
fi

# --- Step 2: Install Dependencies ---
log_step "Installing dependencies"

# Node.js
if [[ -f "package.json" ]]; then
    log_info "Found package.json, installing Node.js dependencies..."
    if [[ -f "package-lock.json" ]]; then
        npm ci
    else
        npm install
    fi
    log_info "Node.js dependencies installed"
fi

# Python
if [[ -f "requirements.txt" ]]; then
    log_info "Found requirements.txt, installing Python dependencies..."
    pip install -r requirements.txt
    log_info "Python dependencies installed"
elif [[ -f "pyproject.toml" ]]; then
    log_info "Found pyproject.toml, installing Python dependencies..."
    pip install -e .
    log_info "Python dependencies installed"
fi

# --- Step 3: Database Setup (if applicable) ---
log_step "Setting up database"

# Uncomment and customize for your project:
# if [[ -f "prisma/schema.prisma" ]]; then
#     log_info "Running Prisma migrations..."
#     npx prisma migrate dev
#     log_info "Database migrations complete"
# fi

# if [[ -f "alembic.ini" ]]; then
#     log_info "Running Alembic migrations..."
#     alembic upgrade head
#     log_info "Database migrations complete"
# fi

log_info "No database configuration detected (customize setup.sh if needed)"

# --- Step 4: Build (if applicable) ---
log_step "Building project"

if [[ -f "package.json" ]] && grep -q '"build"' package.json; then
    log_info "Running build..."
    npm run build
    log_info "Build complete"
else
    log_info "No build step configured"
fi

# --- Step 5: Verify Environment ---
log_step "Verifying environment"

if [[ -f "scripts/verify-env.sh" ]]; then
    ./scripts/verify-env.sh
else
    log_warn "verify-env.sh not found, skipping verification"
fi

# --- Done ---
echo ""
echo "========================================"
printf "${GREEN}Setup Complete!${NC}\n"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Review .env and update any placeholder values"
echo "  2. Check .context/00_INDEX.md for project context"
echo "  3. Start development!"
echo ""

# Show available scripts if package.json exists
if [[ -f "package.json" ]]; then
    echo "Available npm scripts:"
    grep -E '^\s+"[^"]+":' package.json | head -10 | sed 's/[",]//g' | sed 's/^/  /'
fi
