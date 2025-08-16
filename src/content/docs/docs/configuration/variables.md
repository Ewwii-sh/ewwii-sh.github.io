---
title: Variables
description: Covering the fundamentals of variables in ewwii's rhai.
sidebar:
  order: 3
---

Now that you feel sufficiently greeted by your bar, you may realize that showing data like the time and date might be even more useful than having a button that greets you.

To implement dynamic content in your widgets, you make use of _variables_.

All variables are only locally available so you would need to pass it around using function parameters. And whenever the variable changes, the value in the widget will update!

## Static variables

In Rhai, all variables are dynamically typed bindings to values. You can define variables using let, pass them as function parameters.

**Basic variables (`let`)**

```rust
// vars.rhai
let foo = "value";
```

This is the simplest type of variable.
Basic variables don't ever change automatically, if you need a dynamic variable, you can use built in functions like `poll()` and `listen()` to register dynamic values which we will talk about in the following section.

## Dynamic variables

Just having static variables that wont update is pretty limiting. So, ewwii has two built in functions to register dynamic variables that can change according to the command.

**Polling variables (`poll`)**

```rust
// vars.rhai
enter([
  poll("var_name", #{
    // It is recommended to have initial property passed.
    // If not provided, it will default to no value
    // which may cause problems when used.
    //
    // You can pass something like "" if you want no initial value.
    initial: "inital value",
    interval: "2s",
    cmd: "date +%H:%M:%S", // command to execute
  })
])
```

A polling variable is a variable which runs a provided shell-script repeatedly, in a given interval.

This may be the most commonly used type of variable.
They are useful to access any quickly retrieved value repeatedly,
and thus are the perfect choice for showing your time, date, as well as other bits of information such as pending package updates, weather, and battery level.
But it is important to note that these variables are locally available only in enter (a.k.a the root) and you need to pass it to other functions with something like `some_fn(foo)` when you want to use a polled variable.

<!-- You can also specify an initial-value. This should prevent ewwii from waiting for the result of a given command during startup, thus
making the startup time faster. -->

To externally update a polling variable, `ewwii update` can be used like with basic variables to assign a value.

**Listening variables (`listen`)**

```rust
// vars.rhai
enter([
  listen("foo", #{
    initial: "whatever",
    cmd: "tail -F /tmp/some_file",
  })
])
```

Listening variables might be the most confusing of the bunch.
A listening variable runs a script once, and reads its output continously.
Whenever the script outputs a new line, the value will be updated to that new line.
In the example given above, the value of `foo` will start out as `"whatever"`, and will change whenever a new line is appended to `/tmp/some_file`.

These are particularly useful when you want to apply changes instantaneously when an operation happens if you have a script
that can monitor some value on its own. Volume, brightness, workspaces that get added/removed at runtime,
monitoring currently focused desktop/tag, etc. are the most common usecases of this type of variable.
These are particularly efficient and should be preffered if possible.

For example, the command `xprop -spy -root _NET_CURRENT_DESKTOP` writes the currently focused desktop whenever it changes.
Another example usecase is monitoring the currently playing song with playerctl: `playerctl --follow metadata --format {{title}}`.

<!--
**Built-in "magic" variables**

In addition to defining your own variables, ewwii provides some values for you to use out of the box.
These include values such as your CPU and RAM usage.
These mostly contain their data as JSON, which you can then get using the [json access syntax](expression_language.md).
All available magic variables are listed [here](magic-vars.md). -->

## Passing variables

As we discussed earlier, all variables are only available locally. So, you would need to pass it around from the current scope.

Here is an example of how it is done:

```rust
// var.rhai
let foo = "example";

enter([
  poll("time", #{
    initial: "inital value",
    interval: "2s",
    cmd: "date +%H:%M:%S",
  })

  defwindow("will_work_win", #{
    // ...
  }, will_work(time, foo))

  defwindow("wont_work_win", #{
    // ...
  }, wont_work())
]);

// Here we have 2 variables.
// One named "time" (registered dynamically by poll)
// and the other named "foo" (a static variable)

// here is an example of something that wont
fn wont_work() {
  return box(#{}, [ label(#{ text: time }), label(#{ text: foo }) ]);
}

// here is an example of something that will work
fn will_work(time, foo) {
  return box(#{}, [ label(#{ text: time }), label(#{ text: foo }) ]);
}
```

The `wont_work` function will not work because it doesn't know what time or foo is. But, `will_work` will work as it knows wat time and foo is as both of them are passed to `will_work` by the `will_work_win`.

## dyn_id

`dyn_id`'s are one of the most important properties of all. It is the property that decides if a widget should get updated dynamic or not.

`dyn_id` property is used to assign an id to a widget which the system will track to update if there is a change in property under the same id.

**Example usage:**

```rust
// dynid_example.rhai
fn foo(foo_var) {
  return box(#{}, [
    // dyn_id used to make label dynamic
    label(#{ text: foo_var, dyn_id: "foo_var_user" });
  ]);
}

enter([
  defpoll("foo", #{
    cmd: "echo baz",
    initial: "",
    interval: "1s"
  }),
  defwindow("bar", #{
    // .. properties omitted
  }, bar(foo)),
])
```

Here, when the variable foo changes, the text of label changes as well. If there is no `dyn_id` defined, then ewwii will ingore that change. But if it is defined with a unique value, then it will find the widget that is defined with the id that matches dyn_id and then update its text property which will result in a change in the UI.
