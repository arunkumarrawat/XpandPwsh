
function Remove-ProjectNuget  {
    [CmdletBinding()]
    [CmdLetTag("#nuget")]
    param(
        [parameter(Mandatory)]
        [string]$id,
        [string]$projectPath = (Get-Location),
        [parameter(Mandatory)]
        [string]$nugetAssembliesBin,
        [string]$ProjectFilter = "*",
        [switch]$SkipRestore,
        [string]$ExcludeRegex
    )
    
    begin {
        $PSCmdlet|Write-PSCmdLetBegin
    }
    
    process {
        Get-ChildItem $projectPath "$ProjectFilter.csproj" -Recurse | ForEach-Object { 
            $path = $_.FullName
            if (!$SkipRestore) {
                dotnet restore $path
            }
            
            $packageReferences=Get-PackageReference $Path |Where-Object{!$ExcludeRegex -or $_.Include -notmatch $ExcludeRegex}
            if ($packageReferences) {
                $project=($packageReferences|Select-Object -First 1).OwnerDocument
                if (!$project){
                    [xml]$project=Get-XmlContent $_.FullName
                }
                $packageReferences | Where-Object { $_.Include -match "$id" } | ForEach-Object {
                    if (!$_.Paket){
                        $_.ParentNode.RemoveChild($_)
                    }
                    else{
                        $paketRefPath=(get-item $path).DirectoryName
                        $paketRefPath+="\paket.references"
                        $packageId=$_.Id
                        (Get-Content $paketRefPath|Where-Object{$_ -ne $packageId})|Out-File $paketRefPath
                    }
                    $targetFramework = $project | Get-ProjectTargetFramework
                    FindLibraries $_.Include $_.Version $targetFramework | ForEach-Object {
                        Add-ProjectReference $project $_ "$nugetAssembliesBin\$_.dll"
                    }
                }
                $project|Save-Xml $path|out-null
            }
            else {
                # [xml]$p=Get-XmlContent $path
                # $p.Project.ItemGroup.Reference | Where-Object { $_.Include -match "$id" } | ForEach-Object {
                #     $fileName = [System.IO.Path]::GetFileName($_.Hintpath)
                #     $hintPath = "$nugetAssembliesBin\$fileName"
                #     if (!(Test-Path $hintPath)) {
                #         throw "HintPath not found: $hintPath"
                #     }
                #     $_.Hintpath = $hintPath
                # }
                # $p.Save($path)
            }
            
        } 
        Push-Location $projectPath
        Clear-ProjectDirectories 
        Pop-Location        
    }
    
    end {
        
    }
}


function FindLibraries {
    param(
        $Id,
        $version,
        $TargetFramework    
    )
    
    $path = "$env:USERPROFILE\.nuget\packages\$id\$version\lib\"
    $item = Get-ChildItem $path | ForEach-Object {
        if ($_.GetType().Name -eq "DirectoryInfo") {
            $_
        }
    } | Sort-Object -Descending | Where-Object {
        $_.BaseName.Replace("net", "") -le $TargetFramework -or $_.BaseName -like "netstandard*"
    } | Select-Object -First 1
    Push-Location $item.FullName
    Get-ChildItem *.dll | ForEach-Object {
        $_.BaseName
    }
    Pop-Location
}