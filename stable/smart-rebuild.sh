#!/usr/bin/env bash

set -e

chartToBuild=$1
needsRebuild=false

# By default we don't refresh local cashe
depUpdateFalgs="--skip-refresh"

# If chart has any dependencies
if [ -f $chartToBuild/requirements.yaml ]; then
  # Go through all of them
  while read -r name version dep status ; do
    
    # if the dependency is local
    if [[ "$dep" =~ file://* ]]; then
      depPath="${dep#file://../}"
      
      # Get a newest file of the dependency
      newestDepFile=$(gfind $depPath -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")

      # Compare it with and mdate of dependency direcotry with 
      # mdate of saved dependency package in chart we want to rebuild
      depChartPackage=$(ls -t $chartToBuild/charts/$name-* | tail -1);
      if [ "$newestDepFile" -nt "$depChartPackage" ] || [ "$depPath" -nt "$depChartPackage" ] ; then
        echo "The dependency $depPath of chart $chartToBuild needs to be updated" ;
        needsRebuild=true ;
        break
      # else
      #   echo "$depPath is older then $chartToBuild" ;
      fi
    else
      # The full list of status values: https://github.com/helm/helm/blob/master/cmd/helm/dependency.go#L156
      # I'm not yet sure how to handle most of them
      if [[ "$status" == "ok" ]]; then
        # dont do anything
        :
      elif [[ "$status" == "wrong version" ]] || [[ "$status" == "missing" ]]; then
        echo "The dependency $name from repo $dep of chart $chartToBuild needs to be updated" ;
        # There is no way to upadte only one repo
        # remove --skip-refresh flag so cache is updated
        depUpdateFalgs=""
        # and set chart to be updated 
        needsRebuild=""
      else
        echo "ERROR: No idea what status '$status' means."
        exit 1
      fi
    fi
  done < <(helm dependency list "$chartToBuild" | sed -n 2,\$p | grep -v "^$") 

  # If the dependency changes we need to rebuild
  if $needsRebuild ; then
    helm dependency update $depUpdateFalgs $chartToBuild;
    helm package $chartToBuild
    exit 0
  fi
fi

# If the dependecny did not change the chart itself might have

# Get newest file of the chart
newestChartFile=$(gfind $chartToBuild -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")
#date -r $newestChartFile
#date -r $(ls -1t ${chartToBuild}-* | head -1)

# Compare it and mdata of chart directory with the newest local release of this chart
chartPackage="$(ls -1t ${chartToBuild}-* | head -1)"
if [ "$newestChartFile" -nt "$chartPackage" ] || [ "$chartToBuild" -nt "$chartPackage" ] ; then
  echo "Chart $chartToBuild need to be updated because it's content changed."
  helm package $chartToBuild
fi
