set shell := ["zsh", "-cu"]

default:
  just --list

recipe-name:
  echo 'This is a recipe!'

# this is a comment
another-recipe:
  @echo 'This is another recipe.'

[working-directory: 'Documents/kb-obsidian']
sync-kb:
  git add .
  git commit -m "$(date +%Y-%m-%dT%H:%M:%S%z)" || true
  git pull --rebase
  git push

install-syncthing:
  #!/bin/bash
  set -euo pipefail
  mkdir -p ~/.config/containers/systemd
  cat <<EOF > ~/.config/containers/systemd/syncthing.container
  [Unit]
  Description=Syncthing Container
  
  [Container]
  Image=docker.io/syncthing/syncthing:latest
  AutoUpdate=registry
  Volume=%h/Documents:/data1
  Volume=%h/.config/syncthing:/var/syncthing/config
  PublishPort=8384:8384
  PublishPort=22000:22000/tcp
  PublishPort=22000:22000/udp
  PublishPort=21027:21027/udp
  Environment=TZ=America/Denver
  SecurityLabelDisable=true
  HostName=%H
  UserNS=keep-id
  
  [Service]
  Restart=always
  
  [Install]
  WantedBy=default.target
  EOF
  mkdir -p ~/.config/syncthing
  systemctl --user daemon-reload
  echo 'Hello World'

cm-add file:
  chezmoi add {{file}}

cm-managed:
  chezmoi managed

cm-edit file:
  chezmoi edit {{file}}

cm-apply:
  chezmoi apply -v

cm-setup:
  chezmoi init git@github.com:green-leader/dotfiles.git

sync: sync-kb cm-apply
  echo "kb and chezmoi sync"
