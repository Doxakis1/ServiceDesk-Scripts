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

$Found  = CheckUser
Set-ADUser -Identity $Found -Add @{extensionAttribute11 = "O365Sync"}
$ExitStatus = $("Users $Found account was added to the O365 sync group. During the next AD-AAD sync (occurs every 30 minutes) the account will automatically be transfered to Azure environment.")
Write-Output $ExitStatus 
$ExitStatus | Set-Clipboard
Read-Host -Prompt "The previous message has been copied to your clipboard. Press ENTER to exit"