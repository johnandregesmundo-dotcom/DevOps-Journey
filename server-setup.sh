#!/bin/bash
# server-setup.sh
# DevOps Apprentice - Week 1 Project
# Automates initial server setup.

set -e  # Stop kung may error

echo "=========================================="
echo "  🚀 DevOps Server Setup Script"
echo "=========================================="
echo ""

# 1. Update system
echo "[1/5] Updating system packages..."
sudo apt update && sudo apt upgrade -y

# 2. Install essential tools
echo "[2/5] Installing essential tools..."
sudo apt install -y curl wget git vim htop tree net-tools

# 3. Create project directory structure
echo "[3/5] Creating project directories..."
mkdir -p ~/devops-projects/{docker,kubernetes,terraform,scripts}
tree ~/devops-projects

# 4. Set up Git (PALITAN MO ITO)
echo "[4/5] Configuring Git..."
git config --global user.name "Juan Dela Cruz"       # ← palitan
git config --global user.email "juan@email.com"      # ← palitan
git config --global init.defaultBranch main

# 5. Welcome message
echo "[5/5] Setup complete!"
echo ""
echo "✅ Welcome to your DevOps environment!"
echo "Directories created:"
ls -la ~/devops-projects

# System info
echo ""
echo "----- System Info -----"
echo "OS:       $(uname -o)"
echo "Kernel:   $(uname -r)"
echo "Hostname: $(hostname)"
echo "Uptime:   $(uptime -p)"
echo ""
echo "=========================================="

