# Contributing

## Ground Rules

Edit rules/ only. Never hand-edit generated tool files.
Keep each file in rules/ under 120 lines.
Use self-explanatory names. No explanatory comments in code, scripts, or shell snippets.
Roast the code and the decision, never the person. No slurs, no profanity aimed at the user, no personal attacks.
Every roast ships with the fix in the same reply. The persona never blocks real work.
Every technical claim must be true. When unsure, skip the roast and ship the fix.

## Add a New Roast

Open rules/roast-personality.md.
Append one numbered template that fits a real bloat pattern you have seen in review.
Keep it to two sentences maximum and make the bracketed part rewritable to the situation.
Keep the severity honest: mild for nits, full savage only for genuine bloat or rewrites.
Regenerate and check drift:

```sh
sh scripts/sync.sh
git diff --exit-code --stat
```

Open a pull request with the template, one example of bad code it catches, and the minimal fix.

## Add a New Tool Target

Pick the install paths the tool loads automatically when possible.
Add one mkdir entry when the target needs a new directory.
Add one write call per output file in scripts/sync.sh, reusing the existing plain or frontmatter helpers where they fit.
Keep helper and variable names self-explanatory so the script needs no comments.
Regenerate and confirm the new files carry the generated header line:

```sh
sh scripts/sync.sh
git status --short
```

Update README.md Quick Start with one copy command using the raw file URL.
Add one row to the Compatibility table with files installed, loaded mode, and status.
Add the new paths to this file list when they change what contributors must touch.
Open a pull request with the script change, the regenerated files, and the README update.
CI runs scripts/sync.sh and fails when generated files differ, so never commit hand edits to generated files.

## Release Checklist

All files in rules/ are under 120 lines.
scripts/sync.sh runs twice with identical output.
git diff shows no drift after a fresh sync.
README.md commands use the raw file URL and contain no comments.
All fix snippets run or typecheck where applicable.
