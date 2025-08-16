---
title: Writing your ewwii configuration
description: An introduction to writing your own ewwii configuration.
sidebar:
  order: 0
---

> For a list of all built-in widgets (i.e. `box`, `label`, `button`), see [Widget Documentation](/ewwii/widgets/widgets.html).

Ewwii is configured using its own language called `rhai`.
Using rhai, you declare the structure and content of your widgets, the geometry, position, and behavior of any windows,
as well as any state and data that will be used in your widgets.
Rhai is based around imparative syntax, which you may know from programming languages like C, Rust etc.
If you're using vim, you can make use of [vim-rhai](https://github.com/rhaiscript/vim-rhai) for editor support.
If you're using VSCode, you can get syntax highlighting and formatting from [vscode-rhai](https://marketplace.visualstudio.com/items?itemName=rhaiscript.vscode-rhai).

Additionally, any styles are defined in CSS or SCSS (which is mostly just slightly improved CSS syntax).
While ewwii supports a significant portion of the CSS you know from the web,
not everything is supported, as ewwii relies on GTK's own CSS engine.
Notably, some animation features are unsupported,
as well as most layout-related CSS properties such as flexbox, `float`, absolute position or `width`/`height`.

To get started, you'll need to create two files: `ewwii.rhai` and `ewwii.scss` (or `ewwii.css`, if you prefer).
These files must be placed under `$XDG_CONFIG_HOME/ewwii` (this is most likely `~/.config/ewwii`).

Now that those files are created, you can start writing your first widget!

## Creating your first window

Firstly, you will need to create a top-level window. Here, you configure things such as the name, position, geometry, and content of your window.

Let's look at an example window definition:

```rust
// ewwii.rhai
enter([ // Add all defwindow inside enter. Enter is the root of the config.
  defwindow("example", #{
      monitor: 0,
      windowtype: "dock",
      stacking: "fg",
      wm_ignore: false,
      geometry: #{
        x: "0%",
        y: "2px",
        width: "90%",
        height: "30px",
        anchor: "top center"
      },
      reserve: #{ distance: "40px" side: "top" }
  }, label(#{ text: "example content" }))
])
```

Here, we are defining a window named `example`, which we then define a set of properties for. Additionally, we set the content of the window to be the text `"example content"`.

You can now open your first window by running `ewwii open example`! Glorious!

### `defwindow`-properties

| Property   | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `monitor`  | Which monitor this window should be displayed on. See below. |
| `geometry` | Geometry of the window.                                      |

**`monitor`-property**

This field can be:

- the string `<primary>`, in which case ewwii tries to identify the primary display (which may fail, especially on wayland)
- an integer, declaring the monitor index
- the name of the monitor
- a string containing a JSON-array of monitor matchers, such as: `'["<primary>", "HDMI-A-1", "PHL 345B1C", 0]'`. Ewwii will try to find a match in order, allowing you to specify fallbacks.

**`geometry`-properties**

|          Property | Description                                                                                                             |
| ----------------: | ----------------------------------------------------------------------------------------------------------------------- |
|          `x`, `y` | Position of the window. Values may be provided in `px` or `%`. Will be relative to `anchor`.                            |
| `width`, `height` | Width and height of the window. Values may be provided in `px` or `%`.                                                  |
|          `anchor` | Anchor-point of the window. Either `center` or combinations of `top`, `center`, `bottom` and `left`, `center`, `right`. |

<br/>
Depending on if you are using X11 or Wayland, some additional properties exist:

#### X11

| Property     | Description                                                                                                   |
| ------------ | ------------------------------------------------------------------------------------------------------------- |
| `stacking`   | Window stack position: `fg` or `bg`.                                                                          |
| `wm_ignore`  | Ignore by WM: `true`/`false`.                                                                                 |
| `reserve`    | Reserve space for bars/widgets.                                                                               |
| `windowtype` | Type: `normal`, `dock`, `toolbar`, `dialog`, `desktop`. <br> Default: `dock` if `reserve` set, else `normal`. |

#### Wayland

| Property    | Description                                                         |
| ----------- | ------------------------------------------------------------------- |
| `stacking`  | Stack position: `fg`, `bg`, `overlay`, `bottom`.                    |
| `exclusive` | Reserve space: `true`/`false`. Requires `:anchor=center` if `true`. |
| `focusable` | Focus mode: `none`, `exclusive`, `ondemand`.                        |
| `namespace` | Layersurface namespace (string).                                    |

## Your first widget

While our bar is already looking great, it's a bit boring. Thus, let's add some actual content!

```rust
// ewwii.rhai
fn greeter(name) {
  return box(#{
    orientation: "horizontal",
    halign: "center"
  }, [
    button(#{ onclick: `notify-send 'Hello' 'Hello, ${name}'`, label: "Greet" })
  ]);
};
```

To show this, let's replace the text in our window definition with a call to this new widget:

```rust
// ewwii.rhai
enter([
  defwindow("example", #{
    // ... properties omitted
  }, greeter("Bob"))
])
```

There is a lot going on here, so let's step through this.

We are creating a function named `greeter` and a function is equal to a component that returns a child (widget). So function has two uses: one to return a component, and the other to do a set of functions.
And this function takes one parameters, called `name`. The `name` parameter _must_ be provided or else, you should emit it. Rhai does allow adding optional parameters, but we will talk about it later for the sake of beginners who are in-experienced with imprative programming languages.

Now inside the function, we declare the body of our widget that we are returning. We make use of a `box`, which we set a couple properties of.

We need this `box`, as a function can only ever contain a single widget - otherwise,
ewwii would not know if it should align them vertically or horizontally, how it should space them, and so on.
Thus, we wrap multiple children in a `box`.
This box then contains a button.
In that button's `onclick` property, we refer to the provided `name` using string-interpolation syntax: `` `${name}` ``. It is not possible to use a variable within a `""` or `''` just like javascript. You can learn more about it [here](https://rhai.rs/book/ref/strings-chars.html?interpolation#string-interpolation).

<!-- TODO -->
<!-- In fact, there is a lot more you can do within `${...}` - more on that in the chapter about the [expression language](expression_language.md). -->

To then use our widget, we call the function that provides the widget with the necessary parameters passed.

As you may have noticed, we are using a couple predefined widgets here. These are all listed and explained in the [widgets chapter](/ewwii/widgets/widgets.html).

## CLI

Even though we have written our configuration, we want to see it in action. So, we use ewwii commands to get it to load a configuration.

The first command that we will discuss of is the `ewwii open <WINDOW_NAME>` command. You might be familiar with it as you have used it to render your window. But, let's learn more about what ewwii does when you tell it to open a window.

```bash
ewwii open example
```

When this command is ran, ewwii will go into `~/.config/ewwii/` and checks for 3 files.

The files it looks for are:

- ewwii.rhai
- ewwii.scss
- ewwii.css

When it finds the `ewwii.rhai` file in `~/.config/ewwii/`, ewwii loads it and renders the using the configuration window.

Then it looks for the other two files. First, it looks for the `ewwii.scss` file. If not found, it will look for the `ewwii.css` file.

Even though ewwii looks for both `ewwii.scss` and `ewwii.css`, only one of them should be present in `~/.config/ewwii/`. If both are present, then ewwii will throw an error.

> <p style="color: cyan; font-weight: bold;">NOTE</p>
>
> If you have something like `custom_name.rhai` file instead of `ewwii.rhai` file, then ewwii **will not** find it.
>
> However, if you intent to split up your configuration, then you can check [this out](/docs/configuration/rendering_and_best_practices/#splitting-up-your-configuration) for more info.
