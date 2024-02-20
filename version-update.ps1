param(
    [Parameter(Mandatory=$true)]
    [string]$versionType, # should be 'patch', 'minor', or 'major'
)

# Navigate to the project root directory if the script is not there
# Set-Location "path\to\your\project"

# Checkout or create the release branch
git checkout release -B

# Ensure publish/src directory exists
$publishDir = "publish/src"
if (-Not (Test-Path $publishDir)) {
    New-Item -ItemType Directory -Force -Path $publishDir
}

# Move everything to publish/src, this might need adjustments based on your project structure
Get-ChildItem -Path . -Exclude publish | ForEach-Object {
    Move-Item $_.FullName $publishDir -Force
}

# Clean up the root directory, except for the 'publish' directory
Get-ChildItem -Path . -Exclude publish | ForEach-Object {
    Remove-Item $_.FullName -Force -Recurse
}

# Increment version and create a tag
npm version $versionType --force -m "Upgrade to %s for release"

# Push the new tag
git push --tags

# Checkout the main branch
git checkout main

# Delete the release branch locally
git branch -D release

Write-Host "Version updated, tagged, and pushed successfully. Release branch deleted."
