# Data Types & Keywords

## [Data Types][DTs]

Every value in Rust is of a certain `data type`, which tells Rust what kind of data is being specified so it knows how to work with that data. We’ll look at two data type subsets: **`scalar`** and **`compound`**.

Keep in mind that Rust is a `statically typed language`, which means that it must know the types of all variables at `compile time`.

### [Scalar Types][STs]

A scalar type represents a single value. Rust has four primary scalar types: `integers`, `floating-point` numbers, `Booleans`, and `characters`.

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

Rust’s floating-point types are `f32` and `f64`, which are `32 bits` and `64 bits` in size. The default type is `f64` because on modern CPUs, it’s roughly the same speed as `f32` but is capable of more precision. All floating-point types are signed.

Floating-point numbers are represented according to the `IEEE-754` standard. The `f32` type is a `single-precision` float, and `f64` has `double precision`.

#### [The Boolean Type][BooleanType]

As in most other programming languages, a Boolean type in Rust has two possible values: `true` and `false`. `Booleans are one byte in size`. The Boolean type in Rust is specified using `bool`.

#### [Char]

Rust’s char type is `four bytes` in size and represents a Unicode Scalar Value, which means it can represent a lot more than just `ASCII`. Accented letters; `Chinese`, `Japanese`, and `Korean` characters; `emoji`; and `zero-width` spaces are all valid char values in Rust

### [Numeric Operations][NumericOperations]

Rust supports the basic mathematical operations you’d expect for all the number types: `addition`, `subtraction`, `multiplication`, `division`, and `remainder`. Integer division truncates toward `zero` to the nearest integer.

Compound types can group multiple values into one type. Rust has two primitive compound types: `tuples` and `arrays`.

### [Compound Types][CompoundTypes]

### [Tuple Type](https://doc.rust-lang.org/book/ch03-02-data-types.html#the-tuple-type)

A `tuple` is a general way of `grouping together` a number of values with a variety of types into one compound type. Tuples have a f`ixed length`: `once declared`, they cannot grow or shrink in size.

**Tuple Destructuring**: This program first creates a tuple and binds it to the variable tup. It then uses a pattern with let to take tup and turn it into three separate variables, x, y, and z. This is called **_`destructuring`_** because it breaks the single tuple into three parts. Finally, the program prints the value of y, which is 6.4.

```rust
fn main() {
    let x: (i32, f64, u8) = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one = x.2;
}
```

**Unit:** The tuple without any values has a special name, **_`unit`_**. This value and its corresponding type are both written `()` and represent an `empty value` or an `empty return` type. Expressions implicitly return the unit value if they don’t return any other value.

### [The Array Type](https://doc.rust-lang.org/book/ch03-02-data-types.html#the-array-type)

Another way to have a collection of multiple values is with an array. Unlike a tuple, every element of an array must have the same type. `Unlike arrays in some other languages`, arrays in Rust have a `fixed length`.

Arrays are useful when you want your data `allocated` on the `stack` rather than the `heap` .

An array isn’t as `flexible` as the `vector` type, though. A vector is a similar collection type provided by the standard library that is allowed to `grow` or `shrink` in size.

**Accessing Array Elements"** An array is a single chunk of memory of a known, `fixed size` that can be `allocated` on the `stack`. You can access elements of an array using `indexing`.

```rust
fn main() {
    let a = [1, 2, 3, 4, 5];

    let first = a[0];
    let second = a[1];
}
```

## [Functions](https://doc.rust-lang.org/book/ch03-03-how-functions-work.html#functions)

In function signatures, you `must declare` the type of each parameter. This is a deliberate decision in Rust’s design: requiring type annotations in function definitions means **the compiler almost never needs you to use them elsewhere in the code to figure out what type you mean**. `And` **The compiler is also able to give more helpful error messages if it knows what types the function expects**.

## [Statements and Expressions](https://doc.rust-lang.org/book/ch03-03-how-functions-work.html#statements-and-expressions)

- **`Statements:`** are instructions that perform some action and do not return a value.
  - Creating a variable and assigning a value to it with the `let` keyword is a `statement`.
  - The `declaration statement` in the program is called a `defining declaration statement`, or `definition`, for short.
  - `Function definitions` are also `statements`;
- **`Expressions:`** evaluate to a resultant value.

  - `Expressions` can be part of `statements`, that equal to `Expression Statement`.
  - `Calling a function` is an `expression`.
  - `Calling a macro` is an `expression`.
  - A new scope block created with curly brackets is an `expression`.

    ```rust
    fn main() {
    let y = {
        let x = 3;
        x + 1
    };

    println!("The value of y is: {y}");
    }
    ```

  - `Expressions` do not include `ending semicolons`. If you `add a semicolon to the end of an expression`, you turn it into a `statement`, and it will then `not return a value`.
  -

```rust
  let x = let y = 6;
```

> The `let y = 6` statement does not return a value, so there isn’t anything for `x` to bind to. This is different from what happens in other languages, such as `C` and `Ruby`, where the `assignment returns the value of the assignment`. In those languages, you can write `x = y = 6` and have both `x` and `y` have the value `6`; \_that is not the case in `Rust`.

### [Functions with Return Values](https://doc.rust-lang.org/book/ch03-03-how-functions-work.html#functions-with-return-values)

In Rust, the return value of the function is synonymous with the value of the final expression in the block of the body of a function.

You can return early from a function by using the `return` keyword and specifying a value, but most functions `return` the `last expression implicitly`.

<!-- links -->
[DTs]: https://doc.rust-lang.org/book/ch03-02-data-types.html#data-types
[STs]: https://doc.rust-lang.org/book/ch03-02-data-types.html#scalar-types
[Ints]: https://doc.rust-lang.org/book/ch03-02-data-types.html#integer-types
[Floating-Point]: https://doc.rust-lang.org/book/ch03-02-data-types.html#floating-point-types
[NumericOperations]: https://doc.rust-lang.org/book/ch03-02-data-types.html#numeric-operations
[BooleanType]: https://doc.rust-lang.org/book/ch03-02-data-types.html#the-boolean-type
[Char]: https://doc.rust-lang.org/book/ch03-02-data-types.html#the-character-type
[CompoundTypes]: https://doc.rust-lang.org/book/ch03-02-data-types.html#compound-types
