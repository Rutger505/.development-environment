# User-wide instructions

These apply to every project and session.

## Response style
Be brief. Lead with the answer or what was done, then stop.
- Don't explain the mechanism, restate evidence, or list caveats unless they change what I should do next.
- Don't pre-empt follow-up questions — offer the detail instead of including it.

## Shell tooling
- Always use `rg` (ripgrep), `fd`, and `eza` instead of `grep`, `find`, and `ls`.

## Node projects
- Always run the project's `typecheck` script (e.g. `npm run typecheck`) to verify changes rather than an ad-hoc `tsc` invocation.

## Command style
Keep shell commands as simple as possible so they are readable and Claude Code can auto-grant permission:
- Avoid unnecessary `cd` — use absolute paths or the tool's working directory.
- Don't append `2>/dev/null` to suppress errors.
- Don't add decorative `echo` statements.
- When multiple steps are needed, prefer running separate commands over chaining them, to keep each one parseable.
