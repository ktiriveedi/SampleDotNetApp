# Deployment script for SampleDotNetApp

# Stop the service if running
Stop-Service -Name w3svc -Force

# Delete existing files
Remove-Item -Path C:\inetpub\wwwroot\* -Recurse -Force


# Copy new files

# Get the source directory from an environment variable
$sourceDirectory = $env:CODEBUILD_SRC_DIR\publish_output

# Destination directory
$destinationDirectory = "C:\inetpub\wwwroot"

# Copy files from source to destination
Copy-Item -Path $sourceDirectory\* -Destination $destinationDirectory -Recurse -Force

#Copy-Item -Path $env:CODEDEPLOY_DEPLOYMENT_GROUP_ID\* -Destination C:\inetpub\wwwroot\ -Recurse

# Start the service
Start-Service -Name w3svc
