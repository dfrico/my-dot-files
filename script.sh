#!/bin/bash

if [ `uname` = "Darwin" ]; then
    echo 'Yes'
elif [ `uname` = "Linux" ]; then
    echo `uname`
fi
