function CheckUser {
    param (
	    [parameter(mandatory=$true)]
        [string]$Username
    )
    if ($(get-ADuser $Username)) {
        $Username
    }
    else {
        CheckUser
    } 
}
function CheckNumber {
    param (
	    [parameter(mandatory=$true)]
        [string]$PhoneNumber
    )
    if( $($PhoneNumber -match '[+]{1}^\d{12}') -eq $false -and $PhoneNumber[0] -eq '+' -and $PhoneNumber[1] -eq '3' -and $PhoneNumber[2] -eq '5' -and $PhoneNumber[3] -eq '8' -and $PhoneNumber.Length -eq 13)
    {
        $PhoneNumber
    }
    else {
        CheckNumber
    }
}

$Found  = CheckUser
$NewNumber = CheckNumber
Set-ADUser -Identity $Found -Replace @{internationalISDNNumber = $NewNumber}
Set-ADUser -Identity $Found -Replace @{mobile = $NewNumber}
$ExitStatus = $("Users $Found phonumber was updated to: $Newnumber")
Write-Output $ExitStatus 
$ExitStatus | Set-Clipboard
Read-Host -Prompt "The previous message has been copied to your clipboard. Press ENTER to exit"