# repo-template

- Repository template, managed by [copier](https://github.com/copier-org/copier)!

## Usage

### Creating a repository from template

- [Install copier](https://copier.readthedocs.io/en/stable/#installation)
- Declare your repository in [repository factory](https://github.com/kemadev/infrastructure-components/tree/main/deploy/github/30-repo/main.go), make a PR and wait for it to be merged and deployed
- Run `kemutil repotpl init`
- Commit and push!

### Updating a repository from template

- `cd` into repository root
- Run `kemutil repotpl update`
- Resolve any conflicts, see [copier's doc](https://copier.readthedocs.io/en/stable/updating/)
- Commit and push!

### Notes

- Repository is intentionally not marked as template, this is to encourage using `copier` to create new repositories from it

## Notes for maintainers

- This repository does not use automatic release, you need to create tags and releases manually

  ```sh
  export NEXT_TAG="$(git tag | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1 | sed 's|v||g' | awk -F. '{printf "v%d.%d.%d", $1, $2, $3+1}')" && git tag "${NEXT_TAG}" && git push --tags && gh release create "${NEXT_TAG}" --title "${NEXT_TAG}" --notes "Release ${NEXT_TAG}"
  ```
