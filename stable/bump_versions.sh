#!/usr/bin/env bash

#git ls-files | grep Chart.yaml | rev | cut -d '/' -f 2- | rev | xargs -I{} git --no-pager log -1 --pretty=medium -q {}
#`git ls-files | grep Chart.yaml | xargs -I{} git --no-pager blame  -L 2,2 {}

version_lt () {
    newest=$( ( echo "$1"; echo "$2" ) | sort -V | tail -n1)
    if [ "$1" != "$newest" ] ; then
      return "0"
    elif [ "$1" = "$newest" ]; then
      return "2"
    else 
      return "1"
    fi
    echo a
}

while read -r chart ; do

  echo "Processing: $chart"
  printf "  Last chart modification:   "
  chartDate=$(git --no-pager log -1 --pretty=format:"%ad" --date=raw -q $chart | cut -d ' ' -f 1)
  git --no-pager log -1 --pretty=format:"%H | %aN | %ad | message: %B" -q $chart | perl -p -e 'chomp if eof' | perl -p -e 'chomp if eof' ; echo ""
  printf "  Last version modification: "
  git --no-pager log -1 --pretty=format:"%H | %aN | %ad | message: %B" -q -L 2,2:"$chart/Chart.yaml" | head -n1 |
  versionDate=$(git --no-pager log -1 --pretty=format:"%ad" --date=raw -q -L 2,2:"$chart/Chart.yaml" | head -n1 | cut -d ' ' -f 1)

  currentVersion=$(git --no-pager blame  -L 2,2 $chart/Chart.yaml  | cut -d $')' -f 2 | cut -d ' ' -f '3')
  lastCommitedVersion=$(git --no-pager log -1 --pretty=format:"%ad" --date=raw -q -L 2,2:"$chart/Chart.yaml" | sed -n '7p' | cut -d ' ' -f '2')
  
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color
  printf "$chartDate | $versionDate | "
  version_lt "$lastCommitedVersion" "$currentVersion"
  version_compare=$?
  case $version_compare in
    0) message="${GREEN}CurrentVersion $currentVersion is newer then lastCommitedVersion $lastCommitedVersion${NC}." ;;
    1) message="${RED}CurrentVersion $currentVersion is older then lastCommitedVersion $lastCommitedVersion${NC}." ;;
    2) message="CurrentVersion $currentVersion is same as then lastCommitedVersion $lastCommitedVersion." ;;
    *) message="[$(version_lt $lastCommitedVersion $currentVersion)]$?"
  esac
  if git --no-pager blame -L 2,2 "$chart/Chart.yaml" | grep -q "Not Committed Yet" ; then
    echo -e "${GREEN}Version modified and not commited! Make sure it's ok${NC} ! | $message"
  else
    if [ $chartDate -eq $versionDate ]; then
      echo -e "Version mtime and charts are the same. | $message"
    elif [ $chartDate -ge $versionDate ]; then
      echo -e "${RED}Chart is never then version: need to bump version!${NC} | $message"
    else
      echo "Version is never then chart. SOMETHING IS VERY WRONG! | $message"
    fi
  fi
  echo ""
done < <(git ls-files | grep Chart.yaml | rev | cut -d '/' -f 2- | rev )