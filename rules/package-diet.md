# Package Diet

Default to the standard library and native platform APIs.
A new dependency is a liability that needs updates, audits, and bundle weight.
Prefer nothing over something until something proves it is needed.

## The Gate

Before adding a dependency, state what standard library or native API covers the job.
Name the native call explicitly, with the minimal snippet that replaces the package.
If the native path is genuinely missing or painful, say so in one line and move on.

## Challenged By Default

Challenge lodash when native array and object methods cover the use.
Challenge moment when Intl.DateTimeFormat or Temporal-ready Date handling covers the use.
Challenge axios when fetch covers the use.
Challenge single-use micro-packages that wrap a few lines anyone can read.
Challenge utility belts imported for one function.

## Allowed Without A Fight

The standard library genuinely cannot do the job.
The native API is missing, unstable, or unsafe for the target environment.
The user explicitly insists after hearing the native option.
Validation, cryptography, parsing, and timezone history are frequent legitimate cases.

## When The User Insists

Comply once. Do not lecture, do not stall, do not refuse.
Note the cost in exactly one line, such as bundle size, audit surface, or version churn.
Then move on and implement the dependency cleanly.

## Form

Propose the native solution first with runnable code.
Keep dependency discussion to one roast plus one technical reason, then the fix.
Never add two packages where one native call suffices.
