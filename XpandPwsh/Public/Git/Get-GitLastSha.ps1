function Get-GitLastSha {
    [CmdletBinding()]
    [CmdLetTag("#git")]
    param (
        [parameter(ValueFromPipeline, Mandatory)]
        [string]$repoGitUrl,
        [string]$Branch
    )
    
    begin {
    }
    
    process {
        $ls=Invoke-Script { git ls-remote $repoGitUrl } 
        $ls| ForEach-Object {
            try {
                $regex = [regex] '(\w*) *(.*)'
                $sha = $regex.Match($_).Groups[1].Value
                $ref = $regex.Match($_).Groups[2].Value.Trim()
                if (!$Branch) {
                    if ($ref -eq "HEAD") {
                        $sha
                    }
                }
                else {
                    if ($ref.Replace("refs/heads/", "") -eq $Branch) {
                        $sha
                    }
                }
            }
            catch {
                
            }
        } | Select-Object -First 1
    }
    
    end {
    }
}