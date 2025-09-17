#!/bin/bash
set -e

if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 not found. Please install Python 3.11 before continuing."
    exit 1
fi

PY_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
if [ "$PY_VERSION" != "3.11" ]; then
    echo "❌ Python version mismatch. Found $PY_VERSION, but 3.11 is required."
    exit 1
fi

if [ -d ".venv" ]; then
    VENV_VERSION=$(./.venv/bin/python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")' || echo "none")
    if [ "$VENV_VERSION" != "3.11" ]; then
        echo "⚠️  Existing .venv uses $VENV_VERSION. Recreating..."
        rm -rf .venv
    fi
fi

python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Setup complete!"
echo "➡️ To activate: source .venv/bin/activate"
