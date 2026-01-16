# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
export TZ="America/Argentina/Buenos_Aires"
export PATH=$HOME/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Home Manager session variables
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
