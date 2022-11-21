#!/bin/bash

if [[ -z $EZSCRIPT_PATH ]]; then
    echo "The variable EZSCRIPT_PATH is not set. Please set it to the path of the ezscript project!";
    return 1;
fi

source $EZSCRIPT_PATH/setup/globalVars.sh;

if [[ $? -ne 0 ]]; then
    echo "Setup Failed! Exiting...";
    return 1;
fi

# Source all the files
for i in $(find $EZSCRIPT_PATH -name "*.sh" | grep -v 'setupEzscripts.sh'); do
    source $i;
done
