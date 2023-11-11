function CheckComputer {
    param (
	    [parameter(mandatory=$true)]
        [string]$ComputerName
    )
    if ($(get-ADComputer $ComputerName)) {
        $ComputerName
    }
    else {
        CheckComputer
    } 
}
function CheckSource {
    param (
	    [parameter(mandatory=$true)]
        [string]$SourcePath
    )
    $SourcePath = $SourcePath -replace '"', ""
    if ($(Test-Path $SourcePath) -eq  $true) {
        $SourcePath
    }
    else {
        CheckSource
    } 
}
$ComputerName = CheckComputer
$InstallMediaLocation = CheckSource
if ($(Test-Path $InstallMediaLocation) -eq  $true -and $(Test-Path $("\\$ComputerName\c$\TEMP")) -eq  $true) {
   Write-Output "Are you sure you want to copy the contents of $InstallMediaLocation to $("\\$ComputerName\c$\TEMP"))?"
   $Permission = 0
   while ($Permission -eq 0) {
    $answer = Read-Host -Prompt "(y/n)   Your answer"
    if ($answer -eq 'y') {
        $Permission = 1
    }
    elseif ($answer -eq 'n') {
        $Permission = 2
    }
   }
   if ($Permission -eq 1) {
    $date = ([System.Guid]::NewGuid()).ToString()
    $NewFolder = $("\\$ComputerName\c$\TEMP\$date)")
    New-Item  $NewFolder -Type Directory
    Copy-Item -Path $("$InstallMediaLocation\*") -Destination $NewFolder -Recurse
   }
   if ($Permission -eq 1) {
    Read-Host -Prompt "SUCCESS. Press ENTER to exit"
   }
   if ($Permission -eq 2) {
    Read-Host -Prompt "ABORTED. Press ENTER to exit"
   }
}
else {
    Write-Output "We cannot contact $ComputerName"
    Read-Host -Prompt "Press ENTER to exit"
}
    
