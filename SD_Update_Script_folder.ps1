Remove-Item -Path $("C:\Users\$ENV:UserName\ServiceDeskScripts\*") -Recurse
Copy-Item -Path $("C:\ServiceDeskScripts\*") -Destination $("C:\Users\$ENV:UserName\ServiceDeskScripts") -Recurse