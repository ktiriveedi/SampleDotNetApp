# Deployment script for SampleDotNetApp

# Stop the service if running
Stop-Service -Name w3svc -Force

# Delete existing files
Remove-Item -Path C:\inetpub\wwwroot\* -Recurse -Force

# Copy new files
Copy-Item -Path $env:CODEDEPLOY_DEPLOYMENT_GROUP_ID\* -Destination C:\inetpub\wwwroot\ -Recurse

# Start the service
Start-Service -Name w3svc
