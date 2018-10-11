---
order: 1000
---
### GitHub 

#### Recommended repo settings

In the admin settings for repos on GitHub, the recommended settings are: 
* Default branch should be "master" (`Branches > Default branch`)
* Disable force push to  the master branch. For everyone. Even admins. (`Branches > Protected branches`)
* Edit the protected branch and check these option settings: 
    - protect this branch
    - require pull request reviews before merging
    - dismiss stale pull request approvals when new commits are pushed
    - require that branches are up to date
    - include administrators
* Allow merge commits (`Options > Merge button`)

#### Workflows

In most cases, [GitHub flow](https://guides.github.com/introduction/flow/) will be the best choice for projects. For small teams there is usually no need for anything more complicated than this. Thoughtbot has some [additional recommendations](https://github.com/thoughtbot/guides/tree/master/protocol/git) which should be followed.

Ideally, feature branches should encompass small, targeted changes. Keeping your work focused will mean fewer merge conflicts. When building a new code base this may not always be possible, but what you want to try and avoid are long running branches. By the time you want to merge, the distance between your feature branch and master will usually mean a lot of conflict resolution in your future.

##### Merging and Rebasing

The thoughtbot guide recommends pushing your feature branch to remote only when you are ready to issue a PR. This will make it easier to rebase and squash commits without making life difficult for other developers. Generally, this should be your workflow, but it’s still acceptable to rebase and squash commits on a remote branch. If no one else has based any work off your branch, this shouldn’t present any problems. If other developers have based work off your branch, you will need to coordinate any rebasing or squashing. In either case, you should clearly communicate to the team that you have done either of these actions.

The one important difference to note from the thoughtbot guide is in the section on merging. Merging GitHub PRs through the Web interface will always use `--no-ff`. If merging from the command line, instead of doing:

```bash
$ git merge <branch-name> --ff-only
```

you should do:

```bash
$ git merge <branch-name> --no-ff
```

#### Pull Request Reviews

In most (all) cases, pull requests should be reviewed by at least one other developer, even if it is just for syntax or raise general questions in the case of unfamiliarity with a particular language. 

When creating a new pull request, you need to pick what branch you're merging - usually your dev branch - and what you're aiming to merge into - usually master - and then create a logical title and add a description that includes: 
* required: an explanation of what the reason/function of the code in the PR (the "why")
* required: an explanation of what code changed in the PR (the "what")
* optional: Link(s) to view changes, associated JIRA tickets, or other links that may be useful for understanding the changes in the PR.
* optional: mention any person who may need to be aware of the changes in the PR (PM, UX, BO, or other devs)

The above can be included in a nice commit message (add template example).

You should then assign one or more reviewers. (If you have more than one, you may want to mention in the description what each should be reviewing).

Other notes: 
"WIP" indicates a PR that is a work-in-progress that is not ready for review, but can be useful for comparing diffs as you work, or sharing in-progress work with others to see or comment on. In general, WIP PRs can be ignored.

#### Github and JIRA

In general, if you are creating code on GitHub, commenting and review should happen there, with the code. If you are also using JIRA, you should add a comment with a link to the PR to the story in JIRA and move the story to the Review column to indicate that the PR is under review.

(If changes are not commited to GitHub - like with Wordpress configurations - the comments and review should happen in JIRA; Mention reviewers by name in a comment on the ticket, what they should be reviewing, where they can view the changes, and then move the story to the Review column.)

- - -

#### GitHub basics

This process assumes you have: a terminal program (like the OS terminal or iTerm with oh-my-zsh), an editor program (like Sublime Text or Atom), a github account and access to the MIT Libraries repos, and have already cloned the repos to your local machine. (For help with those steps, contact one of the MITLib devs.)

**Start fresh**: Checkout master branch

```git checkout master```

**Get latest**: Get the latest changes that have been merged 
```
git fetch
git merge
```

**Create a branch**: Create a new branch starting with master (or the branch you want to base your work on): This is the clean separate space where you will put your work.

```git checkout -b [branchname]```

**Do stuff**: open the repo in your editor and write code or make edits that relate to the fix/feature/experiment you are working on.

**Commit your changes regularly**: once you have a few changes that add up to something (eg. 'added new js function to load rss' or 'added new css to support adjusted mini-cal alignment') or if you have to stop for a bit or switch to something else, add the files you are ready to commit, then commit them to your branch and push them to github. Please use helpful commit messages! Here are some [guidelines for writing good commit messages](https://chris.beams.io/posts/git-commit/).

```
git add [filename] 
git add [filename] 
...
git commit
[add a good description of what's in the commit]
git push
```

**Do more stuff**: keep working and committing (repeat steps 4 and 5) until your work for that fix/feature/experiment is as complete as you can make it.

**Make a PR**: go to github and create a new PR for your branch against master/prod branch (see Pull Request Reviews above). 

**Respond to PR feedback**: as feedback comes in, create additional commits to address and push them up. Do NOT squash/rebase during review as that makes headaches for reviewers.

**Get thumbs**: once each reviewer is done with their review and happy with the code that will be merged, they should approve the PR and give a thumbs up  :+1:

**Squash commits (optional)**: before merging, squash all your work into logical commits - or one single commit - that summarizes the changes.

**Merge the PR**: merge the PR on github and delete the branch.

**Fetch latest master**: Return to your terminal, checkout the master branch and fetch and merge the latest changes.
```
git checkout master
git fetch
git merge
```

##### Advanced topics 
The following topics are useful to get to know but often require someone knowledgable with git to teach or at least have nearby for questions/abort commands.
* Rebasing
* Merge conflicts
