# ezscripts
ezscripts is a compilation of various bash functions written to speed up the manual processes involved while working on Unix based systems. Functions will be regularly added for a diverse number of use cases ranging from file operation to penetration testing automation.

## Currently supported shells
+ Bash

## Setup
1. Pull the repository using : `git clone https://github.com/varunull/ezscripts.git`
2. Go the **ezscripts** directory, and run : `export EZSCRIPT_PATH=$PWD; source setupEzscripts.sh`
3. If all goes well in the first two steps without any errors, then in the **~/.bashrc** file, add the following command :
`export EZSCRIPT_PATH=<YOUR_PROJECT_DIR>; source $EZSCRIPT_PATH/setupEzscripts.sh`

## Usage
To see all available functions in a quick glance, run `showfunclist` after setup completes.

### For detailed usage of a particular function, use :
`showusage <function_name>`
