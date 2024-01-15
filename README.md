# invoke-node-update-scripts
batch files and scripts to updates nodes


This is not a node but still a useful addition (IMHO). Although all my nodes have an update.bat in the folder that will perform a git pull. 

I have created a Windows batch file that can be put into the InvokeAI nodes folder.  When run, it will execute a git pull on any subdirectory that contains a .git folder. It will also ignore any subfolder that starts with a "_".   Hopefully useful if other node authors follow the git clone style of installing nodes.

Additionally, an untested (use with caution) Linux ".sh" version of it that Chat GPT created.  Any feedback on the Linux version would be appreciated.  If it is not useful or doesn't work I will remove it as I don't have any environment to test it on.



- update.bat : Windows batch file update all nodes
- update.sh : linux/mac update all nodes
- ListUpdates.bat : Checks if updates are available and reports how many commits behind you are
- update_force.bat : Windows batch file Update repos but for overwrite of any local changes

