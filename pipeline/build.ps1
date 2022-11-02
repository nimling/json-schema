[CmdletBinding()]
param (
    [string[]]$folders = @("policy-as-code"),
    [string]$UrlBase = "https://raw.githubusercontent.com",
    [string]$TargetBranch = "main",
    [parameter(
        HelpMessage = "if not defined, it uses git config to figure out"
    )]
    [string]$GitUser,
    [parameter(
        HelpMessage = "if not defined, it uses git config to figure out"
    )]
    [string]$GitRepo
)

begin {
    #get user and repo from git config
    if (!$GitUser -and !$GitRepo) {
        Write-Verbose "Using Git config to figure out repo and user"
        $RemoteUrl = git config --get remote.origin.url
        if ([string]::IsNullOrEmpty($RemoteUrl)) {
            throw "Cannot process. cannot find remote url"
        }
        $RemoteUrlArr = $RemoteUrl.split("/")
        $GitRepo = [System.IO.Path]::GetFileNameWithoutExtension($RemoteUrlArr[-1])
        $GitUser = $RemoteUrlArr[-2] 
    }

    #validate target branch. throw if var targetBranch is not in the list of branches from git
    $branches = git branch -r
    if(-not ($branches -clike "*/$TargetBranch"))
    {
        throw "Target branch '$TargetBranch' is not found. this is a case sensitive operation."
    }

    #https://raw.githubusercontent.com/nimling/json-schema/main/policy-as-code/common-pac.json#/properties/item
    $UrlPrefix = "$UrlBase/$GitUser/$GitRepo/$TargetBranch"
}

process {
    
}

end {
    
}