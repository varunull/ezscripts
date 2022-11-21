#!/bin/bash

if [[ -z $EZSCRIPT_PATH ]]; then
    echo "The variable EZSCRIPT_PATH is not set. Please set it to the path of the ezscript project!";
    return 1;
fi

if [[ ! -f $EZSCRIPT_PATH/setup/globalVars.sh ]]; then
    echo "[ERROR] : The EZSCRIPT_PATH is incorrectly set! Please set it to the project directory";
    return 1;
else
    source $EZSCRIPT_PATH/setup/globalVars.sh;
fi

# Source all the files
for i in $(find $EZSCRIPT_PATH -name "*.sh" | grep -v 'setupEzscripts.sh'); do
    source $i;
done
