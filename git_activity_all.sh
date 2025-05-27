#!/bin/bash

today=$(date +%Y-%m-%d)
week_ago=$(date -d "1 week ago" +%Y-%m-%d)

# today="2025-04-05"
# week_ago="2025-03-29"

expedite_directories=(
"project-x:main"
"expedite-sysimage:main"
"expedite-packaging-tools:main"
"evolv-core-expedite-modules:main"
"evolv-core-expedite-infra:main"
"expedite-diagnostics:main"
# "expedite-osimage-signer-results:main"
)

express_directories=(
"express-host:devel"
"express-sysimage:main"
"adc-spi-code:main"
"express-sqa:master"
"software-update-package:main"
"rosetta-stone:main"
"express-release-tools:main"
# "osimage-signer-results:main"
)

evolv_ui_directories=(
"express-ui:main"
"evolv-sensor-fakes:main"
"android-pwa-wrapper:master"
)

portal_directories=(
"evolv-mobile:main"
"evolv-portal:main"
"evolv-lambdas:main"
"evolv-portal-rest-api:main"
"evolv-terra:main"
"evolv-portal-e2e-sqa:main"
)

production_tools_directories=(
"dotnet-manufacturing:main"
"dotnet-common:main"
"diags-internal:main"
)


echo "Git Activity : $week_ago - $today"
echo "----"
echo


function commits() {
  git log --since="$week_ago" --pretty=format:"%an" | sort | uniq -c | sort -rn

  # git log --since="$week_ago" --pretty=format:"%an" --shortstat

  # | awk 'NF==3 { add[$3] += $1; delete[$3] += $2 } END { for (author in add) { print author, "added:", add[author], "removed:", delete[author] } }'

  # | awk 'NF==3 { add[$3] += $1; delete[$3] += $2 } END { for (author in add) { print author, "added:", add[author], "removed:", delete[author] } }'
}

function project_activity() {
  local dir_branch="$1"

  IFS=':' read -r dir branch <<< "$dir_branch"
  echo "Project: $dir ($branch)"
  echo
  cd $dir
  git checkout $branch &> /dev/null
  git pull &> /dev/null
  commits
  cd ..
  echo
}

echo "Expedite:"
echo

for dir_branch in "${expedite_directories[@]}"; do
  project_activity "$dir_branch"
done
echo "--------"
echo

echo "Express:"
echo
for dir_branch in "${express_directories[@]}"; do
  project_activity "$dir_branch"
done
echo "--------"
echo

echo "Evolv UI:"
echo
for dir_branch in "${evolv_ui_directories[@]}"; do
  project_activity "$dir_branch"
done
echo "--------"
echo

echo "Portal:"
echo
for dir_branch in "${portal_directories[@]}"; do
  project_activity "$dir_branch"
done
echo "--------"
echo

echo "Production Tools:"
echo
for dir_branch in "${production_tools_directories[@]}"; do
  project_activity "$dir_branch"
done
echo "--------"
echo
