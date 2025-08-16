---
title: Ewwii Documentation
description: Link to ewwii documentation.
sidebar:
  order: 1
---

## Reading Ewwii Documentation

To get your first widget running, start with the [Ewwii documentation overview](https://ewwii-sh.github.io/docs/configuration/configuration).

This simple overview is extracted from the [full ewwii documentation](https://ewwii-sh.github.io/ewwii) and explains how you can use ewwii's configuration language **Rhai**.

Once you are done with the overview, you can move to the [full ewwii documentation](https://ewwii-sh.github.io/ewwii).

Other than what you have learnt in the overview, the full documentation explains how to use built-in widgets, what each widget parameters expect, run ewwii commands, and troubleshoot common issues. You’ll also find example widget configurations you can adapt for your own setup.

### Minimal Example

Here’s a simple configuration that creates a window containing a label:

```rust
// ewwii.rhai
fn foo() {
    return box(#{
        class: "widget1",
        orientation: "h",
        space_evenly: true,
        hexpand: true,
        spacing: 5
    }, [
        label(#{ text: "Hello Ewwii!" })
    ]);
};

enter([
    defwindow("bar", #{
        monitor: 0,
        windowtype: "dock",
        geometry: #{ x: "0px", y: "0px", width: "10px", height: "20px" },
    }, foo()),
]);
```

Try changing the label text to see how it updates in your widget.

### Reference

- [Ewwii documentation overview](https://ewwii-sh.github.io/docs/configuration/)
- [Full Ewwii documentation](https://ewwii-sh.github.io/ewwii)
