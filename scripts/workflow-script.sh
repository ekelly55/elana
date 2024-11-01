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
    - name: Checkout repository
      uses: actions/checkout@v4
      with:
        ref: staging
        fetch-depth: 0
    
    - name: Get previous commit
      id: get-prev-commit
      run: |
          echo "prev_commit=\$(git rev-parse staging~1)" >> \$GITHUB_OUTPUT   

    - uses: dorny/paths-filter@v3
      id: filter
      with:
        base: \${{ steps.get-prev-commit.outputs.prev_commit }}
        ref: \${{ github.sha }}
        filters: |
          ${path_name}:
            - 'elana-site/${path_name}/**'

    - name: Debug
      run: |
        echo "${path_name} changes: \${{ steps.filter.outputs.${path_name} }}"
        git log -2 --oneline

    - name: get date of ${path_name} change
      if: steps.filter.outputs.${path_name} == 'true'
      run: |
        cd elana-site/${path_name}
        date 
EOT