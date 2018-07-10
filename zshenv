# Ensure that shell is loaded starting from a blank path
#
# https://github.com/rbenv/rbenv/issues/369

_not_inside_tmux() {
  [[ -z "$TMUX" ]]
}

_path_helper_exists() {
  [ -x /usr/libexec/path_helper ]
}

if _not_inside_tmux && _path_helper_exists; then
  PATH=""
  eval `/usr/libexec/path_helper -s`
fi
