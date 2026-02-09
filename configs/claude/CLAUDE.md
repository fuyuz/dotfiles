# CLAUDE.md

## Code Comments Policy

- **NEVER add line-by-line comments in source code**
- **ONLY add comments to public classes and functions**
- Private/internal methods should NOT have comments unless explicitly requested
- Focus on clean, self-documenting code instead of excessive comments
- When adding comments to public APIs, keep them concise and focused on usage

## Version Control Policy

- **Use jj (jujutsu) instead of git** for all version control operations
- NEVER use `git` commands directly. Always use the equivalent `jj` command
- Common mappings:
  - `git status` → `jj status` / `jj st`
  - `git diff` → `jj diff`
  - `git log` → `jj log`
  - `git add` + `git commit` → `jj commit` (jj automatically tracks changes, no staging needed)
  - `git commit --amend` → `jj describe` (to edit message) / `jj squash` (to fold changes)
  - `git branch` → `jj bookmark`
  - `git push` → `jj git push`
  - `git fetch` → `jj git fetch`
  - `git checkout` / `git switch` → `jj new` / `jj edit`
  - `git rebase` → `jj rebase`
  - `git merge` → `jj new <rev1> <rev2>` (create merge commit)
- jj has no staging area. All file changes in the working copy are automatically included
- Use `jj new` to create a new empty change on top of the current one
- Use `jj describe -m "message"` to set or update the description of the current change
- Use `jj bookmark set <name>` to create/move a bookmark (equivalent to git branch)
- For GitHub PRs, use `jj git push` to push bookmarks, then `gh pr create`
