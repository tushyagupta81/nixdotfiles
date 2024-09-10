#!/usr/bin/env fish

argparse -- $argv

if not test "$argv"
  source "$HOME/.virtualenv/base/bin/activate.fish"
else if not test -d "$HOME/.virtualenv/$argv"
  echo "Virtual environment does not exist."
else if test -d "$HOME/.virtualenv/$argv"
  source "$HOME/.virtualenv/$argv/bin/activate.fish"
end
