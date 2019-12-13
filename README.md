# BackupWatcher
Powershell script to read information from a windows task scheduler task and pop up a message box if the task hasn't run recently or failed.

I've included the Windows task Scheduler task as BackupWatcher.xml.  Just go into task manager and import that xml file.  
Edit the action to point to the path to BackupTaskWatcher.ps1.
