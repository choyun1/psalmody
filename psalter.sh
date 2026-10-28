#!/bin/sh
# Open the chant browser and service planner (Linux/macOS). Make it double-clickable with: chmod +x psalter.sh
cd "$(dirname "$0")" || exit 1
python3 -m pip install -q --disable-pip-version-check -r requirements.txt 2>/dev/null
exec python3 tools/serve.py
