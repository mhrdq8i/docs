# Chapter 09

## [Error Handling][error-handling]

Rust groups errors into two major categories: _recoverable_ and _unrecoverable_ errors.

Most languages don’t distinguish between these two kinds of errors and handle both in the same way, using mechanisms such as exceptions.

Rust doesn’t have exceptions. Instead, it has the type `Result<T, E>` for _**recoverable errors**_ and the `panic!` macro that stops execution when the program encounters an _**unrecoverable error**_.

Using `unwrap_or_else` allows us to define some custom, _non-panic!_ error handling.

## [Unwinding the Stack or Aborting in Response to a Panic][usorarp]

> By default, when a panic occurs, the program starts _unwinding_, which
> means Rust walks back up the stack and cleans up the data from each function
> it encounters. However, this walking back and cleanup is a lot of work. Rust,
> therefore, allows you to choose the alternative of immediately _aborting_,
> which ends the program without cleaning up.

## [Using a panic! Backtrace][uapbt]

### Buffer Overread

In C, attempting to read beyond the end of a data structure is undefined behavior. You might get whatever is at the location in memory that would correspond to that element in the data structure, even though the memory doesn’t belong to that structure. This is called a _buffer overread_ and can lead to security vulnerabilities if an attacker is able to manipulate the index in such a way as to read data they shouldn’t be allowed to that is stored after the data structure.

## [Propagating Errors][pres] (like Throw)

When a function’s implementation calls something that might fail, instead of handling the error within the function itself, you can return the error to the calling code so that it can decide what to do. This is known as _propagating_ the error and gives more control to the calling code, where there might be more information or logic that dictates how the error should be handled than what you have available in the context of your code.

A Shortcut for Propagating Errors: the `?` Operator.

```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    let mut username_file = File::open("hello.txt")?;
    let mut username = String::new();
    username_file.read_to_string(&mut username)?;
    Ok(username)
}
```

A function that returns errors to the calling code using the `?` operator
<!-- links -->
[error-handling]: https://doc.rust-lang.org/stable/book/ch09-00-error-handling.html#error-handling
[usorarp]: https://doc.rust-lang.org/stable/book/ch09-01-unrecoverable-errors-with-panic.html?highlight=unwinding#unwinding-the-stack-or-aborting-in-response-to-a-panic
[uapbt]: https://doc.rust-lang.org/stable/book/ch09-01-unrecoverable-errors-with-panic.html?highlight=unwinding#unwinding-the-stack-or-aborting-in-response-to-a-panic
[pres]: https://doc.rust-lang.org/stable/book/ch09-02-recoverable-errors-with-result.html#propagating-errors
