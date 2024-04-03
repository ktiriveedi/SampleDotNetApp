# Deployment script for SampleDotNetApp

# Stop the service if running
Stop-Service -Name w3svc -Force

# Delete existing files
Remove-Item -Path C:\inetpub\wwwroot\* -Recurse -Force
