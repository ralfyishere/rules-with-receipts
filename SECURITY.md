# Security

## Rules files are untrusted code

A rules pack is instructions an agent will follow with tool access. Loading one
is running it. That applies to THIS pack too:

- Read what you install, or screen it first: `azt scan /path/to/rules-with-receipts`
  ([agent-zero-trust](https://github.com/ralfyishere/agent-zero-trust) — whole
  instruction environment) or `rulebench vet` for individual rules files.
  Both offline, no model calls, and both publish their own blind spots.
- The curl-pipe-bash install exists for convenience; the clone-read-install path
  is the one we'd use ourselves.
- Run unfamiliar rules on a machine you don't mind rebuilding, never with
  credentials you can't rotate.

## What this pack does at install time

Everything the installer touches is listed in [PACK-MANIFEST.md](PACK-MANIFEST.md)
with ownership and upgrade behavior. It writes only into the target project
(plus `git config core.hooksPath` in that project), backs up before overwriting,
and adds no network calls to your workflow. The hygiene gate BLOCKS outbound
actions (push/release/publish) — it never initiates them.

## Reporting a vulnerability

Open a GitHub issue for anything non-sensitive. For sensitive reports (e.g., a
way to make the gates pass when they shouldn't, an injection vector in a shipped
skill), use GitHub's private vulnerability reporting on this repo. Expect a
response within a week — this is a maintained project, not abandonware.

## Known, deliberate properties

- The hygiene gate matches command *text* and over-blocks (quoted "git push" in
  prose trips it). Over-blocking is the chosen failure direction for a safety gate.
- A clean `rulebench vet` or security scan means "no known-shape red flags,"
  not "safe." Pattern matching cannot catch cleverly worded natural-language
  social engineering.
