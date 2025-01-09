# Smart Pointers

## Definition

- while references only borrow data, in many cases, smart pointers own the data they point to.
- Smart pointers implement the `Deref` and `Drop` traits.

### Some Important Smart Pointers in Rust

- String
- Vec<T>

### Most common smart pointers in the standard library

- `Box<T>` for allocating values on the heap. `Rc<T>`, a reference counting type that enables multiple ownership. `Ref<T>` and `RefMut<T>`, accessed through `RefCell<T>`, a type that enforces the borrowing rules at runtime instead of compile time

- With references and `Box<T>`, the borrowing rules’ invariants are enforced at compile time. With `RefCell<T>`, these invariants are enforced at runtime. With references, if you break these rules, you’ll get a compiler error. With `RefCell<T>`, if you break these rules, your program will panic and exit.

- The `Box<T>` type has a known size and points to data allocated on the heap. The `Rc<T>` type keeps track of the number of references to data on the heap so that data can have multiple owners. The `RefCell<T>` type with its interior mutability gives us a type that we can use when we need an immutable type but need to change an inner value of that type; it also enforces the borrowing rules at runtime instead of at compile time.
