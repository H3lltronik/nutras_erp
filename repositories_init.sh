#!/bin/bash

# Prompt the user for their GitHub username, access token, and desired branch
read -p "GitHub Username: " username
read -s -p "Access Token: " access_token
echo
read -p "Branch Name: " branch_name

# Create the "apps" folder if it doesn't exist
mkdir -p apps

# Clone the first repository (admin_app)
git clone "https://${username}:${access_token}@github.com/${username}/admin_app.git" apps/admin_app

# Clone the second repository (erp_api)
git clone "https://${username}:${access_token}@github.com/${username}/erp_api.git" apps/erp_api
