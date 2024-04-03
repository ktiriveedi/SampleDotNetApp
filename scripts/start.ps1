
# Copy new files
#Copy-Item -Path $env:CODEDEPLOY_DEPLOYMENT_GROUP_ID\* -Destination C:\inetpub\wwwroot\ -Recurse

# Start the service
Start-Service -Name w3svc
