New-Item $("C:\Users\$ENV:UserName\Documents\WindowsPowerShell") -Type Directory
New-Item -Path $("$Profile")
Write-Output 'Import-Module ActiveDirectory' > $Profile
New-Item $("C:\Users\$ENV:UserName\ServiceDeskScripts") -Type Directory
Copy-Item -Path $("C:\ServiceDeskScripts\*") -Destination $("C:\Users\$ENV:UserName.TRE\Desktop\ServiceDeskScripts") -Recurse