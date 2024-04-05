# Chapter 08

## [HashMap]

Hash Map: all of the keys must have the same type as each other, and all of the values must have the same type

## [String]

Rust strings don’t support indexing. A String is a wrapper over a Vec\<u8\>.

## [Concatenation with the + Operator or the format! Macro][scwpomf]

```rust
    let s1 = String::from("Hello, ");
    let s2 = String::from("world!");
    let s3 = s1 + &s2; // note s1 has been moved here and can no longer be used
```

The string `s3` will contain `Hello, world!`. The reason `s1` is no longer
valid after the addition, and the reason we used a reference to `s2`, has to do
with the signature of the method that’s called when we use the `+` operator.
The `+` operator uses the `add` method, whose signature looks something like
this:

```rust
fn add(self, s: &str) -> String {
```

The reason we’re able to use `&s2` in the call to `add` is that the compiler
can *coerce* the `&String` argument into a `&str`. When we call the `add`
method, Rust uses a *deref coercion*, which here turns `&s2` into `&s2[..]`.
We’ll discuss deref coercion in more depth in Chapter 15. Because `add` does
not take ownership of the `s` parameter, `s2` will still be a valid `String`
after this operation.

## Difference of "&str" and "String"

- `&str` is a borrowed string slice that points to existing string data.
- `String` is an owned, heap-allocated string that can be modified and resized.

```rust
fn main() {
    // String slice (&str) - Immutable reference to a string literal
    let str_slice: &str = "hello";

    // String (owned) - Dynamically allocated, mutable string
    let mut owned_string: String = String::from("world");

    // Append to the owned string
    owned_string.push_str(", Rust!");

    println!("{}", str_slice); // Prints: hello
    println!("{}", owned_string); // Prints: world, Rust!
}
```

## [Bytes and Scalar Values and Grapheme Clusters! Oh My!][bsgc]

Another point about UTF-8 is that there are actually three relevant ways to look at strings from Rust’s perspective: as *bytes*, *scalar values*, and *grapheme clusters* (the closest thing to what we would call letters).

<!-- links -->
[HashMap]: https://doc.rust-lang.org/stable/book/ch08-03-hash-maps.html#creating-a-new-hash-map
[String]: https://doc.rust-lang.org/stable/book/ch08-02-strings.html
[scwpomf]: https://doc.rust-lang.org/stable/book/ch08-02-strings.html#concatenation-with-the--operator-or-the-format-macro
[bsgc]: https://doc.rust-lang.org/stable/book/ch08-02-strings.html#bytes-and-scalar-values-and-grapheme-clusters-oh-my
