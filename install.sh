#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if [[ -n "${CODESPACES+x}" ]]; then
wget -O /home/codespace/.local/bin/git-sync https://gist.githubusercontent.com/green-leader/862d0ccfc5cf82fc650da54fe14d5ff5/raw/ef709d69cdfdc1a1142a30730baa2bb6b52b17fe/sync.sh
chmod +x /home/codespace/.local/bin/git-sync
fi

if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  echo "Installing chezmoi to '${chezmoi}'" >&2
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  unset chezmoi_install_script bin_dir
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"