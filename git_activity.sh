#!/bin/bash

DEFAULT_SINCE='1 week ago'
SINCE=$DEFAULT_SINCE

while getopts 's:' OPTION; do
  case "$OPTION" in
    s)
      SINCE="$OPTARG"
      ;;
    ?)
      echo "Script usage: $(basename \$0) [-s since]" >&2
      exit 1
      ;;
  esac
done

# echo "Git Activity"
# echo
pwd
# echo
# echo "git log --since="$SINCE" --pretty=format:"%an" | sort | uniq -c | sort -rn"
echo
git log --since="$SINCE" --pretty=format:"%an" | sort | uniq -c | sort -rn

