param(
    [Parameter(Mandatory=$true)]
    [string]$versionType # should be 'patch', 'minor', or 'major'
)

# Assuming the script is executed from the project root directory
# Checkout to a new or existing 'release' branch
git checkout -B release

# Create the publish/src directory if it doesn't exist
$publishSrcDir = "publish/src"
if (-Not (Test-Path $publishSrcDir)) {
    New-Item -ItemType Directory -Force -Path $publishSrcDir
}

# Copy files from 'out' to 'publish/src'
Get-ChildItem -Path out/* | ForEach-Object {
    Copy-Item $_.FullName $publishSrcDir -Force
}

# Copy all .d.ts files from 'src' to 'publish/src'
Get-ChildItem -Path src/*.d.ts -Recurse | ForEach-Object {
    Copy-Item $_.FullName $publishSrcDir -Force
}

# Copy package.json to 'publish'
Copy-Item package.json publish/ -Force

# Cleanup: Remove all items except 'publish' and '.git'
Get-ChildItem -Path . | Where-Object { $_.Name -notmatch "^(publish|.git)$" } | Remove-Item -Force -Recurse

# Increment version, this will automatically create a new tag
npm version $versionType --force -m "Upgrade to %s for release"

# Push all tags to the remote repository
git push origin --tags

# Checkout to the 'main' branch
git checkout main

# Delete the 'release' branch locally
git branch -D release

# Cleanup: Delete the publish directory
Remove-Item publish -Recurse -Force

Write-Host "Files copied, version updated, and all tags pushed successfully. Release branch deleted locally and publish directory removed."
