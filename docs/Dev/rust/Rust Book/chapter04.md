# Chapter 04

## [The Stack and the Heap][heap-stack]

Many programming languages don’t require you to think about the stack and the heap very often. But in a systems programming language like Rust, whether a value is on the stack or the heap affects how the language behaves and why you have to make certain decisions.

## [What Is Ownership?][rustownership]

[Ownership] is a set of rules that govern how a Rust program manages memory.

### [Ownership Rules][ownershiprules]

- Each value in Rust has an owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the value will be dropped.

### [Ownership in Function][functionownership]

### [Return Values and Scope][fownerreturnv]

Returning values can also transfer ownership

## [Variable Scope][variablescope]

## [Memory and Allocation][memory-allocation]

- The memory must be requested from the memory allocator at runtime.
- We need a way of returning this memory to the allocator when we’re done.

### [Drop in Rust & RAII in C++][memory-allocation]

> Note: In C++, this pattern of deallocating resources at the end of an item’s
> lifetime is sometimes called *Resource Acquisition Is Initialization (RAII)*.
> The `drop` function in Rust will be familiar to you if you’ve used RAII
> patterns.

### [Move]

> Shallow Copy

### [Clone]

> Deep Copy

## [References and Borrowing][references-and-borrowing]

>Note: The opposite of referencing by using `&` is *dereferencing*, which is accomplished with the dereference operator, `*`.

### [Dangling References][dangling-references]

### [The Rules of References][the-rules-of-references]

### [Mutable References][mutableref]

```rust
    let mut s = String::from("hello");

    let r1 = &mut s;
    let r2 = &mut s;

    println!("{}, {}", r1, r2);
```

Mutable references: have one big restriction, if you have a mutable reference to a value, you can have no other references to that value.

<!-- links -->
[rustownership]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#what-is-ownership
[heap-stack]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#the-stack-and-the-heap
[ownershiprules]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#ownership-rules
[variablescope]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#variable-scope
[memory-allocation]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#memory-and-allocation
[move]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#variables-and-data-interacting-with-move
[clone]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#variables-and-data-interacting-with-clone
[functionownership]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#ownership-and-functions
[fownerreturnv]: https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html#return-values-and-scope
[references-and-borrowing]: https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html#references-and-borrowing
[dangling-references]: https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html#dangling-references
[the-rules-of-references]: https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html#the-rules-of-references
[mutableref]: https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html#mutable-references
[Ownership]: https://arxiv.org/pdf/2011.09012.pdf