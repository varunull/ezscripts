#!/bin/bash


source globalVars.sh || return 1;

# Source all the files
for i in $(ls $EZSCRIPT_PATH/*.sh | grep -v 'setupEzscripts.sh'); do
    source $i;
done
