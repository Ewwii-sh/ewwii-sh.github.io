---
title: Supported commands
description: All supported commands in eiipm
sidebar:
  order: 1
---

## Installing

```bash
eiipm install <PACKAGE> # or eiipm i <PACKAGE>
```

Downloads, builds if needed, and installs a package.

**Options:**
`--debug` Show debug logs.

**Examples:**

```bash
eiipm install staticscript
eiipm i ewwii
```

## Uninstalling

```bash
eiipm uninstall <PACKAGE> # or eiipm rm <PACKAGE>
```

Removes a package and its tracked files.

**Options:**
`--debug` Show debug logs.

**Examples:**

```bash
eiipm rm staticscript
```

## Updating

```bash
eiipm update [PACKAGE] # or eiipm up [PACKAGE]
```

Updates a specific package or all installed packages if none specified.

**Options:**
`--debug` Show debug logs.

**Examples:**

```bash
eiipm up # update all
eiipm up staticscript # update one
```

## Listing

```bash
eiipm list [OPTIONS] # or eiipm l [OPTIONS]
```

Shows installed packages. Can filter by name, show detailed info, or count.

**Options:**

- `-v`, `--verbose` Detailed info
- `-t`, `--total-count` Show total number
- `-q <NAME>`, `--query <NAME>` Info for a single package
- `--debug` Show debug logs

**Examples:**

```bash
eiipm l
eiipm l -v
eiipm l -t
eiipm l -q staticscript
eiipm l -q staticscript -v
```
