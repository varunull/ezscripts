#!/bin/bash


source setup/globalVars.sh || return 1;

# Source all the files
for i in $(find $EZSCRIPT_PATH -name "*.sh" | grep -v 'setupEzscripts.sh'); do
    source $i;
done
