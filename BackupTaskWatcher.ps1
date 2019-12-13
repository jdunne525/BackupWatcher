# add the required .NET assembly
Add-Type -AssemblyName System.Windows.Forms

#Set-ExecutionPolicy unrestricted

$ScheduledTaskName = "Backup\FreeFileSyncBackup"
#$Result = (schtasks /query /FO LIST /V /TN $ScheduledTaskName  | findstr "Last Run Time")
$Result = (schtasks /query /FO LIST /V /TN $ScheduledTaskName)

foreach ($line in $Result) {
	if ($line.StartsWith("Last Run Time:")) {
		$LastRun = $line.Replace("Last Run Time:","").trim().split(" ")[0]
	}

	if ($line.StartsWith("Last Result:")) {
		$Code = $line.Replace("Last Result:","").trim().split(" ")[0]
	}
}

$LastRunDate = [datetime]::ParseExact($LastRun, "MM/dd/yyyy", $null)

$TimeSinceLastRun = [datetime]::now.Subtract($LastRunDate)

If ($TimeSinceLastRun.Days -gt 5 -Or $Code -ne "0") {
	[System.Windows.Forms.Messagebox]::Show("FreeFileSync failed to back up data! Errorcode: " + $Code + "  Last Run date: " + $LastRun)
}

#pause