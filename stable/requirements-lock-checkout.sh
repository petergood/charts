#!/usr/bin/env bash

while read f ; do
  git checkout "$f"
done < <(find . -iname "requirements.lock")
