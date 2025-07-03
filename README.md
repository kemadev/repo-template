# repo-template-k8s

- Repository template, managed by [copier](https://github.com/copier-org/copier)!

## Usage

### Creating a repository from template

- [Install copier](https://copier.readthedocs.io/en/stable/#installation)
- Createa new (empty) repository and clone it
- Run `copier copy <repo-template-url> <new-repo-path>`
- Commit and push!

### Updating a repository from template

- `cd` into repository root
- Run `copier update --answers-file config/copier/.copier-answers.yml`
- Resolve any conflicts, see [copier's doc](https://copier.readthedocs.io/en/stable/updating/)
- Commit and push!
