#!/usr/bin/env bash
set -euo pipefail

cd /workspace

# The persistent symlink may not exist yet during the first container setup.
unset PYTHONHOME
export PATH="/opt/capnp/bin:$PATH"
export LD_LIBRARY_PATH="/opt/capnp/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# Tool crates such as lychee have a memory-intensive dependency graph. Keep
# installation single-threaded so setup remains reliable in constrained VMs.
if ! command -v cargo-binstall >/dev/null 2>&1; then
    CARGO_BUILD_JOBS=1 cargo install cargo-binstall --locked
fi

CARGO_BUILD_JOBS=1 make install-tools

CAPNP_PREFIX=/opt/capnp ./scripts/install-capnp.sh

make sync

export PYO3_PYTHON=/workspace/.venv/bin/python
python_base="$($PYO3_PYTHON -c 'import sys; print(sys.base_prefix)')"
python_lib_dir="$($PYO3_PYTHON -c 'import sysconfig; print(sysconfig.get_config_var("LIBDIR"))')"
ln -sfn "$python_base" /opt/nautilus-python
export PYTHONHOME="$python_base"
export LD_LIBRARY_PATH="$python_lib_dir${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
# uv-managed libpython is not on the default linker search path; LD_LIBRARY_PATH
# only affects runtime loading, not -lpython3.13 resolution during cargo builds.
export LIBRARY_PATH="$python_lib_dir${LIBRARY_PATH:+:$LIBRARY_PATH}"

prek install
make build-debug

printf '\nNautilusTrader development environment is ready.\n'
printf 'uv:      %s\n' "$(uv --version)"
printf 'rustc:   %s\n' "$(rustc --version)"
printf 'capnp:   %s\n' "$(capnp --version)"
printf 'prek:    %s\n' "$(prek --version)"
printf 'nextest: %s\n' "$(cargo nextest --version)"
