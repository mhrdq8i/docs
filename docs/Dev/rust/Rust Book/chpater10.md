# Chapter 10

## Some Important Terms

### Definitions

is `Declaration` and `Initiation` in the same Statement.

### Initialization

When a variable is initialized, memory is allocated for it, and the _assigned_ value is stored in that memory location.

_Initialization_ is a **one-time process** that occurs when the variable is created.

In C++

```cpp
// Initialization:
int x = 2; // Initialization using assignment operator
int y{2}; // Initialization using brace initialization syntax

// Assignment:
int x = 2; // Initialization
x = 5; // Assignment
```

Rust Declaration

```rust
// Variable declaration
let x: i32;


// Function declaration
fn my_function(arg: i32) -> i32;


// Type declaration (creating an alias)
type MyType = i32;


// Module declaration.
mod math;

```

Rust Definition

```rust
// Variable definition
let x: i32 = 42;


// Function definition
fn my_function(arg: i32) -> i32 {
    arg * 2
}


// Type definition (creating a struct)
struct MyStruct {
    field1: i32,
    field2: f64,
}


// Module definition
mod math;

// This is a function inside the "math" module.
pub fn main_function() {
    println!("Calling the main function");
}
```

Declaration & Definition

```rust
// This is both a declaration and a definition

mod my_module {

// Function definition" inside "my_module"
    pub fn my_function() {
        // Function implementation
    }
}
```

### Assignment

Variable _assignment_, on the other hand, is the process of assigning a new value to an already existing variable.

**Note:** Assignment statement in Rust and doesn't return a value.

## Lifetimes

Lifetimes allow us to give the compiler enough information about borrowed values so that it can ensure references will be valid in more situations than it could without our help.

Every reference in Rust has a lifetime, which is the scope for which that reference is valid.

> The main aim of lifetimes is to prevent _dangling references_.

### Invalid pattern for lifetime in rust

```rust
fn main() {
    let r;                // ---------+-- 'a
                          //          |
    {                     //          |
        let x = 5;        // -+-- 'b  |
        r = &x;           //  |       |
    }                     // -+       |
                          //          |
    println!("r: {}", r); //          |
}                         // ---------+
```

Here, we’ve annotated the lifetime of r with 'a and the lifetime of x with 'b. As you can see, the inner 'b block is much smaller than the outer 'a lifetime block. At compile time, Rust compares the size of the two lifetimes and sees that r has a lifetime of 'a but that it refers to memory with a lifetime of 'b. The program is rejected because 'b is shorter than 'a: the subject of the reference doesn’t live as long as the reference.

### Valid pattern for lifetime in rust

```rust

fn main() {
    let x = 5;            // ----------+-- 'b
                          //           |
    let r = &x;           // --+-- 'a  |
                          //   |       |
    println!("r: {}", r); //   |       |
                          // --+       |
}                         // ----------+
```

Here, x has the lifetime 'b, which in this case is larger than 'a. This means r can reference x because Rust knows that the reference in r will always be valid while x is valid.

### Generic Lifetime

```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

The generic lifetime 'a will get the concrete lifetime that is equal to the smaller of the lifetimes of _x_ and _y_.

> Lifetimes on function or method parameters are called **input lifetimes**, and lifetimes on return values are called **output lifetimes**.

### Compiler Rules in Lifetimes

1. The first rule is that the compiler assigns a lifetime parameter to each parameter that’s a reference. In other words, a function with one parameter gets one lifetime parameter: fn foo<'a>(x: &'a i32); a function with two parameters gets two separate lifetime parameters: fn foo<'a, 'b>(x: &'a i32, y: &'b i32); and so on.

2. The second rule is that, if there is exactly one input lifetime parameter, that lifetime is assigned to all output lifetime parameters: fn foo<'a>(x: &'a i32) -> &'a i32.

3. The third rule is that, if there are multiple input lifetime parameters, but one of them is &self or &mut self because this is a method, the lifetime of self is assigned to all output lifetime parameters. This third rule makes methods much nicer to read and write because fewer symbols are necessary.

## Monomorphization

Rust accomplishes this by performing _monomorphization_ of the code using generics at compile time. _Monomorphization_ is the process of turning generic code into specific code by filling in the concrete types that are used when compiled. In this process, the compiler does the opposite of the steps we used to create the generic function in Listing 10-5: the compiler looks at all the places where generic code is called and generates code for the concrete types the generic code is called with.

At runtime, Rust's generics don't exhibit the same kind of type erasure as some other languages with runtime polymorphism (e.g., Java's generics with type erasure). Instead, Rust's generics are monomorphic, meaning that the generic code is transformed into concrete code for each specific type during compilation.

No _Runtime Type Information_ (RTTI): Rust does not include runtime type information by default. There is no _runtime overhead_ for checking or managing generic types. The type information is entirely resolved at compile time.

## Traits

_Implementations_ of a trait on any type that satisfies the trait bounds are called _blanket implementations_ and are extensively used in the Rust standard library
