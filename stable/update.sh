#!/usr/bin/env bash

set -e

# Chart that nas dependences in a need of updating
chart=$1

# Chart that changed, dependency of a $chart
dependent_chart=$2


charts_home=/Users/orzech/Dropbox/home/repos/charts/stable
#version=$(grep version:  $chart/Chart.yaml | tr -s ' ' | cut -d ' ' -f 2)
#echo "Chart $chart-$version"

#dep_version=$(grep version:  $dependent_chart/Chart.yaml | tr -s ' ' | cut -d ' ' -f 2)
#echo "Child chart $dependent_chart-$dep_version"


# do while workaround
need_update=true
while : ; do
  $need_update || break
  need_update=false

# while read chart ; do
#   if ! $git diff-index HEAD --quiet $charts_home/$chart/requirements.lock ; then
#     echo -n "$chart requirements lock has changed."
#     if $git diff-index HEAD --quiet $charts_home/$chart/Chart.yaml ; then
#       echo " But the version of $chart did not changed!"
#       $git --no-pager diff $charts_home/$chart/requirements.lock
#     else
#       echo ""
#     fi
#   fi
# done < <(find $charts_home -name requirements.lock | cut -d '/' -f2 | xargs -I{} grep "^name:" {}/Chart.yaml | tr -d ' ' | cut -d ':' -f 2)
git="git -C $charts_home"
while read chart ; do
  if ! $git diff-index HEAD --quiet $chart ; then
    echo -n "$chart has changed: "
    $git --no-pager diff  --color=always -U0 --word-diff $chart/Chart.yaml | sed '1,/@@/d' | { grep --color=never '^version' || true ; }
    # if chart has changed but it version has not, bump it
    if $git diff-index HEAD --quiet $chart/Chart.yaml ; then
      old_version=$(grep version: $charts_home/$chart/Chart.yaml | tr -s ' ' | cut -d ' ' -f 2)
      minor=${old_version##*.}
      echo "|$minor|"
      ((minor++))
      echo "|$minor|"
      new_version="${old_version%.*}.$minor"
      echo " But the version of $chart did not changed! Bumping $old_version -> $new_version"
      sed -i "s/version:.*/version: $new_version/" $charts_home/$chart/Chart.yaml
    else
      :
    fi
  else 
    if ! $git ls-files $chart  --error-unmatch >/dev/null 2>&1 ; then
      echo "Chart $chart is not tracked by git!"
    fi 
  fi
done < <(find $charts_home -name Chart.yaml | rev | cut -d '/' -f2- | rev | xargs -I{} grep "^name:" {}/Chart.yaml | tr -d ' ' | cut -d ':' -f 2)

echo ""
while read chart ; do
  if ! $git diff-index HEAD --quiet $chart/requirements.yaml ; then
    echo -n "$chart requirements has changed."
    $git --no-pager diff  --color=always -U1 --word-diff -z $charts_home/$chart/requirements.yaml | sed '1,/@@/d' | tr  '\n' ','
    if $git diff-index HEAD --quiet $charts_home/$chart/Chart.yaml ; then
      echo " But the version of $chart did not changed!"
      $git --no-pager diff $charts_home/$chart/requirements.yaml
    else
      echo ""
    fi
  fi


  while read dependency ; do
    IFS='=' read -r -a old_versions <<< $(sed -n "/name: $dependency/,/  version:/ {
          s/\s*alias:\s*\(.*\)/\1/p
          s/\s*version:\s*\(.*\)/\1=/p
          }" "$charts_home/$chart/requirements.yaml" | tr '\n' ' ')
    unset 'old_versions[${#old_versions[@]}-1]'
    current_version=$(grep version: $dependency/Chart.yaml | tr -s ' ' | cut -d ' ' -f 2)
    for pair in "${old_versions[@]}" ; do
      read alias old_version <<< "$pair"
      [[ "$old_version" == "" ]] && old_version="$alias" && alias=""
      if [[ "$old_version" != "$current_version" ]]; then
       
       if [[ "$alias" != "" ]] ; then

        sed -i "/name: $dependency/,/  version:/ {
              /alias: $alias/,/  version:/ {
                s/\(\s*\)version:\s*.*/\1version: $current_version/
              }
              }" "$charts_home/$chart/requirements.yaml"
       else
        sed -i "/name: $dependency/,/  version:/ {
              s/\(\s*\)version:\s*.*/\1version: $current_version/
              }" "$charts_home/$chart/requirements.yaml"
        fi

        echo ""
        [[ "$alias" != "" ]] && alias=" (alias: $alias)"
        echo "$chart has a dependency=$dependency$alias of version=$old_version with newest version being current_version=$current_version. Replacing..."

        need_update=true
      fi
    done

  done < <(sed  -n "s/\s*-\s*name:\s*\(.*\)/\1/p" $charts_home/$chart/requirements.yaml | uniq)
done < <(find $charts_home -name requirements.yaml | rev | cut -d '/' -f2- | rev | xargs -I{} grep "^name:" {}/Chart.yaml | tr -d ' ' | cut -d ':' -f 2)

done

a() {
  local dependency
  local chart
  local to_upgrade
  local indent=$2
  local old_v
  local new_v

  chart=$1



  printf "%-${indent}s" " " ; echo "Processing dependencies of a chart $chart"
  while read dependency ; do

    # if we encounter a chart that needs updating
    if [[ "$dependent_chart" == "$dependency" ]]; then
      old_version=$(sed  -n "/name: $dependency/,+1 {
        s/\s*version:\s*\(.*\)/\1/p
        }" "$chart/requirements.yaml")
      printf "%-${indent}s" " " ; echo -n "Found version ($old_version) of $dependent_chart in dependencies of $chart. "
      if [[ "$old_version" != "$dep_version" ]]; then
        echo "Upgrading $dependency from $old_version to $dep_version"
        sed -n "/name: $1/{N;s/\(version: $old_version\).*/\1$dep_version/p}" "$chart/requirements.yaml"
        to_upgrade=1
      else
        echo "$dependency: has the newest version ($old_version) of $dependent_chart"
        to_upgrade=0
      fi
    else
      printf "%-${indent}s" " " ;  echo "Found different dependency=$dependency. Checking of that dependency also needs to update $$dependent_chart to version $dep_version."
      (( indent+=3 ))
      a "$dependency" $indent
      (( indent-=3 ))
      if (( $to_upgrade )); then
        old_v=$(sed  -n "s/\.*version:\s*\(.*\)/\1/p" $dependency/Chart.yaml)
        local last
        last=${old_v##*.}
        (( last++ ))
        new_v="${old_v%.*}.$last"
        #sed -n "s/\(\.*version:\s*\).*/\1${new_v}/p" $lrequirements/Chart.yaml
        printf "%-${indent}s" " " ; echo "Upgraded $dependency from $old_v to $new_v"
      #  a "$lrequirements" "$2"
      else
        printf "%-${indent}s" " " ; echo "Upgrade of $dependency is not necessary"
      fi
    fi
  done < <(sed  -n "s/\s*-\s*name:\s*\(.*\)/\1/p" $chart/requirements.yaml | uniq)
}

#a "$chart" 1

# while read requirements ; do
#   chart_name="${requirements%/*}"
#   grep  "$requirements"
#   old_version=$(sed  -n "/name: $1/,+1 {
#     s/\s*version:\s*\(.*\)/\1/p
#     }" volume-nfs/requirements.yaml)
 
#   echo "$chart_name: upgrading $1 from $old_version to $version"
#   sed  -n "/name: $1/{N;s/\(version: \).*/\1$version/p}" "$requirements"
# done < <(grep "name:.* $1" -l -r */requirements.yaml)

exit 0


echo "Building and packaging ${chart}..."
make build-$chart

echo "Cloning helm registry..."
TMP_DIR=$(mktemp -d)
$git clone -b gh-pages $git@$github.com:groundnuty/onedata-charts.$git "$TMP_DIR"

echo "Copying package $chart-$version.tgz to helm registry..."
if [[ -f "$TMP_DIR/$chart-$version.tgz" ]]; then
  echo "Package exists in the registry. Aborting..."
  rm -rf "$TMP_DIR"
  exit 1
fi
cp "$chart-$version.tgz" "$TMP_DIR/"

current=$PWD
cd "$TMP_DIR/"
helm repo index .  --url https://onedata.$github.io/charts/
cd $current

$git -C "$TMP_DIR" status
echo "Adding all changes to commit..."
$git -C "$TMP_DIR" add -A

$git -C "$TMP_DIR" status
$git -C "$TMP_DIR" commit -m "released chart $chart $version"
$git -C "$TMP_DIR" push

rm -rf "$TMP_DIR"
rm "$chart-$version.tgz"
