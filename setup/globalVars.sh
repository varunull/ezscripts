#!/bin/bash

#
# FILE : globalVars.sh
# This file used to set the global variables. All the functions
# will be using these variables for their operation.
#

# Main project path.
PROJECT_PATH=$EZSCRIPT_PATH

#
# File that stores the temporary alias.
# Used by functions :
# - addtemppath
#
if [[ ! -d ${PROJECT_PATH}/database ]]; then
    mkdir ${PROJECT_PATH}/database || return 1;
fi

TEMP_ALIAS_FILE=${PROJECT_PATH}/database/temporaryAliases.sh

if [[ ! -f $TEMP_ALIAS_FILE ]]; then
    touch $TEMP_ALIAS_FILE
fi

#
# File that stores the command usages stored by the user
# Used by functions :
# - addcmdusage
# - findcmdusage
#
COMMAND_HELP_FILE=${PROJECT_PATH}/database/toolcommands.txt

if [[ ! -f $COMMAND_HELP_FILE ]]; then
    touch $COMMAND_HELP_FILE
fi

#
# [ezscript] File that is used to retrive the usages for ezscript functions!
#
FUNCTION_DESCRIPTION_FILE=${PROJECT_PATH}/setup/funcDescription.txt
