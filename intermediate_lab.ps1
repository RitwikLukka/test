﻿#lab 1-1
Get-ChildItem -Path C:\Windows\System32 -Filter *.dll
#lab 1-2
Get-WmiObject -Query "select deviceid,freespace from win32_logicaldisk"
#lab 1-3
Get-Process | ConvertTo-Html -Title runningprocess | Out-File -FilePath C:\users\lukka.r\Desktop\rp.html
#lab 1-4
Get-Process | select -Unique
#lab 1-5
Get-WmiObject win32_logicaldisk | % -Begin {"freespace"} -End {"complete"} -Process {$_.freespace / 1gb}
#lab 2-1
(Get-Content -Path C:\users\lukka.r\Desktop\t.txt).Trim(' ')
#lab 2-2
(Get-Content -Path C:\users\lukka.r\Desktop\t.txt)| %{$_.toupper().replace("C","z")} 
#lab 2-3
(Get-Content -Path C:\users\lukka.r\Desktop\t.txt)| % {$_.indexof("x")}
#lab 2-4
(Get-Date).AddYears(-1)
#lab 2-5
((Get-Date).AddYears(-4)).ToFileTime()
#lab 3-1
function b() 
    {
        $cn = Read-Host "enter computer name"
        $na = read-host "enter service name"
        (Get-WmiObject win32_service -ComputerName $cn | ? {$_.name -eq $na} ).startname
    }
function etet()
    {
        try 
            {
            b
            $ErrorActionPreference = "silentlycontinue"
            if (error) {throw error in c }
            }
         catch
            {
            write-host "not reachble"
            }
    }
#lab 4-1 
##Should	display	OS	build	number	and	SP	version	for	specified	computer	
function get1
    {
    process{
        $re = Get-WmiObject -class win32_logicaldisk -ComputerName $_
        Write-Host "computer name"
        Write-Host $re.pscomputername
        Write-Host "driver name"
        Write-Host $re.deviceid
        Write-Host "Free space"
        $r = $re.freespace
        Write-Host $r
        }    
    }
$a | get1
#lab 6-2
$a=read-host "enter the computer name"
function get2
{
   process
      {
        $re = Get-WmiObject -class win32_logicaldisk -ComputerName $_
        Write-Host "computer name"
        Write-Host $re.pscomputername
        Write-Host "driver name"
        Write-Host $re.deviceid
        Write-Host "Free space"
        $r = $re.freespace/1mb
        Write-Host $r
      }
}
  $a |Get2