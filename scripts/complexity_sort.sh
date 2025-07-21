# complexity_sort.sh
#
# Sort directory files by complexity
#
# Usage: ./complexity_sort.sh <directory>

complexity --only $1 | sort
