#!/bin/bash
# Installs the Agent Reach CLI that .claude/skills/agent-reach depends on.
# Runs only in Claude Code cloud sessions; local machines are left untouched.
set -euo pipefail
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
export PATH="$HOME/.local/bin:$PATH"
command -v agent-reach >/dev/null 2>&1 && exit 0
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null 2>&1
fi
# Install from the project's GitHub release only; the PyPI "agent-reach" package is unrelated.
uv tool install https://github.com/Panniantong/Agent-Reach/releases/latest/download/agent-reach.zip >/dev/null 2>&1
agent-reach setup </dev/null >/dev/null 2>&1 || true
