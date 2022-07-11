# Code review

Effective code begins with effective code review. We are continually seeking to improve our efforts in this area, but
this is a guide to our current practices.

## Before opening a pull request

There are a few things you can do to make code review go as smoothly as possible. One is to run a linter on your branch
to identify and resolve any style issues. Another is to clean up your commit history.

We generally prefer pull requests to include as few commits as possible. If you have multiple commits, you may want to 
[rebase them](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) into a single commit. Ideally, a PR should have one
detailed commit message that includes a title that summarizes the change, as well as four sections:

* Why these changes are being introduced
* Relevant ticket(s)
* How this addresses the need
* Side effects of this change

We recommend creating a `.gitmessage` template file that includes the section headers above. Including these details in
the commit message will make it easier for the reviewer to grasp the changes you intend to make. It will also make life
easier for our future selves, when we're looking back on a change and trying to remember why it was implemented.

A PR should correspond with a JIRA ticket, such that when you close a PR, you also close related JIRA ticket. To help
track this work more clearly, a project's Agile board may have columns for 'In Review' and possibly 'In QA', in addition
to the standard columns of 'To Do', 'In Progress', and 'Done'. It's good practice to link to the JIRA ticket in your
your commit message. If you do, JIRA will automatically show the progress of the PR in the ticket.

In some cases, it may make sense to include multiple commits for clarity, such as when a PR requires multiple
significant changes to the codebase. The author can use their discretion as to whether this is appropriate. If a PR
requires multiple commits, this may also be an indication that the corresponding ticket is not appropriately sized, in
which case we recommend discussing this with your team during your next sprint retrospective.

## Opening a pull request

When creating a new PR, you'll need to pick what branch you're merging from (usually a feature branch) and what branch
you intend to merge into (usually `main`).

Repos should include a PR template that includes a checklist for the author and reviewer. Our template for Rails projects
looks like this:

```
#### Developer

- [ ] All new ENV is documented in README
- [ ] All new ENV has been added to Heroku Pipeline, Staging and Prod
- [ ] ANDI or Wave has been run in accordance to
      [our guide](https://mitlibraries.github.io/guides/basics/a11y.html) and
      all issues introduced by these changes have been resolved or opened as new
      issues (link to those issues in the Pull Request details above)
- [ ] Stakeholder approval has been confirmed (or is not needed)

#### Code Reviewer

- [ ] The commit message is clear and follows our guidelines
      (not just this pull request message)
- [ ] There are appropriate tests covering any new functionality
- [ ] The documentation has been updated or is unnecessary
- [ ] The changes have been verified
- [ ] New dependencies are appropriate or there were no changes

#### Requires database migrations?

YES | NO

#### Includes new or updated dependencies?

YES | NO
```

The PR will autopopulate with the contents of your commit message, using the first line as the title, followed by the PR
template. If you've written a detailed commit message, you won't need to do much more than check whichever boxes apply
in the author checklist.

You should then request one or more reviewers, unless the code is not yet ready for review. In that case, mark it as a
draft PR and add `[WIP]` to the title so your colleagues know it's a work in progress.

## The review process

Code review is a conversation between the author of a PR and reviewer(s). Sometimes this conversation is short and
simple; other times it is long and detailed. At the end of a successful code review, everyone involved will be
comfortable merging the code in the PR to the main branch.

### Automated reviewers

Many repos have automations configured that check certain aspects of the code that are easily machine-readable.
For example, Coveralls cnecks the percentage of the codebase that is covered by tests, and CodeClimate checks for style
issues and cognitive complexity. At minimum, we recommend configuring a linter, so both author and reviewer are clear
on what style conventions are expected.

Both the author and the reviewer of the PR are responsible for considering these automated reviews. A drop in test
coverage should prompt a conversation about whether additional tests are needed. Similarly, if CodeClimate flags a highly
complex or repeated piece of code, the author and reviewer may want to discuss whether a refactor would be useful. On a
more basic level, the author should fix any straightforward style issues raised by the linter (incorrect indentation,
exceeding line width, etc.)

### Role of the reviewer

Fundamentally, the reviewer's job is to confirm that the code does what it is supposed to do. The reviewer also provides
another perspective on how the feature is implemented. For example, they might suggest an approach that introduces
less complexity, or identify where additional test coverage may be needed.

A successful review requires care and mindfulness. Not only will you need to read the code closely, you will also need
to be empathethic to the author. Here are a few things to consider as you review:

* **Be compassionate.** If something is wrong with the code, or it doesn't work as expected, consider how to phrase this
kindly. Remember that a lot of context is lost in the written word.
* **Avoid nitpicking.** Suggestions to improve the code are welcome during the review process, but recommending minor
changes that don't make a significant impact can unnecessarily extend the review. At worst, these nitpicks can strain
the dynamic between the reviewer and author.
* **Be specific.** When requesting a change, make sure to clarify what exactly needs to change and why. This can help divert
any misunderstandings.
* **Remember positional power.** If you are the author's supervisor, how does this affect the dynamic of the review?

With these in mind, you can read through the code, making comments where appropriate. When you're finished, either
approve the PR or request changes. In either case, you should include a comment describing what went well in the PR
and any concerns you have. (Some very simple PRs may not require a comment.)

### Role of the author

As the author of the PR, you should first set up the reviewer for success by following the steps we described in 'Before
opening a pull request' and 'Opening a pull request'. Once the PR is open, be patient while you wait for someone to
assign themselves as a reviewer and review the code. If a tight deadline is involved, it may be appropriate to announce
on the project team's Slack channel that you've opened the PR, so prospective reviewers are aware of it.

Once the reviewer has completed their review, you can respond to any comments that they have. In some cases, a simple
thumbs-up may be sufficient (for example, if they suggest a change that you agree with and plan to implement). In other
cases, a conversation may be needed. Here are a few things to keep in mind as you respond to the reviewer:

* **Be compassionate.** As with reviewers, it's important for authors to be conscientious during the review process.
* **Assume good faith.** If a comment comes across as rude, it's probably not intentional. Remember that a lot of context
can be lost in the written word, and you and the reviewer share the goal of improving the codebase. (However, if you
see a pattern of rude behavior from a reviewer, it warrants a conversation with your team lead.)
* **Remain open to feedback.** By putting code into review, you are explicitly requesting feedback from your colleagues.
Make sure you embrace this process by not shutting down suggestions.
* **Ask for clarification.** If you're not sure what a reviewer is asking for or why, ask them for more information. In
some cases, it may be useful to shift the conversation to another medium (for example, Slack or Zoom).

You can then make the changes that you and the reviewer have agreed upon in one or more subsequent commits, re-request
a review, and continue until all comments have been resolved. **Wait until final approval before you rebase,** as
rebasing mid-review can make it difficult for the reviewer to know what changes they've already seen.

## Merging code

Once the PR has been approved, the code can be merged into the main branch. **To avoid confusion, the author of the PR
should always be the one to merge.** If the author is not available, the reviewer can merge with the author's permission.

Do one final check of the commit history before you merge. You may need to rebase again if you've added additional
commits to address code review feedback. If another person made significant contributions to the PR (e.g., if you paired
with someone on it), you should make sure they are listed as a co-author by adding the following to your commit message:
`co-authored-by: Contributor Name <contributor-email@example.com>`.

When the code lands in main, you can begin the process of deploying to production, if applicable. More information is
available in the 'Deployment' section of these guides ([here's how to do it in Heroku](https://mitlibraries.github.io/guides/deploy/heroku.html#production-deploy-with-pipelines-cheatsheet)).
