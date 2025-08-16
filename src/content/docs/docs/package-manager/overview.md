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

### Adding eiipm to path

I am very sorry for adding this section in this unrelated part but **this is a very important thing** which **people are likely to miss**. By default, eiipm installs binaries to `~/.eiipm/bin` directory. But your shell doesn't know about it yet.

So, when you run something like `bin-you-installed` after installing a binary from eiipm, your shell will go like "Oh, let me check in all the known areas. Nope, `bin-you-installed` is not installed..."

So, you should add `export PATH="$HOME/.eiipm/bin:$PATH"` to your shell's configuration file.

**Here is an example on how to do it:**

```bash
# Replace ~/.zshrc with your shell's configuration file.
# For example, if you use bash, then it would be ~/.bashrc
echo 'export PATH="$HOME/.eiipm/bin:$PATH"' >> ~/.zshrc
```

I use zsh, so I added the line `export PATH="$HOME/.eiipm/bin:$PATH"` in `~/.zshrc` but if you use something else, you should replace the `~/.zshrc` with your own shell's confiuration file.

For example, if you use bash, add that line in `~/.bashrc`.

> **NOTE:** If you dont want to use echo to add it, then you can manually edit your configuration file and add the line `export PATH="$HOME/.eiipm/bin:$PATH"` in there.

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
