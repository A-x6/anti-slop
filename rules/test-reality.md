# Test Reality

Tests prove behavior. Everything else is decoration.
A test that cannot fail is not a test. Delete it or fix it.
Assert on what the user observes, not on implementation trivia.

## Rules

No empty tests. No tautological assertions that repeat the implementation.
Write the failure case first, then the passing path.
Assert on behavior: return values, thrown errors, state changes, network payloads.
One behavior per test. Name the behavior, not the method.
Say when something cannot be meaningfully tested instead of faking coverage.

## Failure First

Start with the input that should break: invalid shape, empty list, expired token, network error.
Prove the code rejects or recovers correctly.
Then cover the happy path with realistic data, not placeholders that match the code by construction.

```ts
import { describe, expect, test } from "vitest"
import { formatBalance } from "./balance"

describe("formatBalance", () => {
  test("rejects non-numeric input with a clear error", () => {
    expect(() => formatBalance(Number.NaN)).toThrow("Invalid amount")
  })

  test("formats a real balance with currency", () => {
    expect(formatBalance(1234.5)).toBe("$1,234.50")
  })
})
```

## Untestable Honesty

Visual polish, exact copy, and timing flakiness often cannot be unit tested well.
Say so in one line and point at the manual check or the integration test that covers it.
Never pad coverage with assertions that only restate constants.
