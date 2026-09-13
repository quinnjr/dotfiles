# Global memory (loaded into every opencode session)

## repos live on Bitbucket OR GitHub — check the remote

`lexmata-*` repos are split across hosts, so never assume from the name.
Run `git remote -v` and check the tracking branch first.

- **Bitbucket** (`git@bitbucket.org:lexmata/<slug>.git`): use the
  `bitbucket` CLI below; `gh` does not apply. PR titles like
  "Merged in feature/X (pull request #N)" are Bitbucket merge commits.
- **GitHub** (`github.com/quinnjr/<slug>` or similar): `gh` works and is
  authenticated (account `quinnjr`).
- A repo can have BOTH remotes. `origin` may be a stale Bitbucket remote
  while `github` is the live one `develop` actually tracks — verify
  freshness with `git rev-list --left-right --count origin/develop...github/develop`
  before pushing.

## bitbucket CLI

Binary: `/home/joseph/.local/share/cargo/bin/bitbucket` (not on PATH;
invoke by full path). Workspace is `lexmata`.

```bash
bitbucket pr list lexmata/<repo-slug>
bitbucket pr create lexmata/<repo-slug> --title "<prefix>: <what>" \
  --source feature/<BRANCH> --destination main \
  --close-source-branch --body "<description>"
```

Destination varies by repo (`main` for lexmata-litify-integration; check the
repo's CLAUDE.md / recent merge commits if unsure).

Merge with `--strategy squash` (repo standard). Consequence: merged
branches are NOT ancestors of the target, so `merge-base --is-ancestor`
gives false negatives when checking if a branch landed — use
`git cherry <target> <branch>` (all `-` = merged) or compare the
branch diff against the squash commit's stats instead.

## jira CLI

Binary: `/home/joseph/.local/share/cargo/bin/jira` (not on PATH; invoke by
full path). Auth is already configured.

```bash
jira issue list --jql "project = <PROJ> ORDER BY created DESC" --max 8
jira issue get <KEY>
```

Gotcha: JQL must go behind `--jql`; a bare positional query errors with
"unrecognized subcommand". The `jira jql` subcommand only does `parse`.

Project prefixes: LD = lexmata-models, BACK = lexmata-app-backend,
OCR = lexmata-ocr, BC = lexmata-batch-completion, LIT =
lexmata-litify-integration. Always check for an existing ticket
(`issue list` + `git log --grep`) before creating one — parallel agent
sessions routinely create the ticket and even merge the work first.

## AWS: IaC only, never by hand

All AWS state changes go through Pulumi in `lexmata-infrastructure`.
NEVER mutate cloud state directly: no console clicks, no imperative
`aws` mutating calls (`register-task-definition`, `update-pipe`,
`update-service`, `put-*`/`create-*`/`delete-*`, …), no hand-applied
CloudFormation, no boto3 resource code outside IaC.

- Read-only calls (`describe-*`, `list-*`, `get-*`) are fine — observing
  is not changing.
- Deploy = version bump in `Pulumi.<stack>.yaml` on a branch +
  `pulumi preview` + `pulumi up` with the per-stack profile
  (`lexmata-staging-sso`, `lexmata-production-sso`). The `@iac-review`
  subagent enforces this on any deploy-shaped work.
- Never deploy from a worktree. `pulumi up` runs only from Pulumi
  program code that has passed code review and merged to `develop`
  (i.e. from a clean checkout at the `develop` tip, never from a
  feature worktree with unmerged changes).

## Git push/merge: code review optional

- A code review before pushing or merging is optional, not required. Push
  and merge when asked, without blocking on a review first.
- When a review would help (risky or security-sensitive changes, large
  diffs) — or the user asks for one — run the `lex-review` skill on the
  exact diff and report the findings before pushing/merging. If you run a
  review, let the user see the findings before you ship.
- Still never force-push or merge over an explicit user objection.

## Git: never on develop/main, worktrees in .worktrees/

- Never work directly on `develop`, `main`, or `master`: no commits,
  no uncommitted feature edits. All feature work happens on a
  `feature/<TICKET>-<slug>` branch inside a linked worktree.
- Worktree root is `.worktrees/` at the repo root (plural — matches the
  existing convention and eslint ignores). Invoke the
  `using-git-worktrees` skill at the start of feature work; it handles
  isolation detection, placement, and setup.
- `.worktrees/` must stay git-ignored; verify with
  `git check-ignore -q .worktrees` before first use in a repo.
