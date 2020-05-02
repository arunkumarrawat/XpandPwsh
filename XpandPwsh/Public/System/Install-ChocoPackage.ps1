function Install-ChocoPackage {
    [CmdletBinding()]
    [CmdLetTag("#chocolatey")]
    param (
        [parameter(Mandatory,ValueFromPipeline)]
        [string]$Package
    )
    
    begin {
        $PSCmdlet|Write-PSCmdLetBegin
        Install-Chocolatey|Write-Verbose
    }
    
    process {
        if (!(Get-ChocoPackage $Package)){
            Invoke-Script{choco install $Package}
        }
    }
    
    end {
        
    }
}