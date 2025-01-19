# DataTypes & Keywords

## [Data Types][DTs]

Every value in Rust is of a certain _data type_, which tells Rust what kind of data is being specified so it knows how to work with that data. We’ll look at two data type subsets: **scalar** and **compound**

Keep in mind that Rust is a _statically typed language_, which means that it must know the types of all variables at compile time

### [Scalar Types][STs]

A scalar type represents a single value. Rust has four primary scalar types:

- integers
- floating-point
- numbers
- Booleans
- characters

#### [Integer Types][Ints]

| Length  | Signed  | Unsigned |
| ------- | ------- | -------- |
| 8-bit   | `i8`    | `u8`     |
| 16-bit  | `i16`   | `u16`    |
| 32-bit  | `i32`   | `u32`    |
| 64-bit  | `i64`   | `u64`    |
| 128-bit | `i128`  | `u128`   |
| arch    | `isize` | `usize`  |

#### Integer Literals

| Number literals  | Example       |
| ---------------- | ------------- |
| Decimal          | `98_222`      |
| Hex              | `0xff`        |
| Octal            | `0o77`        |
| Binary           | `0b1111_0000` |
| Byte (`u8` only) | `b'A'`        |

#### [Floating-Point Types][Floating-Point]

Rust’s floating-point types are _f32_ and _f64_, which are _32 bits_ and _64 bits_ in size. The default type is _f64_ because on modern CPUs, it’s roughly the same speed as _f32_ but is capable of more precision. All floating-point types are signed

Floating-point numbers are represented according to the _IEEE-754_ standard. The _f32_ type is a _single-precision_ float, and _f64_ has double precision

#### [The Boolean Type][BooleanType]

As in most other programming languages, a Boolean type in Rust has two possible values: _true_ and _false_

Booleans are one byte in size, the Boolean type in Rust is specified using _bool_

#### [Char]

Rust’s char type is _four bytes_ in size and represents a Unicode Scalar Value, which means it can represent a lot more than just _ASCII_. Accented letters; Chinese, Japanese, and Korean characters; _emoji_ and _zero-width_ spaces are all valid char values in Rust

#### [Numeric Operations][NumericOperations]

Rust supports the basic mathematical operations you’d expect for all the number types: _addition_, _subtraction_, _multiplication_, _division_, and _remainder_

Integer division truncates toward _zero_ to the nearest integer

Compound types can group multiple values into one type. Rust has two primitive compound types: _tuples_ and _arrays_

### [Compound Types][CompoundTypes]

Compound types can group multiple values into one type. Rust has two primitive compound types: tuples and arrays

#### [Tuple Type][TupleType]

A tuple is a general way of grouping together a number of values with a variety of types into one compound type. Tuples have a `fixed length`: `once declared`, they cannot grow or shrink in size.

**Tuple Destructuring**: This program first creates a tuple and binds it to the variable tup. It then uses a pattern with let to take tup and turn it into three separate variables, x, y, and z. This is called **_`destructuring`_** because it breaks the single tuple into three parts. Finally, the program prints the value of y, which is 6.4

```rust
fn main() {
    let x: (i32, f64, u8) = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one = x.2;
}
```

#### unit

> The tuple without any values has a special name, **_unit_**. This value and its corresponding type are both written `()` and represent an _empty value_ or an _empty return_ type. Expressions implicitly return the unit value if they don’t return any other value

#### [The Array Type][ArrayType]

Another way to have a collection of multiple values is with an array. Unlike a tuple, every element of an array must have the same type. Unlike arrays in some other languages, "arrays in Rust have a fixed length"

Arrays are useful when you want your data _'allocated on the stack'_ rather than the _heap_

An array isn’t as flexible as the _vector_ type, though. A vector is a similar collection type provided by the standard library that is allowed to _'grow or shrink'_ in size

**Accessing Array Elements** An array is a single chunk of memory of a known, _fixed size_ that can be _'allocated on the stack'_. You can access elements of an array using indexing

```rust
fn main() {
    let a = [1, 2, 3, 4, 5];

    let first = a[0];
    let second = a[1];
}
```

## [Functions]

In function signatures, you must _declare_ the type of each parameter. This is a deliberate decision in Rust’s design: requiring type annotations in function definitions means the compiler almost never needs you to use them elsewhere in the code to figure out what type you mean and The compiler is also able to give more helpful error messages if it knows what types the function expects

### [Functions with Return Values][FunctionsReturnValues]

In Rust, the return value of the function is synonymous with the value of the final expression in the block of the body of a function.

You can return early from a function by using the return keyword and specifying a value, but most functions return the last expression implicitly

## [Statements and Expressions][SE]

### Statements

are instructions that perform some action and do not return a value.

- Creating a variable and assigning a value to it with the _let_ keyword is a statement
- The declaration statement in the program is called a defining declaration statement or definition for short
- Function definitions are also statements

### Expressions

Expressions evaluate to a resultant value

- Expressions can be part of _statements_, that equal to Expression Statement
- Calling a function is an expression
- Calling a macro is an expression
- A new scope block created with curly brackets is an expression

```rust
fn main() {
let y = {
    let x = 3;
    x + 1
};

println!("The value of y is: {y}");
}
```

Expressions do not include ending semicolons. If you add a semicolon to the end of an expression, you turn it into a statement, and it will then not return a value.

```rust
  let x = let y = 6;
```

> The `let y = 6` statement does not return a value, so there isn’t anything for _x_ to bind to. This is different from what happens in other languages, such as _C_ and _Ruby_, where the assignment returns the value of the assignment. In those languages, you can write `x = y = 6` and have both _x_ and _y_ have the value _6_ that is not the case in Rust

## Complete List of Keywords

### Strict Keywords (always reserved)

These keywords can only be used in their designated contexts.

- `as` Perform type casting or rename imports.
- `async` Mark a function or block as asynchronous.
- `await` Pause execution until a future completes.
- `break` Exit a loop or match expression.
- `const` Define constants or constant functions.
- `continue` Skip to the next iteration of a loop.
- `crate` Refer to the current crate or import the root module.
- `dyn` Indicate dynamic dispatch for trait objects.
- `else` Define the fallback branch of an if or if let expression.
- `enum` Define an enumeration.
- `extern` Link to external functions or crates.
- `false` Boolean literal representing falsity.
- `fn` Define a function.
- `for` Iterate over an iterator or range.
- `if` Conditional branching.
- `impl` Implement functionality for a type.
- `in` Used in for loops to specify the iterator.
- `let` Bind a value to a variable.
- `loop` Create an infinite loop.
- `match` Pattern matching.
- `mod` Define a module.
- `move` Indicate that a closure takes ownership of its captured variables.
- `mut` Declare mutability.
- `pub` Make an item public.
- `ref` Bind by reference in patterns.
- `return` Return a value from a function.
- `Self` Alias for the implementing type in traits or impl blocks.
- `self` Refer to the current module or method receiver.
- `static` Define a global variable or lifetime.
- `struct` Define a structure.
- `super` Refer to the parent module.
- `trait` Define a trait.
- `true` Boolean literal representing truth.
- `type` Define a type alias.
- `union` Define a union (unsafe Rust).
- `unsafe` Mark code that bypasses Rust's safety guarantees.
- `use` Import items into the current scope.
- `where` Specify constraints on generic types.
- `while` Loop while a condition is true.

### Reserved Keywords (not currently used but reserved for future use)

These keywords are reserved for potential future use and cannot be used as identifiers.

- `abstract`
- `become`
- `box`
- `do`
- `final`
- `macro`
- `override`
- `priv`
- `try`
- `typeof`
- `unsized`
- `virtual`
- `yield`

### Weak Keywords (context-dependent)

These keywords have special meaning only in specific contexts and can otherwise be used as identifiers.

- `default` Used in impl blocks to provide default implementations.
- `macro_rules` Define a macro.
- `union` Define a union (usable as an identifier outside of union definitions).
- `dyn` Used for dynamic dispatch (usable as an identifier in other contexts).

### Some Important Macros in Rust

- `macro_rules!` Define a macro.
- `cfg!` Conditional compilation.
- `include!` Include a file at compile time.
- `include_str!` Include a file as a string.
- `include_bytes!` Include a file as a byte array.
- `concat!` Concatenate literals.
- `env!` Access environment variables at compile time.
- `option_env!` Access environment variables optionally.
- `format!` Format a string.
- `panic!` Cause a panic.
- `assert!` Assert a condition.
- `assert_eq!` Assert equality.
- `assert_ne!` Assert inequality.
- `unreachable!` Mark code as unreachable.
- `unimplemented!` Mark code as unimplemented.
- `todo!` Mark code as a todo item.
- `dbg!` Debug print a value.

<!-- links -->

[DTs]: https://doc.rust-lang.org/book/ch03-02-data-types.html#data-types
[STs]: https://doc.rust-lang.org/book/ch03-02-data-types.html#scalar-types
[Ints]: https://doc.rust-lang.org/book/ch03-02-data-types.html#integer-types
[Floating-Point]: https://doc.rust-lang.org/book/ch03-02-data-types.html#floating-point-types
[NumericOperations]: https://doc.rust-lang.org/book/ch03-02-data-types.html#numeric-operations
[BooleanType]: https://doc.rust-lang.org/book/ch03-02-data-types.html#the-boolean-type
[Char]: https://doc.rust-lang.org/book/ch03-02-data-types.html#the-character-type
[CompoundTypes]: https://doc.rust-lang.org/book/ch03-02-data-types.html#compound-types
[TupleType]: https://doc.rust-lang.org/book/ch03-02-data-types.html#the-tuple-type
[ArrayType]: https://doc.rust-lang.org/book/ch03-02-data-types.html#the-array-type
[Functions]: https://doc.rust-lang.org/book/ch03-03-how-functions-work.html#functions
[SE]: https://doc.rust-lang.org/book/ch03-03-how-functions-work.html#statements-and-expressions
[FunctionsReturnValues]: https://doc.rust-lang.org/book/ch03-03-how-functions-work.html#functions-with-return-values
