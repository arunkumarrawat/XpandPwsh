function Get-XpandPackages {
    [CmdletBinding()]
    [CmdLetTag()]
    param (
        [parameter(Mandatory)]
        [ValidateSet("Release", "Lab","All")]
        $Source,
        [ValidateSet("All", "eXpand", "XAFModules","XAFAll","XAFExtensions")]
        $PackageType = "All"
    )
    
    begin {
        $PSCmdlet|Write-PSCmdLetBegin
    }
    
    process {
        if ($Source -eq "All"){
            return ((Get-XpandPackages Release $PackageType)+(Get-XpandPackages Lab $PackageType))|Sort-Object Id -Unique
        }
        if ($PackageType -eq "All") {
            $Filter = {$true}
        }
        elseif ($PackageType -eq "eXpand") {
            $Filter = {$_.Id -like "eXpand*"}
        }
        elseif ($PackageType -eq "XAFModules") {
            $Filter = {$_.Id -like "Xpand.XAF.Modules*"}
        }
        elseif ($PackageType -eq "XAFExtensions") {
            $Filter = {$_.Id -like "Xpand.Extensions*"}
        }
        elseif ($PackageType -eq "XAFAll") {
            $Filter = {
                $_.Id -notlike "eXpand*"
            }
        }
        try {
            $c=New-Object System.Net.WebClient
            ($c.DownloadString("https://xpandnugetstats.azurewebsites.net/api/totals/packages?packagesource=xpand")|ConvertFrom-Json|ForEach-Object{
                $_|ForEach-Object{
                    [PSCustomObject]@{
                        Id = $_.Id
                        Version=[version]$_.Version
                        Source="Lab"
                    }
                }
            })+($c.DownloadString("https://xpandnugetstats.azurewebsites.net/api/totals/packages?packagesource=Nuget")|ConvertFrom-Json|ForEach-Object{
                $_|ForEach-Object{
                    [PSCustomObject]@{
                        Id = $_.Id
                        Version=[version]$_.Version
                        Source="Release"
                    }
                }
            })|Where-Object{
                (& $Filter) -and $_.Source -eq $Source
            }
            $c.Dispose()
        }
        catch {
            $nuget = Get-NugetPath
            if (($Source -eq "Release") -or !$Source) {
                $query = & $nuget List author:eXpandFramework -source (Get-PackageFeed -Nuget)
            $_
            }
            else {
                $query = & $nuget List -source (Get-PackageFeed -Xpand)
            }
            $filter.split(";") | ForEach-Object {
                $f = $_
                $query | Where-Object { $_ -like $f } | ConvertTo-PackageObject
            }
        }
        
    }
    
    end {
    }
}
