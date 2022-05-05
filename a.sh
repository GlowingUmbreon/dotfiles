#!/bin/bash
_xbps-install() {
  local prefix="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(printf %s\\n `< ~/.local/share/xbps-completion-available` |
               awk -v IGNORECASE=1 -v p="$prefix" \
                   'p==substr($0,0,length(p))'))
}
complete -F _xbps-install -o filenames xbps-install

xbps-query --search blu --property="short_desc"
#  xbps-query --search blu --property="short_desc" |  sed '/([A-Za-z-]+)-/\2/'