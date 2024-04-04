# Chapter 03

## &self

The `&self` is actually short for 'self: &Self'

## [Shadowing]

- Shadowing is different from marking a variable as `mut` because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the `let` keyword.

- The other difference between `mut` and shadowing is that because we’re effectively creating a new variable when we use the `let` keyword again, "we can change the type of the value but reuse the same name"

<!-- links -->
[Shadowing]: https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html#shadowing
