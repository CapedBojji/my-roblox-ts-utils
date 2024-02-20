param(
    [Parameter(Mandatory=$true)]
    [string]$versionType # should be 'patch', 'minor', or 'major'
)

# Store the current branch name
$currentBranch = git rev-parse --abbrev-ref HEAD

# Commit the changes
git add .
git commit -m "Pre release commit"

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

# Cleanup: Remove all items except 'publish' and '.git'
Get-ChildItem -Path . | Where-Object { $_.Name -notmatch "^(publish|.git|package.json)$" } | Remove-Item -Force -Recurse

# Create src directory in root
$srcDir = "src"
if (-Not (Test-Path $srcDir)) {
    New-Item -ItemType Directory -Force -Path $srcDir
}

# Copy files from 'publish/src' to 'src'
Get-ChildItem -Path publish/src/* | ForEach-Object {
    Copy-Item $_.FullName $srcDir -Force
}

# Remove the 'publish' directory
Remove-Item -Path publish -Force -Recurse

# Commit the changes
git add .
git commit -m "Version updated to $versionType"

# Increment version, this will automatically create a new tag
npm version $versionType  

# Create a tag called latest if it doesn't exist
git tag -f latest

# Push all tags to the remote repository
git push --tags

# Checkout to the previous branch
git checkout $currentBranch

# Copy the package.json file from the 'release' branch to the root directory
git checkout release -- package.json

# Remove the 'release' branch
git branch -D release

# Commit the changes
git add .
git commit -m "Post release commit"


Write-Host "Files copied, version updated, and all tags pushed successfully. Release branch deleted locally and publish directory removed."