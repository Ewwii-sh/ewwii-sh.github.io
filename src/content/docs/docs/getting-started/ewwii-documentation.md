---
title: Ewwii Documentation
description: Link to ewwii documentation.
sidebar:
  order: 1
---

## Reading Ewwii Documentation

To get your first widget running, start with the [Ewwii documentation](https://ewwii-sh.github.io/ewwii).

It explains how to use Ewwii's configuration language **Rhai**, run commands, and troubleshoot common issues. You’ll also find example widget configurations you can adapt for your own setup.

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

- [Ewwii documentation](https://ewwii-sh.github.io/ewwii)
