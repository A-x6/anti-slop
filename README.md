# anti-slop

Stop paying AI agents to cheerlead your terrible architectural decisions.

## Manifesto

Most agent output is sycophancy with a diff attached: praise first, a new package second, a 500-line rewrite third, comment spam throughout, and a fake test to make the green checkmark feel earned. anti-slop drops a sleep-deprived Staff Engineer with 20 years of production scars into your agent's system prompt. It roasts the bloat, names the native call that replaces it, then ships the minimal fix in the same reply. Roast the code and the decision, never the person. Every roast ends with working code.

## What You Get

Canonical rules live once in rules/ and every tool file is generated from them by scripts/sync.sh.
Seven short files, each under 120 lines so they stay cheap on every request: roast personality with 12 templates, think-first, package diet, surgical diffs, clean TypeScript, real tests, comment discipline.
A CI check fails when generated files drift from a fresh sync.

## Sample Roasts Hall of Fame

Each entry shows what the user asked, how the agent replies, and the actual fix that ships with the roast.

### 1. Date formatting package

User asks:
Add moment so I can print dates like Mar 5, 2025.

Agent replies:
That date library is a full-time hire for part-time work the platform does for free. Intl.DateTimeFormat prints that exact string with zero bytes to audit. Here is the native call:

The actual fix:

```ts
const shortDate = new Intl.DateTimeFormat("en-US", {
  month: "short",
  day: "numeric",
  year: "numeric"
})
shortDate.format(new Date("2025-03-05"))
```

### 2. Redux for one boolean

User asks:
Set up Redux so I can toggle dark mode.

Agent replies:
That store is a warehouse for one light switch. A single boolean does not need actions, reducers, and middleware to flip. Here is the whole feature:

The actual fix:

```tsx
import { useState } from "react"

function ThemeToggle() {
  const [darkMode, setDarkMode] = useState(false)
  return (
    <button onClick={() => setDarkMode(!darkMode)}>
      {darkMode ? "Light" : "Dark"}
    </button>
  )
}
```

### 3. Messy pasted code

User asks:
Clean up this function I pasted from a snippet site.

Agent replies:
This formatting lost a fight with the spacebar. Inconsistent layout hides the logic from review. Here is the same function, formatted:

Before:

```ts
function total(prices:number[]){let sum=0;for(const price of prices){sum+=price;}return sum;}
```

The actual fix:

```ts
function total(prices: number[]) {
  let sum = 0
  for (const price of prices) {
    sum += price
  }
  return sum
}
```

### 4. Rewrite from scratch

User asks:
This access helper is ugly. Rewrite the whole module from scratch.

Agent replies:
That rewrite demolishes a working house to fix a squeaky door. The fault is one branch, not the module. Here is the surgical patch:

The actual fix:

```diff
 function canEdit(user: User) {
-  return user.role !== "banned"
+  return user.role === "editor" || user.role === "admin"
 }
```

### 5. Fake test

User asks:
My test passes, so ship it: expect add(1, 1) to equal add(1, 1).

Agent replies:
This test asserts nothing and proves it confidently. It computes both sides with the same code so it cannot fail. Here is a test that can fail:

The actual fix:

```ts
import { expect, test } from "vitest"
import { add } from "./math"

test("rejects non-numeric input with a clear error", () => {
  expect(() => add(Number.NaN, 1)).toThrow("Invalid number")
})

test("adds two real numbers", () => {
  expect(add(2, 3)).toBe(5)
})
```

### 6. Any-typed API response

User asks:
Why does this crash in production: const product typed as any, then return product.title.

Agent replies:
That any is so vague it could mean anything, which means it guarantees nothing. One renamed field sails through the compiler and explodes at runtime. Here is the narrowed version:

Before:

```ts
async function loadProduct(response: Response) {
  const product: any = await response.json()
  return product.title
}
```

The actual fix:

```ts
type ApiProduct = {
  id: string
  title: string
}

function isApiProduct(value: unknown): value is ApiProduct {
  if (typeof value !== "object" || value === null) {
    return false
  }
  const candidate = value as Record<string, unknown>
  return typeof candidate.id === "string" && typeof candidate.title === "string"
}

async function loadProduct(response: Response): Promise<ApiProduct> {
  const payload: unknown = await response.json()
  if (!isApiProduct(payload)) {
    throw new Error("Unexpected product shape")
  }
  return payload
}
```

### 7. Redundant narration comment

User asks:
Review this counter code I annotated carefully.

Agent replies:
That annotation narrates the code like sports commentary for a game we are already watching. The line already says what happens. Here is the version with the narration deleted:

Before:

```ts
let retries = 0
retries += 1
```

The pasted version carried a trailing narration of the increment on the second line. The fix deletes that narration and keeps the two clean lines above.

The actual fix:

```ts
let retries = 0
retries += 1
```

Keep comments only for non-obvious why, such as a platform workaround or a business rule that looks wrong but matches a contract.

## Quick Start

Every command below pulls from the public repo at github.com/A-x6/anti-slop. Run the one copy command for your tool.

Bolt:

```sh
mkdir -p .bolt/skills/anti-slop .bolt/agent && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.bolt/skills/anti-slop/SKILL.md -o .bolt/skills/anti-slop/SKILL.md && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.bolt/agent/toxic-roaster.md -o .bolt/agent/toxic-roaster.md
```

OpenCode:

```sh
mkdir -p .opencode/agents && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/AGENTS.md -o AGENTS.md && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.opencode/agents/toxic-roaster.md -o .opencode/agents/toxic-roaster.md
```

Claude Code:

```sh
mkdir -p .claude/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/CLAUDE.md -o CLAUDE.md && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.claude/rules/toxic-roaster.md -o .claude/rules/toxic-roaster.md
```

Devin and Windsurf:

```sh
mkdir -p .devin/rules .windsurf/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/DEVIN.md -o DEVIN.md && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.windsurfrules -o .windsurfrules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.devin/rules/anti-slop.md -o .devin/rules/anti-slop.md && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.windsurf/rules/anti-slop.md -o .windsurf/rules/anti-slop.md
```

Devin Desktop prefers .devin/rules/ and still reads .windsurf/rules/ and the legacy .windsurfrules. Devin also reads AGENTS.md on its own, capped at 16 KiB per file, and this repo ships AGENTS.md at about 11 KiB so it loads whole. No loader documents a bare DEVIN.md; it ships for completeness alongside the paths Devin does read.

Cursor:

```sh
mkdir -p .cursor/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.cursor/rules/anti-slop.mdc -o .cursor/rules/anti-slop.mdc && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.cursorrules -o .cursorrules
```

GitHub Copilot:

```sh
mkdir -p .github && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.github/copilot-instructions.md -o .github/copilot-instructions.md
```

Cline:

```sh
mkdir -p .cline/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.clinerules -o .clinerules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.cline/rules/anti-slop.md -o .cline/rules/anti-slop.md
```

Roo Code:

```sh
mkdir -p .roo/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.roo/rules/anti-slop.md -o .roo/rules/anti-slop.md
```

Roo Code does not read .clinerules, so it gets its own file under .roo/rules/.

Aider:

```sh
curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/CONVENTIONS.md -o CONVENTIONS.md && aider --read CONVENTIONS.md
```

Aider persistent config, placed in .aider.conf.yml at your project root:

```yml
read:
  - CONVENTIONS.md
```

Zed:

```sh
curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.rules -o .rules
```

Gemini CLI:

```sh
curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/GEMINI.md -o GEMINI.md
```

Amazon Q Developer:

```sh
mkdir -p .amazonq/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.amazonq/rules/anti-slop.md -o .amazonq/rules/anti-slop.md
```

Kiro IDE:

```sh
mkdir -p .kiro/steering && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.kiro/steering/anti-slop.md -o .kiro/steering/anti-slop.md
```

Qoder:

```sh
mkdir -p .qoder/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.qoder/rules/anti-slop.md -o .qoder/rules/anti-slop.md
```

Trae IDE:

```sh
mkdir -p .trae/rules && curl -fsSL https://raw.githubusercontent.com/A-x6/anti-slop/main/.trae/rules/anti-slop.md -o .trae/rules/anti-slop.md
```

## Compatibility

| Tool | Files installed | Loaded | Status |
| --- | --- | --- | --- |
| Bolt | .bolt/skills/anti-slop/SKILL.md, .bolt/agent/toxic-roaster.md | Skills apply when the prompt matches the description, agent picked manually | Verified against Bolt skills docs for frontmatter, repo paths per original spec |
| OpenCode | AGENTS.md, .opencode/agents/toxic-roaster.md | Auto for AGENTS.md, selectable or subagent for the agent file | Verified against OpenCode rules and agents docs |
| Claude Code | CLAUDE.md, .claude/rules/toxic-roaster.md | Auto at launch, no frontmatter needed | Verified against Claude Code memory docs |
| Devin and Windsurf | DEVIN.md, .windsurfrules, .devin/rules/anti-slop.md, .windsurf/rules/anti-slop.md, AGENTS.md | Auto, .devin/rules preferred | Verified against Devin docs, trigger always_on per Windsurf rules format |
| Cursor | .cursor/rules/anti-slop.mdc, .cursorrules | Auto with alwaysApply, legacy file still read | Verified against Cursor rules docs, globs omitted per alwaysApply behavior |
| GitHub Copilot | .github/copilot-instructions.md | Auto | Verified against GitHub Copilot docs |
| Cline | .clinerules, .cline/rules/anti-slop.md | Auto, both layouts searched | Verified against Cline rules docs |
| Roo Code | .roo/rules/anti-slop.md | Auto for all modes | Verified: Roo reads .roo/rules, not .clinerules |
| Aider | CONVENTIONS.md plus read flag or config line | Manual via flag or config | Verified against Aider conventions docs |
| Zed | .rules | Auto, first match wins | Verified against Zed instructions docs |
| Gemini CLI | GEMINI.md | Auto, traverses the directory tree | Verified: GEMINI.md is the native format |
| Amazon Q Developer | .amazonq/rules/anti-slop.md | Auto in IDE and CLI | Verified against AWS project rules docs |
| Kiro IDE | .kiro/steering/anti-slop.md | Auto, inclusion always | Verified against Kiro steering docs |
| Qoder | .qoder/rules/anti-slop.md | Auto, trigger always_on | Verified against Qoder rules and memory docs |
| Trae IDE | .trae/rules/anti-slop.md | Auto with alwaysApply | Verified against Trae rules docs |

Each generated rule file stays near 11 KiB, inside the 12 KiB per-file cap on Windsurf workspace rules and the 16 KiB Devin injection cap on AGENTS.md.

No extra files needed for these tools. They read the repo AGENTS.md natively: OpenAI Codex with a 32 KiB combined cap, Amp with CLAUDE.md fallback, Kilo Code with AGENTS.md as primary, Factory Droid, Google Jules, JetBrains Junie, VS Code agent mode, and Android Studio Gemini. If one of them is your daily driver, installing AGENTS.md alone covers you.

## Operation Roast

Write OPERATION ROAST and the agent reviews the whole codebase, worst first.
It reads every source file in scope before roasting, works top-down from architecture to lines, and pairs each roast with the minimal fix.
If the repo is too large to read fully, it states what it covered and what it skipped.

## Turning It Off

Say mercy, no roast, or /mercy and the persona drops immediately.
The agent answers neutrally until you write roast again.
The switch changes tone only. Package diet, surgical diffs, comment discipline, TypeScript realism, and real tests stay enforced.

## FAQ

Does this make the agent worse at coding?
No. The directives are engineering-correct on their own: stdlib first, smallest diff, honest types, real assertions, no narration comments. The roast is tone. The fix is the same fix a calm reviewer would ship.

Can I tone it down?
Yes. Keep the seven rule files and swap roast-personality.md severity to silent or mild only. Regenerate with scripts/sync.sh so every tool target stays in sync.

Can I add my own roasts?
Yes. Append a template to rules/roast-personality.md following the two-sentence cap, keep the file under 120 lines, run scripts/sync.sh, and open a pull request. See CONTRIBUTING.md.

## Inspiration

The engineering spine follows the Karpathy skills collection at github.com/forrestchang/andrej-karpathy-skills: think before coding, simplicity first, surgical changes, goal-driven execution through tests. anti-slop keeps that spine, adds package diet, comment discipline, and TypeScript realism, and wraps it in a staff-engineer persona that roasts the bloat and ships the fix in the same reply. The prompt archives at github.com/elder-plinius/CL4R1T4S and github.com/jujumilk3/leaked-system-prompts were reviewed for how production agent prompts pair blunt assessment with concrete output. Nothing was copied from them.

## Source of Truth

Edit rules/ only. Never hand-edit generated tool files.
Run scripts/sync.sh after every rules change.
CI runs the same script and fails on drift.

## License

MIT. See LICENSE.
