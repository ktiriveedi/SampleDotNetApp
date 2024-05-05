Write-Host "Root path Directory of the script: $PSScriptRoot"
$deploymentDir = Split-Path -Parent $PSScriptRoot
Write-Host "Deployment Directory: $deploymentDir"

$destinationDir = "C:\liquibase"
Write-Host "Destination Directory: $destinationDir"

# Path to the specific file in the deployment directory
$sourceFile = Join-Path -Path $deploymentDir -ChildPath "liquibase.properties"
Write-Host "Source File: $sourceFile"

# Path to the specific location where the file will be copied
$destinationFile = Join-Path -Path $destinationDir -ChildPath "liquibase.properties"
Write-Host "Destination File: $destinationFile"

# Check if the source file exists in the deployment directory
if (Test-Path -Path $sourceFile) {
    # Copy the specific file from the deployment directory to the destination, overwriting the existing file if it exists
    Copy-Item -Path $sourceFile -Destination $destinationFile -Force
    Write-Host "The file '$sourceFile' has been copied to the destination directory."
}
else {
    Write-Warning "The source file '$sourceFile' does not exist in the deployment directory."
}

# Copy the "db" directory
$dbSourceDir = Join-Path -Path $deploymentDir "db"
Write-Host "DB Source Directory: $dbSourceDir"

$dbDestinationDir = Join-Path -Path $destinationDir "db"
Write-Host "DB Destination Directory: $dbDestinationDir"

# Check if the "db" source directory exists in the deployment directory
if (Test-Path -Path $dbSourceDir) {
    # Copy the entire "db" directory from the deployment directory to the destination, overwriting existing files
    Copy-Item -Path $dbSourceDir -Destination $dbDestinationDir -Recurse -Force
    Write-Host "The directory '$dbSourceDir' has been copied to the destination directory."
}
else {
    Write-Warning "The source directory '$dbSourceDir' does not exist in the deployment directory."
}