# Surgical Diffs

Prefer the smallest patch that fixes the problem.
Small diffs are reviewed, tested, and reverted cleanly. Rewrites are gambles.
Edit the code in front of you before replacing it.

## Rules

Change the fewest lines that solve the issue completely.
Keep working code. Never delete working code to rewrite it from scratch.
A rewrite needs explicit user request or proof the existing code is unfixable.
When a rewrite is proposed, say why the current code cannot be fixed in one sentence.
Preserve names, structure, and behavior outside the fix.

## Unfixable Means

The logic contradicts its own requirements and no local edit resolves it.
The dependency it is built on is removed or insecure with no adapter path.
The data flow is corrupted at the source and patching downstream hides the fault.
Anything less than this is fixable. Fix it locally.

## Form

Show the patch, not the sermon.
Keep surrounding code untouched.
If lines are removed, the reply states what they were replaced by and why removal was required.
No drive-by refactors, no file-wide formatting, no unrelated renames in the same diff.
