# ezscripts
ezscripts is a compilation of various bash functions written to speed up the manual processes involved while working on Unix based systems. Functions will be regularly added for a diverse number of use cases ranging from file operation to penetration testing automation. 

## Currently supported shells
+ Bash

## Setup
To initialize the setup for all the contained functions, just execute `source setupEzscripts.sh`. If there are no errors encountered, it means all the functions have been sourced and are ready to be used.

## Generic Utility functions
#### slc : show last commands
Utility to check the most recent usages of a particular tool. Particularly saves the manual work of parsing through the history to find the usages. The number of commands shown in the output can be controlled via the arguments. 
Usage :
1. `slc grep 3` : Show the latest **three** usages of **grep** command
2. `slc find` : Show all the usages of **find** command that are present in the bash_history
---

#### ff : find files
This function internally used the find tool to find for files recursively in the current directory

`ff rockyou.txt` : Find the file **rockyou.txt** recursively in all the folders of the current directory

---

#### ffg : find files using grep
This function creates a wildcard string using the arguments, and then the resultant string is used to search for the files recursively in the current directory

`ffg lema jack` : Find the file names with pattern **\*lema\*jack\*** recursively in the current directory

---

#### findcmdhelp : find command help
This function takes a tool name as the argument and lists down all the examples of usages of it. (These usages were stored to and file using the related command - addcmdhelp)

`findcmdhelp nmap` : Find all the saved command usages for the **nmap**. These were saved using the **addcmdhelp** function

---

#### addcmdhelp : add command help
This function is used to save the commands for different tools that we use frequently. It takes the tool name and the corresponding command as the argument, which can then be quickly retrieved using **findcmdhelp**

`addcmdhelp nmap 'sudo nmap -sV --version-all 10.10.102.93'`

---


