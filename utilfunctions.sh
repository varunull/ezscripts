#!/bin/bash

#
# FILE : utilFunctions.sh
# - The functions contained in this file are generic functions used
# - to speed up repetitive operations.
#


# Function that displays dotline
function dotline()
{
    if [[ -z $1 ]]; then
        echo -e "------------------------------------------------------------------------------------------------";
    else
        printf -- "-%.0s" $(seq 1 $1);
        echo ""
    fi
}


# Function to convert command output to array
function ctoarray()
{
    read -e -p "Enter the command : " val;

    readarray -t myArray < <(eval $val);
    declare -p myArray;

    dotline;
    echo "Array Name : myArray";
    echo 'Command    : for i in ${myArray[@]}; do echo $i; done';
    dotline
}

# Function to show a particular line number, or range of lines from a file
function shlines()
{
    if [[ -z $1 ]] || [[ -z $2 ]]; then
        echo -e "Argument 1 : Line Number\nArgument 2: File Name\n";
        return;
    fi

    if [[ -f $2 ]]; then
        sed -n "${1}p" ${2}
    else
        sed -n "${1},${2}p" $3
    fi
}

# Function that creates a grep string
function make_string()
{
    local str="*${1}"
    shift
    for var in "$@"
    do
        str="${str}*${var}";
    done
    echo "$str*"
}

# Function that creates a complete grep string
function make_fullstring()
{
    local str=".*${1}"
    shift
    for var in "$@"
    do
        str="${str}.*${var}";
    done
    echo "$str.*"
}


# Function used to find a file recursively from the current directory.
function ff()
{
    if [[ -z $1 ]]; then
        echo "Please enter the file name!";
        return;
    fi
    find . -iname "$1" -type f
}

#
# Function that is used to find a file recursively from the current directory
# with the extra functionality of creating a greppable string from the provided
# arguments.
# ex. `ffg king hel` : Will find the files as `find . -iname "*king*hel*"`
#
function ffg()
{
    if [[ -z $1 ]]; then
        echo "Please enter the file name pattern!";
        return;
    fi

    local string=$(make_string $@);
    find . -iname "$string" -type f
}

# Function that does grep in a useful way :P
function mgrep()
{
    if [[ -z $1 ]]; then
        redecho "Need an argument to grep!";
        return;
    fi

    grep -Rn --color "$1" *
}

#
# Function to show last usage of command, and if no argument is supplied,
# it shows the last 25 used commands
#
function slc()
{
    local cmdname=0;
    local cmdList=0;

    if [[ -z $1 ]]; then
        echo "Showing the last 25 commands...";
        cmdList=$(history | cut -c 8- | grep -v -E 'history|slc' | tail -n25);
        yellowecho "$cmdList"
        return;
    else
        cmdname=$1;
    fi

    local count=5;

    if [[ ! -z $2 ]] && [ "$2" -eq "$2" ] 2> /dev/null; then
        count=$2;
    fi

    cmdList=$(history | grep -v -E 'history|slc' | cut -c 8- | grep ^$cmdname | tail -n$count);

    if [[ -z $cmdList ]]; then
        redecho "No previously used commands found for : $cmdname";
        return 1;
    fi

    yellowecho "$cmdList"

}

# Function to add temporary aliases to the file set as TEMP_ALIAS_FILE
function addtemppath()
{
        alias "$1"="$2"
        echo "alias $1='$2'" >> $TEMP_ALIAS_FILE

        greenecho "[++] Alias added : $1"
}

# Function that converts the given argument to ascii
function toascii()
{
  printf "Dec = %d\nHex = 0x%x\n" "'$1" "'$1"
}

# Function that converts decimal to hex
function tohex()
{
  for i in $@; do
    printf "0x%x\n" $i;
  done
}

# Function that converts hex to decimal
function todec(){
 for i in $@; do
   if [[ ${i:0:2} -eq "0x" ]] 2>/dev/null; then
     echo $((i));
   else
     printf "%d\n" 0x$i;
   fi
 done
}

# Utility function that is internally used by findcmdusage function.
function printCommands()
{
  if [[ -z $1 ]]; then
    echo "[ERROR] Need a list of commands! Exiting...";
    return;
  fi

  readarray -t myA < <(echo "$1");
  declare -p myA >/dev/null;

  local counter=1;
  for i in "${myA[@]}"; do
    echo ""
    greenecho "Usage #$counter";
    dotline;
    yellowecho "$i";
    dotline;
    counter=$((counter+1))
  done
}

# Function that gives out the list of all functions that have help commands present.
function listcmdhelp()
{
  grep "</.*>" $COMMAND_HELP_FILE  | sed "s#</##g; s#>##g" | less
}


# Find all the usages of a particular command.
function findcmdusage()
{
  if [[ -z $1 ]]; then
    redecho "[ERROR] : Please enter command name as input.";
    yellowecho "[NOTE] : You can run 'cmdhelplist' command to see which which command usages are available."
    return;
  fi

  local cmdname=$1;

  # Check if the commands are actually present!
  local cmdList=$(sed -n "/<$cmdname>/,/<\/$cmdname>/p" $COMMAND_HELP_FILE);

  if [[ -z $cmdList ]]; then
    redecho -n "[ERROR] No command list found for command : "; echo $cmdname;
    return;
  fi

  # Output all the commands
  cmdList=$(echo "$cmdList" | sed "s#<$cmdname>##g; s#</$cmdname>##g;" | grep -v '^$');
  printCommands "$cmdList";

}

# Add the usage for a particular command.
function addcmdusage()
{
  if [[ -z $1 ]]; then
    echo "[ERROR] : Please enter command name as input.";
    return;
  fi

  if [[ -z $2 ]]; then
    echo "[ERROR] : Please enter the sample command!"
    return;
  fi

  local cmdname=$1;
  local cmdVal=$2;

  # Check if the commands are actually present!
  local cmdList=$(sed -n "/<$cmdname>/,/<\/$cmdname>/p" $COMMAND_HELP_FILE);

  if [[ -z $cmdList ]]; then
    yellowecho "[+] : No command list found for command : $cmdname";
    greenecho "[+] : Creating a new command list..."
    echo "" >> $COMMAND_HELP_FILE
    echo "<$cmdname>" >> $COMMAND_HELP_FILE
    echo $cmdVal >> $COMMAND_HELP_FILE;
    echo "</$cmdname>" >> $COMMAND_HELP_FILE;
  else
    cyanecho "[+] Command List found for : $cmdname"
    sed -i "/<\/$cmdname>/i $cmdVal" $COMMAND_HELP_FILE
    greenecho "[+] Command added!"
  fi
}
