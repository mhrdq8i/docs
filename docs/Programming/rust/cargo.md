## [Cargo](https://doc.rust-lang.org/cargo/)

Cargo is the `Rust package manager`. Cargo downloads your Rust package’s dependencies, **compiles your packages**, makes distributable packages, and uploads them to `crates.io`, the Rust community’s package registry. You can contribute to this book on GitHub.

### [Cargo Commands](https://doc.rust-lang.org/cargo/commands/index.html)

- [cargo **init** [options] [path] — Create a new Cargo package in an existing directory](https://doc.rust-lang.org/cargo/commands/cargo-init.html)
- [cargo **add** [options] --path/--git url [crate…] — Add dependencies to a Cargo.toml manifest file](https://doc.rust-lang.org/cargo/commands/cargo-add.html)
- [cargo **tree** [options] — Display a tree visualization of a dependency graph](https://doc.rust-lang.org/cargo/commands/cargo-tree.html)
- [cargo **build** [options] — Compile the current package](https://doc.rust-lang.org/cargo/commands/cargo-build.html)
- [cargo **run** [options] [-- args] — Build & Run the current package](https://doc.rust-lang.org/cargo/commands/cargo-run.html)
- [cargo **rustc** [options] [-- args] — Compile the current package, and pass extra options to the compiler](https://doc.rust-lang.org/cargo/commands/cargo-rustc.html)
- [cargo **check** [options] — Check the current package](https://doc.rust-lang.org/cargo/commands/cargo-check.html)
- [cargo **test** [options] [testname] [-- test-options] — Execute unit and integration tests of a package](https://doc.rust-lang.org/cargo/commands/cargo-test.html)

### [Module](https://doc.rust-lang.org/cargo/appendix/glossary.html#module)

Rust’s module system is used to organize code into `logical units` called `modules`, which provide `isolated namespaces` within the code.

The `source code` for a given `crate` may be subdivided into one or more separate `modules`.

### [Package](https://doc.rust-lang.org/cargo/appendix/glossary.html#package)

A package is a collection of `source files` and a `Cargo.toml manifest` file which describes the package. A package has a `name` and `version` which is used for specifying `dependencies between packages`.

A package contains multiple targets, each of which is a `crate`.

### [Crate](https://doc.rust-lang.org/cargo/appendix/glossary.html#crate)

A Rust crate is either a `library` or an `executable program`, referred to as either a library crate or a binary crate, respectively.

Every `target` defined for a `Cargo package` is a `crate`.
