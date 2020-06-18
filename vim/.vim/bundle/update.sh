#!/bin/sh

for d in ./*/ ; do (cd "$d" && git checkout master && git pull); done
