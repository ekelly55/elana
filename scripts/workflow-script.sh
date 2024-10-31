# prompt  user for input values
read -p "Enter the path name: " path_name

# read inputs back to user
echo "You entered the following values:"
echo "path Name: $path_name"

cd ./.github/workflows

echo "Adding $path_name to staging.yml"

cat <<EOT >> staging.yml

  create-${path_name}-log:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    
    steps:
    - uses: actions/checkout@v4
      with:
        ref: staging
        fetch-depth: 0
    
    - uses: dorny/paths-filter@v3
      id: filter
      with:
        base: 'origin/staging'
        ref: \${{ github.sha }}
        filters: |
          ${path_name}:
            - 'elana-site/${path_name}/**'

    - name: Debug
      run: |
        echo "${path_name} changes: \${{ steps.filter.outputs.${path_name} }}"
        git log -2 --oneline

    - name: update ${path_name}
      if: steps.filter.outputs.${path_name} == 'true'
      run: |
        echo "New content added to /${path_name} \$(date)" >> ./elana-site/${path_name}/log.txt
        git config --global user.name 'github-actions[bot]'
        git config --global user.email 'github-actions[bot]@users.noreply.github.com'
        git add ./elana-site/${path_name}
        git commit -m "Add log to ${path_name}"
        git push
EOT