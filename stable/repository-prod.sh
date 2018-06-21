#!/usr/bin/env bash

while read f ; do
  sed -i 's#\(repository:\) file://../.*#\1 https://onedata.github.io/charts/#' $f ;
done < <(find . -name requirements.yaml)
