Write-Host "Root path Directory of the scritp: $PSScriptRoot"
$deploymentDir = Split-Path -Parent $PSScriptRoot
Write-Host "Deployment Directory: $deploymentDir"

#$sourceDir = Join-Path -Path $deploymentDir "
#Write-Host "Source Directory: $sourceDir"

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
