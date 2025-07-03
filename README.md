# repo-template

- Repository template, managed by [copier](https://github.com/copier-org/copier)!

## Usage

### Creating a repository from template

- [Install copier](https://copier.readthedocs.io/en/stable/#installation)
- Declare your repository in [repository factory](https://github.com/kemadev/infrastructure-components/tree/main/deploy/github/30-repo/main.go), make a PR and wait for it to be merged and deployed
- Run `copier copy https://github.com/kemadev/repo-template <new-repo-path>`
- Commit and push!

### Updating a repository from template

- `cd` into repository root
- Run `copier update --answers-file config/copier/.copier-answers.yml`
- Resolve any conflicts, see [copier's doc](https://copier.readthedocs.io/en/stable/updating/)
- Commit and push!
