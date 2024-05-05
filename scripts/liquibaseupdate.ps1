# Define the paths
#$liquibasePath = "liquibase"  # Since Liquibase is in the system path, just calling by name
$propertiesPath = "C:liquibase\liquibase.properties"
$changeLogPath = "C:\liquibase\Changelog.xml"
$appPath = "C:\liquibase\ScriptExection.exe"
$configFilePath = "C:\liquibase\ScriptExection.exe.config"
$appOutputPath = $changeLogPath  # Assuming the app writes directly to the desired path

# Ensure the Application path is correct
if (-Not (Test-Path $appPath)) {
    Write-Error "Application for generating changelog not found at $appPath"
    exit 1
}

# Execute your application to generate the changelog
Write-Host "Running application to generate changelog with configuration file..."
& $appPath $configFilePath $appOutputPath
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to generate changelog using the application with config file"
    exit 1
} else {
    Write-Host "Changelog generated successfully at $changeLogPath"
}

# Update Database using the Changelog
Write-Host "Updating database using the generated changelog..."
& $liquibasePath --defaultsFile=$propertiesPath update --changeLogFile=$changeLogPath
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to update database using changelog"
    exit 1
} else {
    Write-Host "Database updated successfully using the changelog"
}