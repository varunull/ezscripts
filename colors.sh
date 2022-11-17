#!/bin/bash

#
# The following function prints a text using custom color
# -c or --color define the color for the print. See the array colors for the available options.
# -n or --noline directs the system not to print a new line after the content.
# Last argument is the message to be printed.
#
colorfulEcho () {

    declare -A colors;
    colors=(\
        ['black']='\E[0;47m'\
        ['red']='\E[0;31m'\
        ['green']='\E[0;32m'\
        ['yellow']='\E[0;33m'\
        ['blue']='\E[0;34m'\
        ['magenta']='\E[0;35m'\
        ['cyan']='\E[0;36m'\
        ['white']='\E[0;37m'\
        ['greenhigh']='\033[0;92m'\
    );

    local defaultMSG="No message passed.";
    local defaultColor="black";
    local defaultNewLine=true;
    local newLine=true;

    while [[ $# -gt 1 ]];
    do
        key="$1";
        case $key in
            -c|--color)
                color="$2";
                shift;
            ;;
            -n|--noline)
                newLine=false;
            ;;
            *)
                # unknown option
            ;;
        esac
        shift;
    done

    message=${1:-$defaultMSG};   # Defaults to default message.
    color=${color:-$defaultColor};   # Defaults to default color, if not specified.
    newLine=${newLine:-$defaultNewLine};

    echo -en "${colors[$color]}";
    echo -en "$message";
    if [ "$newLine" = true ] ; then
        echo "";
    fi
    tput sgr0; #  Reset text attributes to normal without clearing screen.

    return;
}

# Echo used to issue warnings
warnecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'yellow' "$@";
}

# Echo used to issue errors
errorecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'red' "$@";
}

# Echo used to display information
infoecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'blue' "$@";
}

# Echo used to show successful commands
successecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'green' "$@";
}

# Echo used to notify regarding ongoing operations
notifyecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'cyan' "$@";
}
