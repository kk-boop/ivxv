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
