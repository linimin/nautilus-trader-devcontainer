#!/usr/bin/env bash
set -euo pipefail

# remoteEnv points PYTHONHOME and loader paths at /opt/nautilus-python, but the
# symlink lives in the container filesystem and is lost when the container is
# recreated. Recreate it whenever the persisted .venv is available.
if [[ ! -x /workspace/.venv/bin/python ]]; then
    exit 0
fi

python_base="$(/workspace/.venv/bin/python -c 'import sys; print(sys.base_prefix)')"
ln -sfn "$python_base" /opt/nautilus-python
