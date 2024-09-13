#!/usr/bin/env bash

curl --proto '=https' --tlsv1.2 -sSf \
  -L https://install.determinate.systems/nix \
  | sh -s -- install

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo chown -R "$USER" /nix

$HOME/nixdotfiles/scripts/switch-nix

echo "Changing default shell to fish"
echo "$(which fish)" | sudo tee -a /etc/shells >/dev/null
# Set the Homebrew fish as default shell
chsh -s "$(which fish)"
