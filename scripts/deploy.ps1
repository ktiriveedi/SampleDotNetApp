# Deployment script for SampleDotNetApp

# Stop the service if running
Stop-Service -Name SampleDotNetApp -Force

# Delete existing files
Remove-Item -Path C:\inetpub\wwwroot\SampleDotNetApp\* -Recurse -Force

# Copy new files
Copy-Item -Path $env:CODEDEPLOY_DEPLOYMENT_GROUP_ID\* -Destination C:\inetpub\wwwroot\SampleDotNetApp\ -Recurse

# Start the service
Start-Service -Name SampleDotNetApp

