#!/bin/bash

# Prompt the user for their GitHub username, access token, and desired branch
# read -p "GitHub Username: " username
# read -s -p "Access Token: " access_token
# echo
# read -p "Branch Name: " branch_name

branch_name="master"

# Change directory to the admin_app folder and pull the latest changes
echo "Pulling latest changes from the ${branch_name} branch of the admin_app repository..."
cd apps/admin_app
git checkout ${branch_name}
git pull origin ${branch_name}
cd ../..

# Change directory to the erp_api folder and pull the latest changes
echo "Pulling latest changes from the ${branch_name} branch of the erp_api repository..."
cd apps/erp_api
git checkout ${branch_name}
git pull origin ${branch_name}
cd ../..
