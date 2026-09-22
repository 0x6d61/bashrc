#!/usr/bin/env bash
# Install ~/.bashrc as a small loader for this repository.
# Use `source ./install.sh` when the setting should take effect immediately.

repository_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
shared_config="${repository_dir}/.bashrc"
target_config="${HOME}/.bashrc"

if [[ ! -f "${shared_config}" ]]; then
  printf 'Error: %s does not exist.\n' "${shared_config}" >&2
  return 1 2>/dev/null || exit 1
fi

# Write first to a temporary file, then replace ~/.bashrc in one operation.
temporary_config="$(mktemp "${target_config}.tmp.XXXXXX")" || {
  printf 'Error: Could not create a temporary .bashrc.\n' >&2
  return 1 2>/dev/null || exit 1
}
trap 'rm -f -- "${temporary_config}"' EXIT
{
  cat <<'EOF'
# Managed by https://github.com/0x6d61/bashrc
# Put machine-specific settings in ~/.bashrc.local.

# .bashrc is only for interactive shells.
case $- in
  *i*) ;;
  *) return ;;
esac

EOF
  # %q emits a Bash-safe, quoted path even if the clone path contains spaces.
  printf 'source %q\n' "${shared_config}"
  cat <<'EOF'

if [[ -r "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi
EOF
} > "${temporary_config}"

mv -- "${temporary_config}" "${target_config}"
trap - EXIT
printf 'Installed loader at %s\n' "${target_config}"

if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  source "${target_config}"
  printf 'Installed and applied .bashrc to this shell.\n'
else
  printf 'Installed. Run: source ~/.bashrc\n'
fi

unset repository_dir shared_config target_config temporary_config
