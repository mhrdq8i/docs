# Chapter 07

## Rust Packaging System

- *Packages:* A Cargo feature that lets you build, test, and share crates
- *Crates:* A tree of modules that produces a library or executable
- *Modules and use:* Let you control the organization, scope, and privacy of paths
- *Paths:* A way of naming an item, such as a struct, function, or module

```bash
Workspace
   └─ Packages
         └─ Crates
              └─ Modules
                    └─ Files
```

Rust lets you split a *package* into *multiple crates* and a crate into modules.

A package can contain as many binary crates as you like, but at most *only one library crate*. A package must contain at least *one crate*, whether that’s a library or binary crate.

```bash
+-----------------------------------------+
|                my_project               |
|                                         |
| +-----------------+ +-------------+     |
| |  Cargo.toml     | |  src/       |     |
| +-----------------+ +-------------+     |
| | +-------------+ | +---------+   |     |
| | | main.rs     | | | module1 |   |     |
| | +-------------+ | +---------+   |     |
| | | lib.rs      | | | module2 |   |     |
| | +-------------+ | |         |   |     |
| | |             | | | +-----+ |   |     |
| | | +---------+ | | | |subm1| |   |     |
| | | | crate1  | | | | +-----+ |   |     |
| | | +---------+ | | | +-----+ |   |     |
| | |             | | | |subm2| |   |     |
| | | +---------+ | | | +-----+ |   |     |
| | | | crate2  | | | +---------+   |     |
| | | +---------+ | +---------------+     |
| | +-------------+                       |
| +---------------------------------------+
+-----------------------------------------+
```

- The outermost square represents the package my_project.

- Inside the package, there are squares representing the Cargo.toml file and the src directory.

- Inside the src directory, there are squares representing the main.rs (binary crate) and lib.rs (library crate) files.

- Inside the src directory, there is a square representing the module1 module.

- Inside the src directory, there is a square representing the module2 module.

- Inside the module2 module square, there are squares representing the submodule1 and submodule2 submodules.

- Inside the submodule1 submodule square, there are squares representing crate1 and crate2 crates.

This representation visually shows a more complex hierarchy with multiple crates, modules, and submodules nested within each other.

### Paths for Referring to an Item in the Module Tree

"Items in a parent module can’t use the private items inside child modules, but items in child modules can use the items in their ancestor modules". This is because child modules wrap and hide their implementation details, but the child modules can see the context in which they’re defined.

### Separation of Concerns for Binary Projects

Rust official book about [*Separation of Concerns*][sofc]

## [Re-exporting Names with pub use][reexporting]

When we bring a name into scope with the use keyword, the name available in the new scope is private. To enable the code that calls our code to refer to that name as if it had been defined in that code’s scope, we can combine pub and use

This technique is called `re-exporting` because we’re bringing an item into scope but also making that item available for others to bring into their scope

## Private vs Public

Code within a module is private from its parent modules by default. To make a module public, declare it with pub mod instead of mod. To make items within a public module public as well, use pub before their declarations

## [Packages and Crates][pnc]

### Binary crate

Binary crates are programs you can compile to an executable that you can run

### Library crate

Library crates don’t have a `main` function, and they don’t compile to an executable. Instead, they define functionality intended to be shared with multiple projects.

A package can contain `src/main.rs` and `src/lib.rs`. In this case, it has two crates: a *binary* and a *library*, both with the same name as the package.

<!-- links -->
[reexporting]: https://doc.rust-lang.org/book/ch07-04-bringing-paths-into-scope-with-the-use-keyword.html#re-exporting-names-with-pub-use
[pnc]: https://doc.rust-lang.org/stable/book/ch07-01-packages-and-crates.html#packages-and-crates
