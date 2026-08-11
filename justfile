set quiet

install:
    #!/usr/bin/env bash
    set -euo pipefail

    read -r -p "NautilusTrader repository path: " repo
    if [[ -z "$repo" ]]; then
        echo "NautilusTrader repository path is required" >&2
        exit 1
    fi
    repo="${repo/#\~/$HOME}"

    "{{ justfile_directory() }}/bin/setup-nautilus-devcontainer" "$repo"

uninstall:
    #!/usr/bin/env bash
    set -euo pipefail

    read -r -p "NautilusTrader repository path: " repo
    if [[ -z "$repo" ]]; then
        echo "NautilusTrader repository path is required" >&2
        exit 1
    fi
    repo="${repo/#\~/$HOME}"

    "{{ justfile_directory() }}/bin/setup-nautilus-devcontainer" --uninstall "$repo"

reinstall:
    #!/usr/bin/env bash
    set -euo pipefail

    read -r -p "NautilusTrader repository path: " repo
    if [[ -z "$repo" ]]; then
        echo "NautilusTrader repository path is required" >&2
        exit 1
    fi
    repo="${repo/#\~/$HOME}"

    "{{ justfile_directory() }}/bin/setup-nautilus-devcontainer" --reinstall "$repo"
