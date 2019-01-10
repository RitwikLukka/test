#fundamental lab
#task 2-1
#dir C:\Program Files -Recurse -Force
Get-ChildItem -Path 'C:\Program Files'
#task 2-2
dir hklm:\software -recurse
#task 2-3
$a = dir env:
$a | ?{$_.name -eq 'systemroot'}
#task 2-4
cd HKCU:\Software
copy intel sapienclass
#task 2-5
rd sapienclass
#task 3-1
Get-ChildItem
#task 3-2
New-Alias d Get-ChildItem
#task 3-3
get-command | ?{$_.Name -like "*snapin*"}
#task 3-4
Start-Transcript
Stop-Transcript
#task 3-5
Stop-Process calc
#task 3-6
Get-Content -Path C:\users\lukka.r\Desktop\t.txt -TotalCount 1
#task 3-7
Get-Date -DisplayHint Date
#task3-8
Get-Eventlog Security -Newest 20 
#task 4-1
Get-Service | gm *
#task 4-2
Get-Service | Out-File -FilePath C:\Users\lukka.r\Desktop\n.txt
#task 4-3 
Get-Service | Stop-Service -WhatIf
#task 4-4
Get-Service | Stop-Service -Confirm
#task 4-5
Get-Content -Path C:\users\lukka.r\Desktop\t.txt | Copy-Item -Destination C:\Users\lukka.r\Desktop\solutions
#task 5-1
Get-Service | gm *
#task 5-2 
Get-EventLog system | gm *
#task 5-3
Get-Process | Sort-Object Handles -Descending | Select-Object -first 10
#task 5-4
(Get-Service) | Group-Object status
#task 5-5
get-service|Measure-Object
#task 5-6
Get-process | Measure-Object handles -Average -Maximum -Minimum
#task 5-7
#access
#task 6-1
set-executionpolicy remotesigned -Confirm CurrentUser
#task 6-2
# save file with .ps1 extension
.\test.ps1
#task 6-3
Get-AuthenticodeSignature
Set-AuthenticodeSignature
#task 6-4
#https://technet.microsoft.com/en-us/library/bb613488(v=vs.85).aspx
$profie
new-item -path $profie -itemtype file -force
#task 6-5
Get-Credential
#task 7-1 
#Win32_Service	#Win32_LogicalDisk	#Win32_NetworkAdapterConfiguration#Win32_Process	#Win32_OperatingSystem
#task 7-2
Get-WmiObject -Class win32_logicaldisk
#task 7-3
Get-WmiObject -Class win32_logicaldisk | Sort-Object Drivertype
#task 7-4
Get-WmiObject -Class win32_service | ?{$_.state -eq 'running'}
#task 7-5
Get-WmiObject -Class win32_service | ?{$_.state -eq 'running'}|Select-Object name 
#task 7-6
Get-WmiObject -Query "select * from win32_logicaldisk" 
#task 7-7
Get-WmiObject -Query "select buildnumber,servicepackmajorversion	from win32_operatingsystem" 
#task 8-1
get-process |? {$_.Responding -eq 'TRUE'} | Sort-Object processname
#task 8-2
Get-Service|?{$_.starttype -eq 'automatic' -and $_.status -ne 'running'}
#task 8-3
Get-Service|?{$_.starttype -eq 'automatic' -and $_.status -ne 'running'}|ConvertTo-Html|Out-File -FilePath C:\Users\lukka.r\Desktop\a.html
#task 8-4
Get-WmiObject -Class win32_process |?{$_.name -ne 'notepad.exe'}|%{ $_.terminate( )}
#task 8-5 
Get-Content -Path C:\Users\lukka.r\Desktop\server.txt | %{Get-WmiObject -Class win32_logicaldisk}
#task 10-1
Get-Service | gm *
#task 10-2
Get-process | select processname,id,responding | Sort-Object responding,name | Format-Table
#task 10-3
Get-Service | ?{$_.status -eq 'running'} | select name | Format-Wide
#task 10-4
Get-Service | Format-List *
#task 10-5
read-host 'enter something' | write-host -ForegroundColor red -BackgroundColor Black
#task 10-6
#normally 5+5 is considered as operation when it is given as input in write it will considered as string would print it as a string with out performing operation
#task 10-7
5+5 | Write-Host -ForegroundColor Yellow
#task 12-1 
"x"|gm *
#task 12-2
[string]$v=124456
#task 12-3
$var="hello"
$var.StartsWith('x')
#task 12-4
$var = "one","two","three"
$var | ?{$_.length -le 4}| Write-Host -ForegroundColor green
#task 12-5 
$va = 'hi'
$as = "$va hell0"
#task 13 
#
#task 14-1
$var = 'hi hello how are you '
$var -like 'exec'
#task 14-2
Get-ChildItem | ?{$_.name -like "*exec*"}
#task 14-3
Get-ChildItem | ?{$_.name -like "*exec*" -and $_.Length -le 200}
#task 14-4
Get-ChildItem | ?{$_.Length -gt 100mb}
#task 15-1
$log = Read-Host "Which event log to get?"	$events = Get-EventLog -LogName $log -newest 50	foreach($event in $events)	  {	  	switch($event.categorynumber)	    {	     "(0)" {$color ="Green"}	     "(101)"{$color="Yellow"}	     "(103)"{$color ="Red" }		     default{$color="White"}    }	  Write-Host $event.timewritten -ForegroundColor $color}	#task 16-1function bn()    {        $name = Read-Host "enter computer name"
        (Get-WmiObject win32_operatingsystem -ComputerName $name).buildnumber
    }