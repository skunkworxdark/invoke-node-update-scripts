# invoke-node-update-scripts

Batch/Script files to help with updating nodes. Hopefully useful if node authors follow the git clone style of installing nodes.
Put the script/batch files in your invokeai/nodes folder and run them from there.

The scripts to accept an optional directory parameter. If you pass in a directory they will operate only that directory as a repo. Otherwise, they will operate on all the sub-directories in the current directory.

In Windows, I have the batch files in the nodes folder. Then I can double-click on them and execute against all the nodes or if I drag a single folder onto the batch file it will only execute against that.

Additionally, (mostly untested so use with caution) Linux ".sh" versions that I used Chat GPT to create. Any feedback on the Linux version would be appreciated.  If it is not useful or doesn't work I will remove it as I don't have any environment to test it on.

Window batch files:
- update.bat : Update all/one nodes with a git pull
- update_list.bat : Checks all/one nodes and reports if any are behind along with a url that shows what has been updated (does not update)
- update_force.bat : Update all/one repos but overwrite of any local changes (using clean, checkout & pull)

Linux versions:
- update.sh : Update all/one nodes
- update_list.sh : Checks all/one nodes and reports if any are behind along with a url that shows what has been updated (does not update)
- update_force.sh : Update all/one repos but overwrite of any local changes (using clean, checkout & pull)

**Note:** The Linux versions will need `chmod +x scriptname.sh` before you can run it with `./scriptname.sh`
