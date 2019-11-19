#
# Module manifest for module 'XpandPwsh'
#
# Generated by: eXpandFramework
#
# Generated on: 6/9/2019
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'XpandPwsh.psm1'

# Version number of this module.
ModuleVersion = '0.31.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '17acbc1d-68d3-42a0-a2da-c4bf6a9bca07'

# Author of this module
Author = 'eXpandFramework'

# Company or vendor of this module
CompanyName = 'eXpandFramework'

# Copyright statement for this module
Copyright = '(c) 2019 eXpamdFramework. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Various functions working with DevExpress XAF, eXpandFramework and not only'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.0.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = '4.7.1'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = '7.1'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @("Cmdlets\bin\XpandPwsh.Cmdlets.dll")

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('Cmdlets\bin\XpandPwsh.Cmdlets.dll')


# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    "Add-NuspecDependency",
"Approve-LastExitCode",
"Checkpoint-GitHubIssue",
"Clear-DotNetSdkFallBackFolder",
"Clear-NugetCache",
"Clear-ProjectDirectories",
"Clear-TempFolders",
"Close-GithubIssue",
"Compress-Files",
"Compress-Project",
"ConvertTo-Object",
"ConvertTo-PackageObject",
"Disable-ExecutionPolicy",
"Find-NugetPackage",
"Find-NugetPackageInstallationFolder",
"Find-PaketRefs",
"Find-XpandNugetPackage",
"Find-XpandPackage",
"Format-Xml",
"Get-AssemblyInfoVersion",
"Get-AssemblyMetadata",
"Get-AssemblyPublicKey",
"Get-CallerPreference",
"Get-ChocoPackage",
"Get-DevExpressPath",
"Get-DevExpressVersion",
"Get-Distinct",
"Get-DotNetCoreVersion",
"Get-DotNetTool",
"Get-DXNugets",
"Get-GitHubCommitIssue",
"Get-GitHubIssue",
"Get-GitHubIssueComment",
"Get-GitHubMilestone",
"Get-GitHubRelease",
"Get-GitHubRepositoryTag",
"Get-GitLastSha",
"Get-LatestMinorVersion",
"Get-MsBuildPath",
"Get-NugetInstallationFolder",
"Get-NugetPackage",
"Get-NugetPackageDependencies",
"Get-NugetPackageDownloadsCount",
"Get-NugetPackageMetadataVersion",
"Get-NugetPackageSearchMetadata",
"Get-NugetPath",
"Get-PackageFeed",
"Get-PackageReference",
"Get-PackageSourceLocations",
"Get-PackageTargetFramework",
"Get-PaketDependenciesPath",
"Get-ProjectTargetFramework",
"Get-ReferenceConflict",
"Get-RelativePath",
"Get-SymbolSources",
"Get-VSPath",
"Get-XmlContent",
"Get-XpandPackages",
"Get-XpandPath",
"Get-XpandReleaseChange",
"Get-XpandRepository",
"Get-XpandVersion",
"Install-Chocolatey",
"Install-DebugOptimizationHook",
"Install-DevExpress",
"Install-SubModule",
"Install-Xpand",
"Invoke-AzureRestMethod",
"Invoke-PaketAdd",
"Invoke-PaketAdd",
"Invoke-PaketClearCache",
"Invoke-PaketConvertFromNuget",
"Invoke-PaketFindVersions",
"Invoke-PaketInit",
"Invoke-PaketInstall",
"Invoke-PaketRestore",
"Invoke-PaketShowInstalled",
"Invoke-PaketSimplify",
"Invoke-PaketUpdate",
"Invoke-Parallel",
"Invoke-Script",
"Move-PaketSource",
"New-Assembly",
"New-AssemblyResolver",
"New-Command",
"New-GitHubComment",
"New-GithubReleaseNotes",
"New-GithubReleaseNotesTemplate",
"Publish-AssemblyToGac",
"Publish-GitHubRelease",
"Publish-NugetPackage",
"Remove-BlankLines",
"Remove-ProjectLicenseFile",
"Remove-ProjectNuget",
"Resolve-AssemblyDependencies",
"Set-VsoVariable",
"Start-SelfElevate",
"Start-XpandProjectConverter",
"Switch-DevExpress",
"Swtch-XpandToNugets",
"Test-Symbol",
"Uninstall-ProjectAllPackages",
"UnInstall-Xpand",
"UnPublish-NugetPackage",
"Update-AssemblyInfo",
"Update-AssemblyInfoVersion",
"Update-GitHubIssue",
"Update-HintPath",
"Update-NugetPackage",
"Update-NugetProjectVersion",
"Update-Nuspec",
"Update-OutputPath",
"Update-ProjectAutoGenerateBindingRedirects",
"Update-ProjectDebugSymbols",
"Update-ProjectLanguageVersion",
"Update-ProjectPackage",
"Update-ProjectProperty",
"Update-ProjectSign",
"Update-ProjectTargetFramework",
"Update-Symbols",
"Update-Version",
"Use-MonoCecil",
"Use-NugetAssembly"
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
# CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @("Cmdlets\bin\XpandPwsh.Cmdlets.dll")

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags       = @("eXpandFramework", "DevExpress", "nuget","XAF","srcsrv")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/eXpandFramework/XpandPwsh/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'http://XpandPwsh.eXpandFramework.com'

        # A URL to an icon representing this module.
        IconUri    = 'http://sign.expandframework.com'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
