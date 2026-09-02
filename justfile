set shell := ["zsh", "-cu"]

default:
  just --list

recipe-name:
  echo 'This is a recipe!'

# this is a comment
another-recipe:
  @echo 'This is another recipe.'

[working-directory: 'Documents/kb-obsidian']
[doc('sync the obsidian vault')]
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

[doc('track a file with chezmoi')]
cm-add file:
  chezmoi add {{file}}

[doc('show files tracked by chezmoi')]
cm-managed:
  chezmoi managed

[doc('edit a file already tracked and managed by chezmoi')]
cm-edit file:
  chezmoi edit {{file}}
  chezmoi apply

cm-update:
  chezmoi update -v

[doc('onboard device with chezmoi')]
cm-setup:
  brew install chezmoi
  chezmoi init git@github.com:green-leader/dotfiles.git

[doc('sync knowledgebase and chezmoi')]
sync: sync-kb cm-update
  echo "kb and chezmoi sync"

[doc('search and kill all the processes matching the argument')]
killall process:
  kill $(ps aux | grep {{process}} | awk '{print $2}')

[doc('run the restic command to run a backup creating a new snapshot')]
backup:
  restic -r rest:http://cliff.sions.org:8000/ backup ~/ --exclude ~/.cache --exclude-caches -x
