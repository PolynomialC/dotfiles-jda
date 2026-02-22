#!/bin/bash
# setup.sh - Run this on any new Ubuntu machine

set -e # Exit on error

echo "--- Installing System Essentials ---"
sudo apt update && sudo apt install -y \
    curl wget git build-essential zstd emacs-pgtk xdg-utils

echo "--- Setting up GitHub CLI (Secure Keyring) ---"
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh -y

echo "--- Installing NVM & AI Toolchain ---"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 22
npm install -g @anthropic-ai/claude-cli @openai/codex aider-chat

echo "--- Installing Zellij & Zoxide ---"
# Binary install for Zellij (Apt version is often missing)
curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar xz
sudo mv zellij /usr/local/bin/
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "--- Finalizing Configs ---"
mkdir -p ~/.emacs.d
cp init.el ~/.emacs.d/init.el
cat .bashrc_ext >> ~/.bashrc

echo "Setup Complete! Restart Ghostty and type 'zellij' to begin."