#!/usr/bin/env bash
set -e

pipenv run make html
rm -f .git/index
git clean -fdx -e _build
mv _build/html/* ./
touch .nojekyll
rm -rf _build
