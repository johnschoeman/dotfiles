#!/bin/bash

end_date=$(date +%Y-%m-%d)
start_date=$(date -d "1 week ago" +%Y-%m-%d)

# end_date=$(date -d "1 week ago" +%Y-%m-%d)
# start_date=$(date -d "2 weeks ago" +%Y-%m-%d)

# start_date="2025-02-23"
# end_date="2025-03-01"

projects=(
"project-x:main"
"express-host:devel"
"express-ui:main"
"expedite-sysimage:main"
"expedite-packaging-tools:main"
"express-sqa:master"
"evolv-sensor-fakes:main"
"android-pwa-wrapper:master"
"evolv-mobile:main"
"evolv-portal:main"
"evolv-lambdas:main"
"evolv-portal-rest-api:main"
"evolv-terra:main"
"evolv-portal-e2e-sqa:main"
"dotnet-manufacturing:main"
"dotnet-common:main"
"diags-internal:main"
)


# echo "Git Activity : $start_date - $end_date"
# echo "----"


function commits() {
  git log --since="$start_date" --until="$end_date" --oneline | wc -l
}

function project_activity() {
  local dir_branch="$1"

  IFS=':' read -r dir branch <<< "$dir_branch"
  echo "$dir ($branch)"
  cd $dir
  git checkout $branch &> /dev/null
  git pull &> /dev/null
  commits
  cd ..
}

# echo "Projects:"
# echo 

for dir_branch in "${projects[@]}"; do
  project_activity "$dir_branch"
done
