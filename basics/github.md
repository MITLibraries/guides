# GitHub 

## Recommended repo settings

In the admin settings for repos on GitHub, the recommended settings are: 
* Default branch should be "main" (`Branches > Default branch`)
* Disable force push to the main branch. For everyone. Even admins. (`Branches > Protected branches`)
* Edit the protected branch and check these option settings: 
    - protect this branch
    - require pull request reviews before merging
    - require status checks to pass before merging
    - require that branches are up to date
* Allow merge commits (`Options > Merge button`)
* **Required for Terraform repos** Disable squash commits (`Options > Merge button`)

## Workflows

In most cases, [GitHub flow](https://guides.github.com/introduction/flow/) will be the best choice for projects. For small teams there is usually no need for anything more complicated than this. Thoughtbot has some [additional recommendations](https://github.com/thoughtbot/guides/tree/main/git) which should be followed.

Ideally, feature branches should encompass small, targeted changes. Keeping your work focused will mean fewer merge conflicts. When building a new code base this may not always be possible, but what you want to try and avoid are long running branches. By the time you want to merge, the distance between your feature branch and main will usually mean a lot of conflict resolution in your future.

There is an exception to this for Infrastructure code. For the Terraform code, InfraEng uses a Simplified Git Flow model (which could also be seen as GitHub Flow on steroids). In this case, each deployment environment (prod & stage) is linked to a long-running branch in the repository. As in GitHub Flow, feature branches should encompass small, targeted changes. They are always branched from and merged to the `stage` branch. And the only merges to the `main` branch come from approved merges on the `stage` branch. More details on this model can be found at [Simplified Git Flow](https://medium.com/goodtogoat/simplified-git-flow-5dc37ba76ea8) and at [Simplified Git Flow for InfraEng](https://mitlibraries.atlassian.net/wiki/spaces/IN/pages/2920480769/Simplified+Git+Flow+For+InfraEng).

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

## Pull Requests

We use pull requests to merge changes to a codebase. In nearly all instances, pull requests should be reviewed by
another person before merging. Check out our [code review guide](/collaboration/code_review.html) for more information
on how this works.

## Github and JIRA

In general, if you are creating code on GitHub, commenting and review should happen there, with the code. If you are also using JIRA, you should add a comment with a link to the PR to the story in JIRA and move the story to the Review column to indicate that the PR is under review.

(If changes are not commited to GitHub - like with Wordpress configurations - the comments and review should happen in JIRA; Mention reviewers by name in a comment on the ticket, what they should be reviewing, where they can view the changes, and then move the story to the Review column.)

## GitHub and Code Climate

We use [Code Climate](https://codeclimate.com/)'s GitHub integration to monitor 
for code smells. Code Climate is free for open source repositories.

To connect Code Climate to your repo:
1. [Log in to Code Climate](https://codeclimate.com/login) with your GitHub 
account
2. If it's your first time logging in, grant Code Climate OAuth permissions as 
prompted
3. Follow the prompts to add your repo:
    * On the dashboard, click the 'Open source' link, then click 'Add a repository'
    * Find your repo on the ensuing list, then click 'Add repository' _(note: you 
may need to click the 'Sync now' link for all repos to appear)_
4. Continue to your repo dashboard in Code Climate, then click the 'Repo settings' 
tab. Click 'GitHub' on the menu, then install 'Pull request status updates' and 
'Webhook on GitHub'
5. Code Climate should now run in GitHub every time you open a PR. In your 
GitHub repo, you can confirm this by going to Settings -> Webhooks and make 
sure the Code Climate webhook is listed _(note: if Code Climate is stuck pending 
in your PR, it might be because you opened the PR prior to configuring Code Climate)_

## Updating the default branch in GitHub

While all new repos will be created with `main` as the default branch, older 
repos may still use `master` and should be migrated. GitHub now provides an
easy way to do this in the web UI. In the repo's settings, you can
change the name of the default branch.

Once you change the branch name, you and your collaborators will need to pull
the changes to your cloned repos.

Additionally, you should check any automations you have configured to ensure
they are watching the new branch (e.g., CodeClimate, CI/CD).

- - -

## GitHub basics

This process assumes you have: a terminal program (like the OS terminal or iTerm with oh-my-zsh), an editor program (like Sublime Text or Atom), a github account and access to the MIT Libraries repos, and have already cloned the repos to your local machine. (For help with those steps, contact one of the MITLib devs.)

**Start fresh**: Checkout main branch

```git checkout main```

**Get latest**: Get the latest changes that have been merged 
```
git fetch
git merge
```

**Create a branch**: Create a new branch starting with main (or the branch you want to base your work on): This is the clean separate space where you will put your work.

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

**Make a PR**: go to github and create a new PR for your branch against main/prod branch (see Pull Request Reviews above). 

**Respond to PR feedback**: as feedback comes in, create additional commits to address and push them up. Do NOT squash/rebase during review as that makes headaches for reviewers.

**Get thumbs**: once each reviewer is done with their review and happy with the code that will be merged, they should approve the PR and give a thumbs up  :+1:

**Squash commits (optional)**: before merging, squash all your work into logical commits - or one single commit - that summarizes the changes. **Note**: do not use GitHub's *Squash and Merge* option to do the squashing!

**Merge the PR**: merge the PR on github and delete the branch.

**Fetch latest main**: Return to your terminal, checkout the main branch and fetch and merge the latest changes.
```
git checkout main
git fetch
git merge
```

## Advanced topics 

The following topics are useful to get to know but often require someone knowledgable with git to teach or at least have nearby for questions/abort commands.
* Rebasing
* Merge conflicts
