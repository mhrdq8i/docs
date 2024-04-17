# Chapter 03

## &self

The `&self` is actually short for 'self: &Self'

## [Shadowing]

- Shadowing is different from marking a variable as `mut` because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the `let` keyword.

- The other difference between `mut` and shadowing is that because we’re effectively creating a new variable when we use the `let` keyword again, "we can change the type of the value but reuse the same name"

## Array

Auto fill array

```rust
let a: [i32; 5] = [1, 2, 3, 4, 5];

let a = [3; 5]; <===> let a = [3, 3, 3, 3, 3];
```

**Iterators:** iterators produce a series of values, and we can call the collect method on an iterator to turn it into a collection.

<!-- links -->
[Shadowing]: https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html#shadowing
