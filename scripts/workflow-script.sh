# prompt  user for input values
read -p "Enter the path name: " path_name

# read inputs back to user
echo "You entered the following values:"
echo "path Name: $path_name"

cd ./.github/workflows

echo "Adding $path_name to staging.yml"

cat <<EOT >> staging.yml

  id-${path_name}-changes:
    needs: set-environment
    runs-on: ubuntu-latest
    permissions:
      contents: write
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          ref: \${{ needs.set-environment.outputs.target_branch }}
          fetch-depth: 2

      - name: Get previous commit
        id: get-prev-commit
        run: |
          echo "prev_commit=\$(git rev-parse HEAD~1)" >> \$GITHUB_OUTPUT
    
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
          echo "Target branch: \${{ needs.set-environment.outputs.target_branch }}"
          echo "AWS Account: \${{ needs.set-environment.outputs.aws_account }}"
          git log -2 --oneline

      - name: Print deployment account
        if: steps.filter.outputs.${path_name} == 'true'
        run: |
          echo "Change to ${path_name} on branch \${{ needs.set-environment.outputs.target_branch }} to deploy to \${{ needs.set-environment.outputs.aws_account }}"
EOT