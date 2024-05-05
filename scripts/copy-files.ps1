$sourceDir = "C:\codebuild\artifacts\publish_output"
$destinationDir = "C:liquibase"

# Path to the specific file in the CodeBuild bundle
$sourceFile = Join-Path -Path $sourceDir -ChildPath "liquibase.properties"

# Path to the specific location where the file will be replaced
$destinationFile = Join-Path -Path $destinationDir -ChildPath "liquibase.properties"

# Check if the source file exists in the CodeBuild bundle
if (Test-Path -Path $sourceFile) {
    # Copy the specific file from the CodeBuild bundle to the destination, overwriting the existing file if it exists
    Copy-Item -Path $sourceFile -Destination $destinationFile -Force
    Write-Host "The file '$sourceFile' has been replaced in the destination directory."
}
else {
    Write-Warning "The source file '$sourceFile' does not exist in the CodeBuild bundle."
}