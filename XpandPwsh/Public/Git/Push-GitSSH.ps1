function Push-GitSSH {
    [CmdletBinding()]
    [CmdLetTag("#git")]
    param (
        [parameter(ParameterSetName = "AddAll")]
        [switch]$AddAll,
        [parameter(ParameterSetName = "AddAll")]
        [string]$Message,
        [switch]$Force,
        [string]$Branch,
        [string]$Remote,
        [string]$PagentPath = $env:PagentPath,
        [string]$PPKPath = $env:PPKPath,
        [string]$PLinkPath = $env:PLinkPath
    )
    
    begin {
        if (!$PagentPath) {
            throw "PagentPath not valid"
        }
        if (!$PPKPath) {
            throw "PPKPath not valid"
        }
        if (!$PLinkPath) {
            throw "PLinkPath not valid"
        }
        & $PagentPath $PPKPath
        $env:GIT_SSH = $PLinkPath
    }
    
    process {
        if ($AddAll) {
            git add -A
            if ($message) {
                git commit -m $message
            }
            else {
                git commit --amend  --no-edit
            }
        }
        $a=@()
        if ($Force){
            $a+="-f"
        }
        if ($Remote){
            $a+=$Remote
        }
        if ($Branch){
            $a+=$Branch
        }
        git push @a
    }
    
    end {
        
    }
}