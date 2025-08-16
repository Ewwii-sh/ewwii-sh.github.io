---
title: Overview
description: Talking about ewwii's package manager
sidebar:
  order: 0
---

Ewwii has its own package manager named **eiipm** built to be fast and reliant to manage packages that are built for ewwii.

In this section, we'll cover:

- The use of eiipm
- Types of packages that eiipm support
- Command line arguments of eiipm

### Command overview

Here is a simple overview of all commands before we get started.

| Command               | Aliases | Flags / Options                    |
| --------------------- | ------- | ---------------------------------- |
| `install <PACKAGE>`   | `i`     | `--debug`                          |
| `uninstall <PACKAGE>` | `rm`    | `--debug`                          |
| `update [PACKAGE]`    | `up`    | `--debug`                          |
| `list`                | `l`     | `-v`, `-t`, `-q <NAME>`, `--debug` |
| `help`                | None    | None                               |
| `-V, --version`       | None    | None                               |

**Flags for `list`:**

- `-v, --verbose`: verbose output
- `-t, --total-count`: output just total package count
- `-q, --query <NAME>`: query a package (works with `--verbose`)
- `--debug`: debug logs

### Reference

For a more dense documentation, checkout the [full eiipm documentation](https://ewwii-sh.github.io/eiipm/).
