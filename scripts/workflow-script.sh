# prompt  user for input values
read -p "Enter the path name: " path_name

# read inputs back to user
echo "You entered the following values:"
echo "path Name: $path_name"

cd ./.github/workflows

echo "Adding $path_name to staging.yml

cat <<EOT >> staging.yml


on:
  push:
    branches:
      - staging
    paths:
      - elana-site/$path_name/**
  workflow_dispatch:

jobs:
  create-file:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    
    steps:
    - uses: actions/checkout@v4
      
    - name: create and add $path_name-log.txt
      run: |
        cd/elana-site/$path_name
        echo "New content added to $path_name $\(date)" >> $path_name-log.txt
      
    - name: Configure Git
      run: |
        git config --global user.name 'github-actions[bot]'
        git config --global user.email 'github-actions[bot]@users.noreply.github.com'

    - name: Commit file
      run: |
        git add .
        git commit -m "Add timestamp to $path_name-log.txt"
        git push