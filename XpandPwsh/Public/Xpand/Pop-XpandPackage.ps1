function Pop-XpandPackage {
    [CmdLetTag()]
    [CmdletBinding()]
    param (
        [ValidateSet("Core","Win","Web")]
        [string[]]$Platform=@("Win","Web","Core"),
        [parameter(Mandatory)]
        [ValidateSet("Lab","Release")]
        [string]$PackageSource,
        [string]$OutputFolder=(Get-NugetInstallationFolder GlobalPackagesFolder) ,
        [version]$Version,
        [ValidateSet("All","XAFAll","Xpand")]
        [string]$PackageType

    )
    
    begin {
        if (!(Test-Path $OutputFolder))        {
            New-Item $OutputFolder -ItemType Directory
        }        
        $PSCmdlet|Write-PSCmdletBegin    
        if ($Version ){
            if ($PackageType -eq "All"){
                $releaseName="All"
                if ($PackageSource -eq "lab"){
                    $releaseName+=".lab"
                }
                $release=Get-XpandRelease -Type $releaseName -NameMatch $Version
                if (!$release){
                    throw "Version $version not found in eXpandRepo"
                }
                if (!$release.XAF ){
                    throw "eXpand release $Version does not use XAF package containers"
                }
            }
            $containers="Xpand.XAF.Win.All","Xpand.XAF.Web.All"
            if ($PackageType -eq "Xpand" -or $PackageType -eq "All"){
                $containers="eXpandAgnostic","eXpandWeb","eXpandWin"
            }
            $publishedMetadataCollector={
                param($containers,$Version)
                $publishedPackages=$containers|Get-XpandNugetPackageDependencies -Version $Version -Source (Get-PackageFeed -FeedName $PackageSource)|ForEach-Object{
                    [PSCustomObject]@{
                        Id = $_.Id
                        Version=$_.VersionRange.OriginalString
                    }
                }
                $publishedPackages+=$containers|ForEach-Object{
                    [PSCustomObject]@{
                        Id = $_
                        Version=$Version
                    }
                }
                $publishedPackages
            }
            $publishedMetadata=& $publishedMetadataCollector $containers $Version
            if ($PackageType -eq "All"){
                $publishedMetadata+=& $publishedMetadataCollector @("Xpand.XAF.Win.All","Xpand.XAF.Web.All") $release.XAF
            }
            "publishedMetadata"|Get-Variable|Out-Variable
        }
    }
    
    process {
        if (!$publishedMetadata){
            $publishedMetadata=@(Get-XpandPackages -Source  $PackageSource All)    
        }        
        if ($PackageSource -eq "Lab"){
            $releasePackages=(Get-XpandPackages -Source  Release All|Where-Object{$_.Id -notin $publishedMetadata.id})
            if ($PackageType -eq "XAFAll"){
                $releasePackages=$releasePackages|Where-Object{$_.Id -notLike "eXpand*"}
            }
            $publishedMetadata+=$releasePackages|Where-Object{
                if ($PackageType -eq "Xpand"){
                    $_.Id -notlike "Xpand*"
                }
                else{
                    $true
                }
            }
        }
        $allMetadata=$publishedMetadata|ForEach-Object{
            $version=$_.Version
            if ($version.Revision -lt 1){
                $version=Get-VersionPart $_.Version Build
            }
            [PSCustomObject]@{
                Id = $_.Id
                Version=$version
            }
        } 
        "allMetadata"|Get-Variable|Out-Variable
        $existingPackages=Get-ChildItem $OutputFolder *Xpand*.nupkg  -Recurse|ConvertTo-PackageObject|Where-Object{
            $p=$_
            $allMetadata|Where-Object{$_.Id -eq $p.Id -and $_.Version -eq $p.version}
        }
        "existingPackages"|Get-Variable|Out-Variable
        $missingMetadata=$allMetadata|Where-Object{
            $p=$_
            !($existingPackages|Where-Object{$_.Id -eq $p.Id -and $_.Version -eq $p.version})
        }

        "missingMetadata"|Get-Variable|Out-Variable
        if ($missingMetadata){
            $source="$(Get-PackageFeed -Xpand)","$(Get-PackageFeed -Nuget)"
            $newMetadata=$missingMetadata|Invoke-Parallel -ActivityName "Dowloading Xpand packages " -VariablesToImport @("source","OutputFolder") -LimitConcurrency ([System.Environment]::ProcessorCount) -Script{
            # $newMetadata=$missingMetadata|foreach{
                Get-NugetPackage $_.Id -Source $source -ResultType DownloadResults -OutputFolder $OutputFolder -Versions $_.Version
            }   
            $downloadedPackages=$newMetadata.PackageStream.name|Get-Item|ConvertTo-PackageObject
            "downloadedPackages"|Get-Variable|Out-Variable
            ($downloadedPackages+$existingPackages)|Sort-Object id -Unique
        }
        else{
            $existingPackages
        }        
    }
    
    end {
        
    }
}