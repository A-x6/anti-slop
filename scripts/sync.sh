#!/bin/sh
set -eu
ROOT_DIR=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
HEADER_LINE="Generated from rules/ by scripts/sync.sh. Do not edit directly."
RULES_DIR="$ROOT_DIR/rules"
ROAST_FILE="$RULES_DIR/roast-personality.md"
THINK_FILE="$RULES_DIR/think-first.md"
DIET_FILE="$RULES_DIR/package-diet.md"
DIFFS_FILE="$RULES_DIR/surgical-diffs.md"
TYPES_FILE="$RULES_DIR/clean-typescript.md"
TESTS_FILE="$RULES_DIR/test-reality.md"
NOTES_FILE="$RULES_DIR/comments.md"
mkdir -p "$ROOT_DIR/.bolt/skills/anti-slop" "$ROOT_DIR/.bolt/agent" "$ROOT_DIR/.opencode/agents" "$ROOT_DIR/.claude/rules" "$ROOT_DIR/.cursor/rules" "$ROOT_DIR/.github" "$ROOT_DIR/.devin/rules" "$ROOT_DIR/.windsurf/rules" "$ROOT_DIR/.cline/rules" "$ROOT_DIR/.roo/rules"
append_rules() {
  cat "$ROAST_FILE" "$THINK_FILE" "$DIET_FILE" "$DIFFS_FILE" "$TYPES_FILE" "$TESTS_FILE" "$NOTES_FILE"
}
write_plain() {
  {
    printf '%s\n\n' "$HEADER_LINE"
    append_rules
  } > "$1"
}
write_bolt_skill() {
  {
    printf '%s\n' "---" "name: anti-slop" "description: Use when writing, editing, or reviewing code in any language. Enforces staff-engineer discipline: roasts bloat, then ships the minimal fix. Covers package diet, surgical diffs, comment discipline, TypeScript realism, real tests." "---" ""
    printf '%s\n\n' "$HEADER_LINE"
    append_rules
  } > "$1"
}
write_opencode_agent() {
  {
    printf '%s\n' "---" "description: Sleep-deprived staff engineer who roasts slop then ships the minimal fix" "mode: primary" "---" ""
    printf '%s\n\n' "$HEADER_LINE"
    append_rules
  } > "$1"
}
write_cursor_rule() {
  {
    printf '%s\n' "---" "description: Anti-slop staff-engineer discipline" "alwaysApply: true" "---" ""
    printf '%s\n\n' "$HEADER_LINE"
    append_rules
  } > "$1"
}
write_devin_rule() {
  {
    printf '%s\n' "---" "trigger: always_on" "---" ""
    printf '%s\n\n' "$HEADER_LINE"
    append_rules
  } > "$1"
}
write_plain "$ROOT_DIR/.bolt/agent/toxic-roaster.md"
write_plain "$ROOT_DIR/AGENTS.md"
write_plain "$ROOT_DIR/CLAUDE.md"
write_plain "$ROOT_DIR/.claude/rules/toxic-roaster.md"
write_plain "$ROOT_DIR/DEVIN.md"
write_plain "$ROOT_DIR/.windsurfrules"
write_plain "$ROOT_DIR/.cursorrules"
write_plain "$ROOT_DIR/.github/copilot-instructions.md"
write_plain "$ROOT_DIR/.clinerules"
write_plain "$ROOT_DIR/.cline/rules/anti-slop.md"
write_plain "$ROOT_DIR/.roo/rules/anti-slop.md"
write_plain "$ROOT_DIR/CONVENTIONS.md"
write_plain "$ROOT_DIR/.rules"
write_bolt_skill "$ROOT_DIR/.bolt/skills/anti-slop/SKILL.md"
write_opencode_agent "$ROOT_DIR/.opencode/agents/toxic-roaster.md"
write_cursor_rule "$ROOT_DIR/.cursor/rules/anti-slop.mdc"
write_devin_rule "$ROOT_DIR/.devin/rules/anti-slop.md"
write_devin_rule "$ROOT_DIR/.windsurf/rules/anti-slop.md"
