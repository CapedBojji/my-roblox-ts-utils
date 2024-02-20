# version-update.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$versionType # should be 'patch', 'minor', or 'major'
)

# Navigate to the project root directory if the script is not there
# Set-Location "path\to\your\project"

# Increment version
npm version $versionType

# Push the commit and tags
git push
git push --tags

Write-Host "Version updated and pushed successfully."
