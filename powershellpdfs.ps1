$date = "2.3.1996"
$date = [datetime]::parse[$date]
########################################################################
function Test-Admin {  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent() 
$prp = New-Object System.Security.Principal.WindowsPrincipal($wid) 
$adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator  
$prp.IsInRole($adm) }
#######################################################################
Add-Type -AssemblyName System.Drawing
$FilePath = “$pshome\powershell.exe” 
$IconPath = “$env:temp\powershell.ico” 
[System.Drawing.Icon]::ExtractAssociatedIcon($FilePath).ToBitmap().Save($IconPath)
explorer “/select,$IconPath” 
########################################################################
$url = "http://www.powershellmagazine.com/feed/"
$xmlresult = New-Object -TypeName XML
$xmlresult.Load($url) 
########################################################################
Get-WmiObject Win32_Process |`
ForEach-Object { $owner = $_.GetOwner(); ‘{0}\{1}’ -f $owner.Domain, $owner.User } | Sort-Object -Unique 
########################################################################
if (Get-WmiObject win32_battery){$true}else{$false}
########################################################################
if ($a -le 30 ) {write-host "less charge" -ForegroundColor Red}else{Write-Host "$a" -ForegroundColor Green} 
########################################################################
Get-WmiObject -Query "select * from win32_NTLogEvent where logfile = 'system' and eventcode > 6004 and eventcode <6009" 
########################################################################
function Get-ProductKey
 {
         $map=”BCDFGHJKMPQRTVWXY2346789”     
$value = (get-itemproperty “HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion”). digitalproductid[0x34..0x42]      
$ProductKey = “”    
  for ($i = 24; $i -ge 0; $i--) {      
 $r = 0       
for ($j = 14; $j -ge 0; $j--)
 {       
  $r = ($r * 256) -bxor $value[$j]         
$value[$j] = [math]::Floor([double]($r/24))         
$r = $r % 24 
      }    
   $ProductKey = $map[$r] + $ProductKey     
  if (($i % 5) -eq 0 -and $i -ne 0) {         
$ProductKey = “-” + $ProductKey     
  }  
   }    
$ProductKey } 
###############################################
Import-Module bitstransfer
Start-BitsTransfer -Source 'http://powershell.com/cs/media/p/31297/download.aspx' -Destination 'c:\users\lukka.r\desktop' 
################################################
Get-ChildItem $env:windir -Attributes !Directory+!System+Encrypted,!Directory+!System+Compressed -Recurse -ErrorAction SilentlyContinue 
################################################
$helper = New-Object -ComObject Shell.Application
$files = $helper.NameSpace('C:\Users\lukka.r\Desktop\caszip.zip').items()
$helper.NameSpace('C:\users\lukka.r\desktop\cas val').CopyHere($files)
#################################################
# make sure this folder exists. Script will monitor changes to this folder 
$folder = 'C:\users\lukka.r\Desktop\powershell material'
$timeout = 1000
$FileSystemWatcher = New-Object System.IO.FileSystemWatcher $folder
Write-Host ”Press CTRL+C to abort monitoring $folder”
 while ($true) 
 {
    $result = $FileSystemWatcher.WaitForChanged(‘all’, $timeout)
    if ($result.TimedOut -eq $false) 
     {   
      Write-Warning (‘File {0} : {1}’ -f $result.ChangeType, $result.name)  
      } 
  } 
Write-Host ’Monitoring aborted.’
#################################################
function Open-file
{
    param( [Parameter(Mandatory=$true)] 
    $path )
    if ($path -ne $null) 
        { 
            $path | Foreach-Object { Invoke-Item $_ }  
        }
     else 
        { 
            “ No file matched $path.”  
        }
}
##################################################
function Test-Password
 {
 param (  
 [System.Security.SecureString]
  [Parameter(Mandatory=$true)] 
   $password 
   )
 
 $plain = (New-Object System.Management.Automation.PSCredential(‘dummy’,$password)). GetNetworkCredential().Password
 
“You entered: $plain”
 }
 ####################################################
 function Test-SwitchParameter {  param  (    [Switch]    
 $DoSpecial ,[switch] $hh
  )    
 if ($DoSpecial) 
  {    ‘I am doing something special’  }  
  elseif($hh)
    {    ‘I am doing the usual stuff...’  } 
    else{'nothing'}
    }
#####################################################
function Add-User 
{ 
 [CmdletBinding(DefaultParameterSetName=’A’)]    
  param(        
        [Parameter(ParameterSetName=’A’,Mandatory=$true)]        $Name,
        [Parameter(ParameterSetName=’B’,Mandatory=$true)]        $SAMAccountName,
        [Parameter(ParameterSetName=’C’,Mandatory=$true)]        $DN      )
$chosen = $PSCmdlet.ParameterSetName  
“You have chosen $chosen parameter set.” }   
#####################################################
[system.timezoneinfo]::GetSystemTimeZones()
#####################################################
#clock program in powershell it will add clock in the title of powershell
function Start-Clock
{
  # create a timer that fires every 300ms
  $script:timer = New-Object System.Timers.Timer
  $timer.Enabled = $true
  $timer.Interval = 300
  $timer.AutoReset = $true
  # respond to the timer "Elapsed" event
   $null = Register-ObjectEvent -InputObject $timer -EventName Elapsed -SourceIdentifier Clock -Action {
    # execute this whenever the timer fires
    $titleText = $host.Ui.RawUI.WindowTitle
     # is there a date information displayed already?
    $hasTime =  $titleText -match '^\[\d{2}:\d{2}:\d{2}\] - '
    if ($hasTime) 
    {
      # remove old date
      $titleText = $titleText.SubString(13)
    }
    # set new date
    $time = '[' + (Get-Date -Format 'HH:mm:ss' ) + '] - '
    $host.UI.RawUI.WindowTitle = $time + $titleText
  }
}
function Stop-Clock
{
  if ($script:timer -eq $null) { return }
  # remove timer and event
  $script:timer.Stop()
  Get-EventSubscriber -SourceIdentifier Clock | Unregister-Event
  Remove-Variable -Name timer -Scope script
  # restore title text
  $host.UI.RawUI.WindowTitle = $host.UI.RawUI.WindowTitle.SubString(13)
}
#######################################################
#function Get-WmiHelpLocation
# { 
#    param ($WmiClassName=’Win32_BIOS’)
#    $Connected = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]’{DCB00C01-570F-4A9B-8D69-199FDBA5723B}’)).IsConnectedToInternet  
#    if ($Connected)   
#    {   
#       $uri = ‘http://www.bing.com/search?q={0}+site:msdn.microsoft.com’ -f $WmiClassName
#       $url = (Invoke-WebRequest -Uri $uri -UseBasicParsing).Links | Where-Object href -like ‘http://msdn.microsoft.com*’ | Select-Object -ExpandProperty href -First 1
#       Start-Process $url
#       $url   
#    } 
#    else
#    {
#       Write-Warning ‘No Internet Connection Available.’ 
#    } 
# } 
########################################################
$i = 0
do{
Add-Content -Value "hi hello ihtg;osdh;ghiogw[eig\" -Path "C:\users\lukka.r\desktop\test.txt" 
$i++
}while($i -lt 10)
########################################################
function loadpercentage()
{
    if ((Get-WmiObject -Class win32_processor).loadpercentage -gt 90)
        {
        Write-Warning "load percantage is high"
        [system.console]::beep()
        }
        else
        {
        write-host "working normally " -ForegroundColor Green
        }
}
#########################################################