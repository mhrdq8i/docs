# Rust Official Doc Summarize

## Chapter 03

### &self

The `&self` is actually short for 'self: &Self'

### [Shadowing]

- Shadowing is different from marking a variable as `mut` because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the `let` keyword.

- The other difference between `mut` and shadowing is that because we’re effectively creating a new variable when we use the `let` keyword again, "we can change the type of the value but reuse the same name"

## Chapter 04

### [The Stack and the Heap][heap-stack]

Many programming languages don’t require you to think about the stack and the heap very often. But in a systems programming language like Rust, whether a value is on the stack or the heap affects how the language behaves and why you have to make certain decisions.

### [What Is Ownership?][rustownership]

Ownership is a set of rules that govern how a Rust program manages memory.

#### [Ownership Rules][ownershiprules]

- Each value in Rust has an owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the value will be dropped.

#### [Ownership in Function][functionownership]

#### [Return Values and Scope][fownerreturnv]

Returning values can also transfer ownership

### [Variable Scope][variablescope]

### [Memory and Allocation][memory-allocation]

- The memory must be requested from the memory allocator at runtime.
- We need a way of returning this memory to the allocator when we’re done.

#### [Drop in Rust & RAII in C++][memory-allocation]

> Note: In C++, this pattern of deallocating resources at the end of an item’s
> lifetime is sometimes called *Resource Acquisition Is Initialization (RAII)*.
> The `drop` function in Rust will be familiar to you if you’ve used RAII
> patterns.

#### [Move]

> Shallow Copy

#### [Clone]

> Deep Copy

## Chapter 07

Rust module system

- *Packages:* A Cargo feature that lets you build, test, and share crates
- *Crates:* A tree of modules that produces a library or executable
- *Modules and use:* Let you control the organization, scope, and privacy of paths
- *Paths:* A way of naming an item, such as a struct, function, or module

### Paths for Referring to an Item in the Module Tree

"Items in a parent module can’t use the private items inside child modules, but items in child modules can use the items in their ancestor modules". This is because child modules wrap and hide their implementation details, but the child modules can see the context in which they’re defined.

### [Re-exporting Names with pub use][reexporting]

When we bring a name into scope with the use keyword, the name available in the new scope is private. To enable the code that calls our code to refer to that name as if it had been defined in that code’s scope, we can combine pub and use

This technique is called `re-exporting` because we’re bringing an item into scope but also making that item available for others to bring into their scope

### Private vs Public

Code within a module is private from its parent modules by default. To make a module public, declare it with pub mod instead of mod. To make items within a public module public as well, use pub before their declarations

### [Packages and Crates][pnc]

#### Binary crate

Binary crates are programs you can compile to an executable that you can run

#### Library crate

Library crates don’t have a `main` function, and they don’t compile to an executable. Instead, they define functionality intended to be shared with multiple projects.

A package can contain `src/main.rs` and `src/lib.rs`. In this case, it has two crates: a *binary* and a *library*, both with the same name as the package.

<!-- links -->
[Shadowing]: https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html#shadowing
[reexporting]: https://doc.rust-lang.org/book/ch07-04-bringing-paths-into-scope-with-the-use-keyword.html#re-exporting-names-with-pub-use
[pnc]: https://doc.rust-lang.org/stable/book/ch07-01-packages-and-crates.html#packages-and-crates
[rustownership]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#what-is-ownership
[heap-stack]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#the-stack-and-the-heap
[ownershiprules]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#ownership-rules
[variablescope]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#variable-scope
[memory-allocation]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#memory-and-allocation
[move]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#variables-and-data-interacting-with-move
[clone]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#variables-and-data-interacting-with-clone
[functionownership]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#ownership-and-functions
[fownerreturnv]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#return-values-and-scope
