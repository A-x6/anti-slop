# Before and After

Five real patterns. Each shows the slop, the roast, and the minimal fix.

## 1. Date Library for One Format

Before:

```ts
import moment from "moment"

function printDate(input: string) {
  return moment(input).format("MMM D, YYYY")
}
```

Roast: that import is a full-time hire for part-time work the platform does for free. One format string does not justify a legacy date engine.

After:

```ts
const shortDate = new Intl.DateTimeFormat("en-US", {
  month: "short",
  day: "numeric",
  year: "numeric"
})

function printDate(input: string) {
  return shortDate.format(new Date(input))
}
```

## 2. State Library for One Boolean

Before:

```ts
import { configureStore, createSlice } from "@reduxjs/toolkit"

const themeSlice = createSlice({
  name: "theme",
  initialState: { darkMode: false },
  reducers: {
    toggleTheme(state) {
      state.darkMode = !state.darkMode
    }
  }
})

const store = configureStore({ reducer: themeSlice.reducer })
```

Roast: that store is a warehouse for one light switch. A boolean does not need slices and a store to flip.

After:

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

## 3. Rewrite Versus Patch

Before, the request: rewrite the whole access module because one branch is wrong.

Roast: that rewrite demolishes a working house to fix a squeaky door. The fault is one comparison, not the module.

After, the patch:

```diff
 function canEdit(user: User) {
-  return user.role !== "banned"
+  return user.role === "editor" || user.role === "admin"
 }
```

## 4. Fake Test Versus Real Test

Before:

```ts
import { expect, test } from "vitest"
import { add } from "./math"

test("adds", () => {
  expect(add(1, 1)).toBe(add(1, 1))
})
```

Roast: this test asserts nothing and proves it confidently. Both sides run the same code, so it passes even when the answer is wrong.

After:

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

## 5. Any Versus Narrowed Unknown

Before:

```ts
async function loadProduct(response: Response) {
  const product: any = await response.json()
  return product.title
}
```

Roast: that any is so vague it could mean anything, which means it guarantees nothing. A renamed field passes the compiler and crashes the user.

After:

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

## 6. Narration Comment Versus Clean Code

Before, the pasted snippet carried a trailing narration of the increment on the increment line, restating in words what the symbols already say.

Roast: that narration calls play-by-play for a game we are already watching. The line needs no translator.

After:

```ts
let retries = 0
retries += 1
```

Keep comments for non-obvious why only, such as a platform workaround with the affected version named or a business rule that looks wrong but matches a contract.
