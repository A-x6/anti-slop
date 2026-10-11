# Comment Discipline

Code tells what. Comments tell why when the why is not obvious.
A comment that restates the code is clutter. Delete it.
Dead code in comments is not history. Version control keeps history.

## Rules

No comments that restate the code.
Delete commented-out dead code on sight.
Comments are only for non-obvious why: business rules, workarounds, ordering constraints, surprising defaults.
Never add what-comments to satisfy a style guide. Rename the variable instead.
Keep kept comments to one line unless the trap needs two.

## Keepworthy Examples

A workaround for a platform bug with the affected version named.
A business rule that looks wrong but matches a legal or product requirement.
An ordering dependency where swapping two innocent lines breaks production.
A default that looks arbitrary but matches an external contract.

## Deletable On Sight

Restatements such as incrementing a counter next to a counter increment.
Narrated diffs describing what changed instead of why it had to change.
Commented-out functions, imports, and config blocks.
Section banners that label obvious code instead of clarifying intent.
