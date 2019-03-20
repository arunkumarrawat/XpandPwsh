function Install-Xpand {
    param (
        [string]$Version,
        [Switch]$Latest,
        [validateSet("Assemblies", "Nuget", "Source", "VSIX")]
        [string[]]$Assets = @("Assemblies", "Nuget", "Source", "VSIX"),
        [string]$InstallationPath = "$([Environment]::GetFolderPath('MyDocuments'))\eXpandFramework",
        [switch]$SkipGac
    )
    $ErrorActionPreference="Stop"
    [Net.ServicePointManager]::Expect100Continue=$true
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $c=New-Object System.Net.WebClient
    $uri="https://raw.githubusercontent.com/eXpandFramework/XpandPosh/master/XpandPosh/Private/Xpand/InstallXpand.ps1"
    $scriptPath="$PSScriptRoot\InstallXpand.ps1"
    Write-Host "Downloading installation script from $uri into $scriptPath"
    $c.DownloadFile($url,$scriptPath)
    . $scriptPath
    InstallXpand $Version $Latest $Assets $InstallationPath $ScipGac

}

