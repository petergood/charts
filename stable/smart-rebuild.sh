#!/usr/bin/env bash

chartToBuild=$1
needsRebuild=false

# If chart has any dependencies
if [ -f $chartToBuild/requirements.yaml ]; then
  # Go through all of them
  while read -r name dep ; do
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
  done < <(helm dependency list "$chartToBuild" | sed -n 2,\$p | grep -v "^$" | cut -f 1,3) 

  # If the dependency changes we need to rebuild
  if $needsRebuild ; then
    helm dependency update --skip-refresh $chartToBuild;
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
