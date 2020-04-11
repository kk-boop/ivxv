#!/bin/sh

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

cd $dir

mkdir output/en
mkdir output/et

cd $dir/Documentation/en

make

cd _build/pdf
mv ./*.pdf $dir/output/en/

cd $dir/Documentation/et

make
cd _build/pdf
mv ./*.pdf $dir/output/et/

cd $dir/output
zip -j et_documentation.zip et/*
zip -j en_documentation.zip en/*

if [ ! -z "$GITHUB_TOKEN" ];
then

curl -X POST -H "Authorization: token $GITHUB_TOKEN" -H "Content-Length: $(stat -c%s "et_documentation.zip")" -H "Content-Type: application/zip" --upload-file et_documentation.zip "https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=et_documentation.zip"
curl -X POST -H "Authorization: token $GITHUB_TOKEN" -H "Content-Length: $(stat -c%s "en_documentation.zip")" -H "Content-Type: application/zip" --upload-file en_documentation.zip "https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=en_documentation.zip"

fi
