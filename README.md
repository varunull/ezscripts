# ezscripts
ezscripts is a compilation of various bash functions written to speed up the manual processes involved while working on Unix based systems. Functions will be regularly added for a diverse number of use cases ranging from file operation to penetration testing automation.

## Currently supported shells
+ Bash

## Setup
1. Pull the repository using : `git clone https://github.com/varunull/ezscripts.git`
2. Go the **ezscripts** directory, and run : `export EZSCRIPT_PATH=$PWD; source setupEzscripts.sh`
3. Run the command `showfunclist` to confirm if the setup was successful.
4. If all goes well in the first two steps without any errors, then in the **~/.bashrc** file, add the following command :
`export EZSCRIPT_PATH=<YOUR_PROJECT_DIR>; source $EZSCRIPT_PATH/setupEzscripts.sh`.


## Usage
To see all available functions in a quick glance, run `showfunclist` after setup completes.

![Screenshot from 2022-11-21 21-48-55](https://user-images.githubusercontent.com/108089086/203105372-7a85abcd-917d-44e1-a7f4-3adbdf50795d.png)


### For detailed usage of a particular function, use :
`showusage <function_name>`

![Screenshot from 2022-11-21 21-52-32](https://user-images.githubusercontent.com/108089086/203106084-34c5146d-c613-4c5d-a812-de7b47d58cbc.png)

### Examples
#### Using addcmdusage/findcmdusage functions
Scenario : Your day job requires you to run numerous commands for different tools on a frequent basis. Some of these are so important that you need to retrieve them quickly and also have the ability to tweak them based on your needs. Many linux commands have various flags indicating different usages, and remembering all of their details sometimes becomes tedious. However, it becomes easy if these different usages of the same command can be saved and retrieved easily. These functions do just that. 

[Screencast from 2022-11-21 22-07-08.webm](https://user-images.githubusercontent.com/108089086/203112864-fde59876-d88f-43cd-85ce-8d3db7d8844a.webm)

As we can see here, we now have a variety of usages of the **grep** command that can be easily retrieved later. This comes in handy for many other tools whose switches are difficult to memorize or retain. 

Here is another good example of how we can store a diverse set of usages for a command, which is **nmap** in this case. When I run `findcmdusage nmap` on my local machine :

![Screenshot from 2022-11-21 22-25-43](https://user-images.githubusercontent.com/108089086/203114322-b09fb342-6054-4de6-a2ba-357d098eb0dd.png)


## Misc Notes
I currently have many more functions like these which are yet to be cleaned up and pushed to the repository. These functions will be helpful for those solving CTF challenges, conducting penetration tests, and alike. Functions for generic usage (not specific to any usecase) will also be added, with the intention of helping all those working regularly on unix platforms. 


