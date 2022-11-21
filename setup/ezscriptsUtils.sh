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
yellowecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'yellow' "$@";
}

# Echo used to issue errors
redecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'red' "$@";
}

# Echo used to display information
blueecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'blue' "$@";
}

# Echo used to show successful commands
greenecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'green' "$@";
}

# Echo used to notify regarding ongoing operations
cyanecho(){
    local newLine=0;
    if [[ $1 == '-n' ]]; then
        newLine=$1;
        shift;
    fi
    colorfulEcho $newLine -c 'cyan' "$@";
}

#
# [ezscript] Utility function to show different command usages. This
# function uses the $FUNCTION_DESCRIPTION_FILE to fetch the usages
# and the function info
#
function getAttr()
{
    grep -oP "(?<=<$1>).*(?=</$1>)" <<<"$2"
}

function printFunctionInfo()
{
    local shortInfo=0;
    local funcDesc=0;
    echo ""

    blueecho -n "$2"

    shortInfo=$(getAttr "shortInfo" "$1");
    echo -e " : $shortInfo\n"

    funcDesc=$(getAttr "desc" "$1");
    cyanecho "Description --"
    echo "$funcDesc"
}

function printFunctionUsage()
{
    if [[ -z $1 ]]; then
        echo "[ERROR] Need a list of commands! Exiting...";
        return;
    fi;
    readarray -t myA < <(echo "$1");
    declare -p myA > /dev/null;
    for i in "${myA[@]}";
    do
        echo "";
        local cmdPurp=$(getAttr "cmdPurp" "$i");
        local actualCommand=$(getAttr "cmd" "$i");
        greenecho "- $cmdPurp";
        dotline;
        yellowecho "$actualCommand";
        dotline;
    done
}


function showusage()
{
    if [[ -z $1 ]]; then
        redecho "Enter the function name as the argument!";
        return
    fi

    local completeDescription=0;
    local usages=0;

    completeDescription=$(sed -n "/<$1>/,/<\/$1>/p" $FUNCTION_DESCRIPTION_FILE);

    if [[ -z $completeDescription ]]; then
        redecho -n "[ERROR] No usage found for the function : "; echo $1;
        return;
    fi

    printFunctionInfo "$completeDescription" "$1"

    usages=$(sed -n "/<usages/,/<\/usages>/p" <<< "$completeDescription" \
            | sed "s#<usages>##g; s#</usages>##g;" \
            | grep -v '^$');

    printFunctionUsage "$usages"
}
##################################################33

#
# [ezscript] Utility function to show currently supported functions. This
# function uses the $FUNCTION_DESCRIPTION_FILE to fetch the functions
# and their info
#
function printInBanner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    echo -e "\n$edge"
    yellowecho "$msg"
    echo "$edge"
}

function printFunctionInfoOneliner ()
{
    local shortInfo=0;
    local funcDesc=0;
    local shortInfo=$(getAttr "shortInfo" "$1");
    local format=" %-39s | %-80s | %-50s\n"
    printf "$format" `blueecho -n "$2"` "$shortInfo" "`greenecho -n 'showusage'` $2"
}


function showfunclist()
{
    # Print the header
    printInBanner "Currently supported functions"
    local header="\n %-20s %19s %90s\n";
    printf "$header" "Function Name" "Description" "Show Detailed Usage";
    dotline 160;

    # Fetch the currently added function usages.
    local funclist=0;
    funclist=$(grep --color -B 1 '<shortInfo>' $FUNCTION_DESCRIPTION_FILE | grep "^<[^>]*>$" | sed "s#<##g; s#>##g");
    readarray -t myB < <(echo "$funclist");
    declare -p myB > /dev/null;

    # Loop through each function and display its description
    for i in "${myB[@]}"; do
        local completeDescription=0;
        local usages=0;
        completeDescription=$(sed -n "/<$i>/,/<\/$i>/p" $FUNCTION_DESCRIPTION_FILE);
        if [[ -z $completeDescription ]]; then
            redecho -n "[ERROR] No usage found for the function : ";
            echo $1;
            return;
        fi;
        printFunctionInfoOneliner "$completeDescription" "$i";
    done
    dotline 160;
    echo ""
}
#########################################################
