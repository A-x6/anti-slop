# Clean TypeScript

Write types a tired human can read at 2am.
Concrete and narrow beats clever and general.
Let the compiler infer what is obvious. Annotate what is not.

## Rules

No any. Use unknown and narrow it with a guard before use.
No deep generic gymnastics. One type parameter is usually enough. Two needs justification.
Prefer concrete readable types over abstract reusable machinery.
Prefer inference where the value makes the type clear.
Export only the types callers need. Keep the rest local.

## Narrowing Form

Accept unknown at the boundary, prove the shape, then use it.
Use a predicate or a direct check that the compiler understands.
Keep the guard next to the use so the proof and the payoff stay together.

```ts
type ApiUser = {
  id: string
  name: string
}

function isApiUser(value: unknown): value is ApiUser {
  if (typeof value !== "object" || value === null) {
    return false
  }
  const candidate = value as Record<string, unknown>
  return typeof candidate.id === "string" && typeof candidate.name === "string"
}

async function loadUser(response: Response): Promise<ApiUser> {
  const payload: unknown = await response.json()
  if (!isApiUser(payload)) {
    throw new Error("Unexpected user shape")
  }
  return payload
}
```

## Banned Shapes

Response bodies typed as any with direct property access.
Generic helpers with three type parameters to avoid writing two concrete types.
Utility-type towers that hide a simple object.
Assertions that silence the compiler without proving anything.
