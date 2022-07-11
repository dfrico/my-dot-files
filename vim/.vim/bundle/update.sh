#!/bin/sh

for d in ./*/ ; do (echo "$d"; cd "$d" && git checkout master && git pull); done
for d in ./*/ ; do (echo "$d"; cd "$d" && git checkout main && git pull); done
