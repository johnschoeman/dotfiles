#!/usr/bin/env bash
# Analyze git history to find files that are frequently modified together
#
# Usage: analyze_colocations.sh [OPTIONS] [MONTHS]
#   MONTHS: Number of months to look back (default: 6)
#
# Options:
#   --strip-prefix PREFIX   Remove PREFIX from file paths (e.g., notes-vault/)
#   --exclude PATTERN       Exclude files matching PATTERN (repeatable)
#
# Examples:
#   analyze_colocations.sh                           # Generic, 6 months
#   analyze_colocations.sh 3                         # Generic, 3 months
#   analyze_colocations.sh --strip-prefix notes-vault/ --exclude 'daily/dn_' --exclude 'daily/wk_' 3

set -euo pipefail

STRIP_PREFIX=""
EXCLUDE_PATTERNS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strip-prefix)
      STRIP_PREFIX="$2"
      shift 2
      ;;
    --exclude)
      EXCLUDE_PATTERNS+=("$2")
      shift 2
      ;;
    *)
      break
      ;;
  esac
done

MONTHS=${1:-6}
SINCE_DATE=$(date -d "$MONTHS months ago" +%Y-%m-%d 2>/dev/null || date -v-${MONTHS}m +%Y-%m-%d)

echo "Analyzing Git History for File Colocation Patterns..."
echo "Looking back $MONTHS months (since $SINCE_DATE)"
echo

total=$(git log --oneline --since="$SINCE_DATE" | wc -l)
echo "Analyzing $total commits"
echo

# Preprocess git log: apply default exclusions, extra exclusions, and prefix stripping.
# COMMIT: lines and blank lines pass through unchanged for awk to parse.
preprocess() {
  while IFS= read -r line; do
    # Pass through commit markers and blank lines
    if [[ "$line" == COMMIT:* ]] || [[ -z "$line" ]]; then
      printf '%s\n' "$line"
      continue
    fi

    # Default exclusions
    case "$line" in
      */_archive/*|*/.trash/*|*/.obsidian/*) continue ;;
    esac

    # Extra exclusions
    local skip=false
    for pattern in "${EXCLUDE_PATTERNS[@]+${EXCLUDE_PATTERNS[@]}}"; do
      if [[ "$line" == *"$pattern"* ]]; then
        skip=true
        break
      fi
    done
    if $skip; then continue; fi

    # Strip prefix
    if [[ -n "$STRIP_PREFIX" ]]; then
      line="${line#"$STRIP_PREFIX"}"
    fi

    printf '%s\n' "$line"
  done
}

echo "========================================================================"
echo "FILES FREQUENTLY MODIFIED TOGETHER (2+ times)"
echo "========================================================================"
echo

git log --since="$SINCE_DATE" --pretty=format:"COMMIT:%h" --name-only | preprocess | awk '
/^COMMIT:/ {
  if (n >= 2) {
    for (i = 1; i <= n; i++) {
      for (j = i+1; j <= n; j++) {
        f1 = files[i]
        f2 = files[j]
        if (f1 > f2) { tmp=f1; f1=f2; f2=tmp }
        print f1 "\t" f2
      }
    }
  }
  n = 0
  delete files
  next
}

/^$/ { next }

{
  files[++n] = $0
}

END {
  if (n >= 2) {
    for (i = 1; i <= n; i++) {
      for (j = i+1; j <= n; j++) {
        f1 = files[i]
        f2 = files[j]
        if (f1 > f2) { tmp=f1; f1=f2; f2=tmp }
        print f1 "\t" f2
      }
    }
  }
}
' | sort | uniq -c | sort -rn | awk '$1 >= 2' | head -30 | while read -r count file1 file2; do
  printf "%3d× %s\n" "$count" "$file1"
  printf "     ↔ %s\n\n" "$file2"
done

echo
echo "========================================================================"
echo "CROSS-DOMAIN PATTERNS (commits touching multiple domains)"
echo "========================================================================"
echo

git log --since="$SINCE_DATE" --pretty=format:"COMMIT:%h" --name-only | preprocess | awk '
/^COMMIT:/ {
  if (nd >= 2) {
    for (i = 1; i <= nd; i++) {
      for (j = i+1; j <= nd; j++) {
        d1 = domains[i]
        d2 = domains[j]
        if (d1 > d2) { tmp=d1; d1=d2; d2=tmp }
        print d1 "\t" d2
      }
    }
  }
  delete seen
  delete domains
  nd = 0
  next
}

/^$/ { next }

{
  split($0, parts, "/")
  if (length(parts) > 0) {
    domain = parts[1]
    if (!(domain in seen)) {
      domains[++nd] = domain
      seen[domain] = 1
    }
  }
}

END {
  if (nd >= 2) {
    for (i = 1; i <= nd; i++) {
      for (j = i+1; j <= nd; j++) {
        d1 = domains[i]
        d2 = domains[j]
        if (d1 > d2) { tmp=d1; d1=d2; d2=tmp }
        print d1 "\t" d2
      }
    }
  }
}
' | sort | uniq -c | sort -rn | head -20 | while read -r count d1 d2; do
  printf "%3d× %s ↔ %s\n" "$count" "$d1" "$d2"
done

echo
echo "========================================================================"
echo "INSIGHTS & NEXT STEPS"
echo "========================================================================"
echo
echo "What to look for:"
echo "  - Files from different domains modified together -> possible hidden project"
echo "  - Config files + specific domains -> config might belong closer to work"
echo "  - Planning files + work areas -> planning might belong closer to work"
echo
echo "Suggested actions:"
echo "  1. Look for surprising patterns above"
echo "  2. Try different time windows: analyze_colocations.sh 3 (or 12, 24, etc.)"
echo "  3. Re-run periodically to see how patterns evolve"
echo "  4. Consider grouping files that change together"
