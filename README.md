# NautilusTrader Dev Container

Installs a clone-local Dev Container configuration without adding files to the NautilusTrader
repository or changing its tracked `.gitignore`.

## Requirements

- Docker Desktop or another Docker Engine
- Visual Studio Code with the Dev Containers extension
- [`just`](https://github.com/casey/just)
- Python 3
- A local NautilusTrader clone

## Install

Clone this repository, enter it, and run:

```bash
just install
```

Enter the path to your NautilusTrader repository when prompted.

After installation, open the NautilusTrader repository in Visual Studio Code and run:

```text
Dev Containers: Reopen in Container
```

## Uninstall

To remove the local `.devcontainer/` directory and its clone-local Git exclude rule, run:

```bash
just uninstall
```

## Reinstall

To delete and reinstall the local `.devcontainer/` directory from the latest template, run:

```bash
just reinstall
```

Enter the NautilusTrader repository path and confirm destructive operations when prompted. Docker
containers, images, and named volumes are not deleted by either recipe.
