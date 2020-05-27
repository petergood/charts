#!/usr/bin/env bash

while read f ; do
  echo git checkout "$f"
done < <(find . -iname "requirements.lock")
