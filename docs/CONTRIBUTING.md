# Contributing guidelines:

Fork the repository and make changes on your fork in a feature branch:

If it's a bug fix branch, name it `XXXX-something` where `XXXX` is the number of the issue.
If it's a feature branch, create an enhancement issue to announce your intentions, and name it `XXXX-something` where
`XXXX` is the number of the issue.

Submit tests for your changes. Take a look at existing tests for inspiration.
Run the full test suite on your branch before submitting a pull request.

Write clean code. Universally formatted code promotes ease of writing, reading, and maintenance.

Pull requests descriptions should be as clear as possible and include a reference to all the issues that they address.

Code review comments may be added to your pull request. Discuss, then make the suggested modifications and push additional
commits to your feature branch. Be sure to post a comment after pushing. The new commits will show up in the pull request
automatically, but the reviewers will not be notified unless you comment.

Pull requests must be cleanly rebased ontop of master without multiple branches mixed into the PR.

Commits that fix or close an issue should include a reference like `Closes #XXXX` or Fixes `#XXXX`, which will automatically close the issue 
when merged.
