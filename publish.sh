#!/bin/bash -e

version="${1:?version}"

if [[ ${version:?} == v* ]]
then
  >&2 echo "Please provide only numbers separated by dots"
  exit 1
fi

git tag -m "Tag v${version:?}" -a "v${version}" "$(git rev-parse HEAD)"
git push --follow-tags
