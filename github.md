# GitHub Workflows

In most cases, [GitHub flow](https://guides.github.com/introduction/flow/) will be the best choice for projects. For small teams there is usually no need for anything more complicated than this. Thoughtbot has some [additional recommendations](https://github.com/thoughtbot/guides/tree/master/protocol/git) which should be followed.

Ideally, feature branches should encompass small, targeted changes. Keeping your work focused will mean fewer merge conflicts. When building a new code base this may not always be possible, but what you want to try and avoid are long running branches. By the time you want to merge, the distance between your feature branch and master will usually mean a lot of conflict resolution in your future.

## Merging and Rebasing

The thoughtbot guide recommends pushing your feature branch to remote only when you are ready to issue a PR. This will make it easier to rebase and squash commits without making life difficult for other developers. Generally, this should be your workflow, but it’s still acceptable to rebase and squash commits on a remote branch. If no one else has based any work off your branch, this shouldn’t present any problems. If other developers have based work off your branch, you will need to coordinate any rebasing or squashing. In either case, you should clearly communicate to the team that you have done either of these actions.

The one important difference to note from the thoughtbot guide is in the section on merging. Merging GitHub PRs through the Web interface will always use `--no-ff`. If merging from the command line, instead of doing:

```bash
$ git merge <branch-name> --ff-only
```

you should do:

```bash
$ git merge <branch-name> --no-ff
```
