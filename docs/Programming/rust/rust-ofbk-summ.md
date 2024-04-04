# Rust Official Doc Summarize

## Chapter 03

### &self

The `&self` is actually short for 'self: &Self'

### [Shadowing]

- Shadowing is different from marking a variable as `mut` because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the `let` keyword.

- The other difference between `mut` and shadowing is that because we’re effectively creating a new variable when we use the `let` keyword again, "we can change the type of the value but reuse the same name"

## Chapter 07

Rust module system

- _Packages:_ A Cargo feature that lets you build, test, and share crates
- _Crates:_ A tree of modules that produces a library or executable
- _Modules and use:_ Let you control the organization, scope, and privacy of paths
- _Paths:_ A way of naming an item, such as a struct, function, or module

### Paths for Referring to an Item in the Module Tree

"Items in a parent module can’t use the private items inside child modules, but items in child modules can use the items in their ancestor modules". This is because child modules wrap and hide their implementation details, but the child modules can see the context in which they’re defined.

### [Re-exporting Names with pub use][reexporting]

When we bring a name into scope with the use keyword, the name available in the new scope is private. To enable the code that calls our code to refer to that name as if it had been defined in that code’s scope, we can combine pub and use

This technique is called `re-exporting` because we’re bringing an item into scope but also making that item available for others to bring into their scope

### Private vs Public

Code within a module is private from its parent modules by default. To make a module public, declare it with pub mod instead of mod. To make items within a public module public as well, use pub before their declarations

<!-- links -->
[Shadowing]: https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html#shadowing
[reexporting]: https://doc.rust-lang.org/book/ch07-04-bringing-paths-into-scope-with-the-use-keyword.html#re-exporting-names-with-pub-use
