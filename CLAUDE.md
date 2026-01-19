# Repository Guidelines

## Policy
- WARNING: Never run `sudo` unless the user explicitly requests it; even then, always ask for confirmation before running any `sudo` command.

### use of Emoticons
**IMPORTANT:** Avoid emoji in docs/logs/source everywhere; use plain Unicode symbols.
Recommended Unicode symbols:
- ✓ check
- ✗ cross
- • bullet
- ‣ bullet (alt)
- ◦ bullet (alt)
- → arrow right
- ← arrow left
- ↑ arrow up
- ↓ arrow down
- ↳ return/branch
- ⇢ arrow right (alt)
- ⇒ implies
- ⇐ implies (rev)
- ⇔ iff
- ↔ bidirectional
- ⟶ long arrow
- ⟵ long arrow (rev)
- ⟷ long bidirectional
- ∎ end marker
- □ empty square
- ■ filled square
- ◆ filled diamond
- ◇ empty diamond
- ○ empty circle
- ● filled circle
- ▸ triangle right
- ▾ triangle down
- ▲ triangle up
- ▼ triangle down (alt)
- ⌁ wave
- ⋯ ellipsis (midline)
- ≈ approximately
- ≠ not equal
- ≤ less-than-or-equal
- ≥ greater-than-or-equal
- ± plus/minus
- ∞ infinity
- ∅ empty set
- ∈ member of
- ∉ not member of
- ⊂ subset
- ⊃ superset
- ¬ logical not

Expressive symbols:
- ✦ star
- ✧ star (outline)
- ✶ star (alt)
- ✷ star (alt)
- ✸ star (alt)
- ✹ star (alt)
- ✺ star (alt)
- ✻ star (alt)
- ✼ star (alt)
- ✽ star (alt)
- ✾ star (alt)
- ✿ floral
- ❀ floral (alt)
- ❁ floral (alt)
- ❂ sun
- ❃ floral (alt)
- ❄ snowflake
- ❅ snowflake (alt)
- ❆ snowflake (alt)
- ❇ sparkle
- ❈ sparkle (alt)
- ❉ sparkle (alt)
- ❊ sparkle (alt)
- ❋ sparkle (alt)
- ❖ ornamental diamond
- ✱ asterisk star
- ✲ asterisk star (alt)
- ✳ asterisk star (alt)
- ❘ light vertical
- ❘̸ barred vertical
- ❙ heavy vertical
- ❚ heavy vertical (alt)
- ❛ single quote (ornate)
- ❜ single quote (ornate)
- ❝ double quote (ornate)
- ❞ double quote (ornate)
- ❦ floral heart
- ❧ rotated floral heart
- ❥ heart (ornate)
- ❍ ring
- ⊕ circled plus
- ⊗ circled times
- ⊙ circled dot
- ⊚ circled dot (alt)
- ⊛ circled star
- ⊜ circled equal
- ♠ spade (ace)
- ♥ heart (ace)
- ♦ diamond (ace)
- ♣ club (ace)
- ✦ future...

## Project Overview

NeonSignal book

## Dependencies

- Docs: Python 3, Sphinx, myst-parser, sphinx-copybutton, sphinx-design, themes: [neon-synth, neon-wave].

## Build Commands

### Sphinx Documentation
```bash

```

## Build Workflow (IMPORTANT)

**ALWAYS ask before building to save tokens.** Build processes consume significant tokens and should only be run when explicitly requested by the user or when absolutely necessary.

- ✗ Don't automatically run `make html`, or other build commands after making changes
- ✓ Do make code changes and wait for user to request build
- ✓ Do ask "Should I build this?" when uncertain
- Exception: Only build without asking if the user explicitly requests it (e.g., "build and test this")

## Architecture

### Directory Structure
```

```

### Build Pipelines

**Sphinx Docs**: `source/` → `build/book/` → `../neonsignal/public/_default/book/`

## Code Style

### .rst .md
follow general rules

## Key Configuration

- reusable bash lib and palette: `scripts/lib/logging.sh`
- Global paths: `scripts/global_variables.sh`

## Commit Guidelines

- Always wait to commit until explicitly requested.
- Use concise, descriptive commits with conventional prefixes: `feat:`, `fix:`, `chore:`.
- Follow the subject with a blank line and a short body explaining what/why.
- Keep commits scoped; avoid committing build artifacts unless required.
- Use detailed descriptions for every commit.
- Group logically related files in the same commit.
- PRs should summarize changes, mention affected modules, list verification steps, and include screenshots/GIFs for UI updates.

## Licenses for book and themes

Apache License 2.0. See `LICENSE`.

## Testing

No formal test suite.
