# invoke-node-update-scripts
Batch/Script files to help with updating nodes. Hopefully useful if node authors follow the git clone style of installing nodes.

Put the script/batch file in your nodes folder and run it. 

I have created a Windows batch file that can be put into the InvokeAI nodes folder.  When run, it will execute a git pull on any subdirectory that contains a .git folder. It will also ignore any subfolder that starts with a "_".   

Additionally, an untested (use with caution) Linux ".sh" version of it that Chat GPT created.  Any feedback on the Linux version would be appreciated.  If it is not useful or doesn't work I will remove it as I don't have any environment to test it on.

Window batch files:

- update.bat : Update all nodes with a git pull
- update_list.bat : Checks all nodes and reports if any are behind along with a url that shows what has been updated
- update_force.bat : Update all repos but overwrite of any local changes (using clean, checkout & pull)

Linux versions:
- update.sh : Update all nodes

