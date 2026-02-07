# Chapter 05

## Associated Functions

All functions defined within an `impl` block are called _associated functions_
because they’re associated with the type named after the `impl`. We can define
associated functions that don’t have `self` as their first parameter (and thus
are not methods) because they don’t need an instance of the type to work with.
We’ve already used one function like this: the `String::from` function that’s
defined on the `String` type.

Associated functions that aren’t methods are often used for constructors that
will return a new instance of the struct. These are often called `new`, but
`new` isn’t a special name and isn’t built into the language. For example, we
could choose to provide an associated function named `square` that would have
one dimension parameter and use that as both width and height, thus making it
easier to create a square `Rectangle` rather than having to specify the same
value twice:

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn square(size: u32) -> Self {
        Self {
            width: size,
            height: size,
        }
    }
}

fn main() {
    let sq = Rectangle::square(3);
}
```

The `Self` keywords in the return type and in the body of the function are
aliases for the type that appears after the `impl` keyword, which in this case
is `Rectangle`.

To call this associated function, we use the `::` syntax with the struct name;
`let sq = Rectangle::square(3);` is an example. This function is namespaced by
the struct: The `::` syntax is used for both associated functions and
namespaces created by modules.

### The Philosophy

Associated functions are operations that belong to a type conceptually,
but don't operate on a specific instance.

### Usage

Associated Functions have Two Use Cases

1. Creating instances (most common)

```rust
impl Player {
    fn new(name: &str) -> Player { /* ... */ }
    fn with_score(name: &str, score: u32) -> Player { /* ... */ }
    fn default() -> Player { /* ... */ }
}

let p1 = Player::new("Alice");
let p2 = Player::with_score("Bob", 100);
let p3 = Player::default();
```

2. Utility functions related to the type (no instance created)

```rust
   impl Player {
    // Returns a value, not a Player
    fn max_score() -> u32 {
        1000
    }

    // Returns a string, not a Player
    fn valid_name(name: &str) -> bool {
        !name.is_empty() && name.len() < 50
    }

    // Compares two players, returns one of them
    fn higher_score<'a>(a: &'a Player, b: &'a Player) -> &'a Player {
        if a.score >= b.score { a } else { b }
    }

}

// Usage - no new instance created
let max = Player::max_score();
let valid = Player::valid_name("Alice");
let winner = Player::higher_score(&p1, &p2);

```

Any function inside `impl` block that has no `self` parameter are **Associated function**

```rust
impl MyType {
    // Associated function that creates instance
    fn new() -> MyType { }

    // Associated function that returns number
    fn default_value() -> i32 { 42 }

    // Associated function that returns nothing
    fn print_info() { println!("MyType v1.0"); }

    // NOT associated function - this is a method (has self)
    fn do_something(&self) { }
}

```

### Summary Table

| Function | Has `self`? | Creates Instance? | What is it? |
|----------|-------------|-------------------|-------------|
| `fn new() -> Self` | No | Yes | Associated function |
| `fn max_value() -> u32` | No | No | Associated function |
| `fn validate(s: &str) -> bool` | No | No | Associated function |
| `fn get_name(&self) -> &str` | Yes | No | Method |
| `fn set_name(&mut self, n: &str)` | Yes | No | Method |


### Quick Reference

| Aspect | Associated Function | Free Function | Method |
|--------|---------------------|---------------|--------|
| **Location** | Inside `impl` block | Outside any `impl` | Inside `impl` block |
| **Has `self`?** | No | No | Yes |
| **Call syntax** | `Type::function()` | `function()` or `module::function()` | `instance.method()` |
| **Needs instance?** | No | No | Yes |
| **Namespaced?** | Yes, under type | Yes, under module | Yes, under type |

### Definition Comparison

```rust
struct Player {
    name: String,
    score: u32,
}

// ================================
// ASSOCIATED FUNCTION
// Inside impl, no self
// ================================
impl Player {
    fn new(name: &str) -> Player {
        Player { name: name.into(), score: 0 }
    }
}

// ================================
// FREE FUNCTION
// Outside impl, standalone
// ================================
fn calculate_bonus(score: u32) -> u32 {
    score * 2
}

// ================================
// METHOD
// Inside impl, has self
// ================================
impl Player {
    fn get_score(&self) -> u32 {
        self.score
    }
}
```

### Call Syntax Comparison

```rust
// Associated Function: Type::function()
let player = Player::new("Alice");
let max = i32::MAX;
let s = String::from("hello");

// Free Function: function() or module::function()
let bonus = calculate_bonus(100);
let id = uuid::Uuid::new_v4();
let hash = crypto::hash_password("secret");

// Method: instance.method()
let score = player.get_score();
let len = s.len();
let upper = s.to_uppercase();
```

### When to Use Each

- Associated Functions
- Free Functions
- Methods

### Associated Functions

| Use Case | Example |
|----------|---------|
| Constructors | `Player::new("Alice")` |
| Alternative constructors | `Player::guest()`, `Player::from_json(data)` |
| Type-level constants | `i32::MAX`, `f64::INFINITY` |
| Validation before creation | `Player::try_new(name) -> Result<Player>` |
| Factory patterns | `Connection::connect(url)` |

```rust
impl Player {
    // Constructor
    fn new(name: &str) -> Player { }

    // Alternative constructor
    fn guest() -> Player {
        Player::new("Guest")
    }

    // Fallible constructor
    fn try_new(name: &str) -> Result<Player, Error> {
        if name.is_empty() {
            return Err(Error::InvalidName);
        }
        Ok(Player::new(name))
    }

    // Type-level constant
    fn max_score() -> u32 { 1000 }
}
```

### Free Functions

| Use Case | Example |
|----------|---------|
| Utilities not tied to a type | `generate_uuid()` |
| Operations on multiple types | `save_to_file(player, path)` |
| Module-level API | `crypto::hash_password()` |
| Generic operations | `serialize<T: Serialize>(value: &T)` |
| Entry points | `fn main()` |

```rust
// Utility
fn current_timestamp() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_secs()
}

// Cross-type operation
fn save_to_file(player: &Player, path: &Path) -> Result<()> {
    let json = serde_json::to_string(player)?;
    std::fs::write(path, json)?;
    Ok(())
}

// Generic operation
fn print_debug<T: Debug>(value: &T) {
    println!("{:?}", value);
}

// Module API (in crypto.rs)
pub fn hash_password(password: &str) -> String { }
pub fn verify_password(password: &str, hash: &str) -> bool { }
```

### Methods

| Use Case | Example |
|----------|---------|
| Read instance data | `player.get_score()` |
| Modify instance data | `player.add_score(10)` |
| Instance behavior | `player.is_winner()` |
| Chained operations | `builder.name("X").score(10).build()` |
| Consume instance | `player.into_name()` |

```rust
impl Player {
    // Read data (&self)
    fn get_score(&self) -> u32 {
        self.score
    }

    fn get_name(&self) -> &str {
        &self.name
    }

    fn is_winner(&self) -> bool {
        self.score >= 100
    }

    // Modify data (&mut self)
    fn add_score(&mut self, points: u32) {
        self.score += points;
    }

    fn reset(&mut self) {
        self.score = 0;
    }

    // Consume instance (self)
    fn into_name(self) -> String {
        self.name
    }

    // Chaining (self -> Self)
    fn with_bonus(mut self, bonus: u32) -> Self {
        self.score += bonus;
        self
    }
}
```

### Method Self Types

| Self Type | Can Read | Can Modify | Instance After | Use Case |
|-----------|----------|------------|----------------|----------|
| `&self` | ✓ | ✗ | Usable | Getters, queries |
| `&mut self` | ✓ | ✓ | Usable | Setters, mutations |
| `self` | ✓ | ✓ | **Consumed** | Transforms, builders |

```rust
impl Player {
    fn view(&self) { }           // Borrow, read-only
    fn modify(&mut self) { }     // Borrow, read-write
    fn consume(self) { }         // Takes ownership
}

let mut p = Player::new("Alice");
p.view();                        // p still usable
p.modify();                      // p still usable
p.consume();                     // p is GONE
// p.view();                     // Error: p was moved
```

### Decision Flowchart

```rust
Need to create an instance?
├─ Yes → Associated Function (Type::new())
└─ No
   │
   Does it need access to instance data?
   ├─ Yes → Method (instance.method())
   │   │
   │   Need to modify?
   │   ├─ Yes → &mut self
   │   └─ No → &self
   │
   └─ No
      │
      Is it tightly coupled to ONE type?
      ├─ Yes → Associated Function (Type::helper())
      └─ No → Free Function (module::function())
```

### Standard Library Examples

#### Associated Functions

```rust
String::new()                    // Constructor
String::from("hello")            // From conversion
String::with_capacity(10)        // Pre-allocated
Vec::<i32>::new()                // Constructor with type
HashMap::with_capacity(100)      // Pre-allocated
i32::MAX                         // Type constant
i32::from_str("42")              // Parsing
```

#### Free Functions

```rust
std::mem::swap(&mut a, &mut b)   // Works on any type
std::mem::replace(&mut a, b)     // Works on any type
std::cmp::min(a, b)              // Works on any Ord
std::cmp::max(a, b)              // Works on any Ord
std::thread::spawn(|| {})        // Utility
std::fs::read_to_string(path)    // I/O utility
println!("hello")                // Macro (special)
```

#### Methods

```rust
"hello".len()                    // Query
"hello".to_uppercase()           // Transform
vec.push(item)                   // Mutate
vec.pop()                        // Mutate + return
vec.iter()                       // Create iterator
vec.into_iter()                  // Consume into iterator
string.as_str()                  // Borrow as different type
option.unwrap()                  // Consume + extract
result.map(|x| x + 1)            // Transform inner value
```

### Common Patterns

#### Constructor Pattern

```rust
impl Config {
    fn new() -> Self { }                           // Basic
    fn from_file(path: &Path) -> Result<Self> { }  // From source
    fn builder() -> ConfigBuilder { }               // Builder pattern
}
```

#### Builder Pattern

```rust
impl PlayerBuilder {
    fn new() -> Self { }                    // AF: create builder
    fn name(mut self, n: &str) -> Self { }  // Method: chain
    fn score(mut self, s: u32) -> Self { }  // Method: chain
    fn build(self) -> Player { }            // Method: consume
}

let player = PlayerBuilder::new()
    .name("Alice")
    .score(100)
    .build();
```

#### Conversion Pattern

```rust
impl Player {
    fn as_str(&self) -> &str { }       // Borrow as
    fn to_string(&self) -> String { }  // Clone to
    fn into_inner(self) -> String { }  // Consume into
}
```

### Summary Table

| I want to... | Use | Example |
|--------------|-----|---------|
| Create instance | Associated Function | `Player::new()` |
| Get type constant | Associated Function | `i32::MAX` |
| Parse/convert to type | Associated Function | `String::from()` |
| Read instance data | Method `&self` | `player.get_score()` |
| Modify instance | Method `&mut self` | `player.add_score(10)` |
| Transform/consume instance | Method `self` | `player.into_name()` |
| Chain operations | Method `self -> Self` | `builder.a().b().c()` |
| Utility across types | Free Function | `std::mem::swap()` |
| Module-level API | Free Function | `crypto::hash()` |
| Generic operation | Free Function | `serialize::<T>()` |

## Struct Tuple

### Definition

A tuple struct is a named struct with unnamed fields, accessed by position (`.0`, `.1`, etc.) instead of by name.

```rust
// Tuple struct - fields by position
struct Point(i32, i32);

// Named struct - fields by name
struct Point { x: i32, y: i32 }
```

### Comparison: Tuple vs Tuple Struct vs Named Struct

| Aspect | Tuple | Tuple Struct | Named Struct |
|--------|-------|--------------|--------------|
| Has type name | No | Yes | Yes |
| Fields have names | No | No | Yes |
| Access fields | `.0`, `.1` | `.0`, `.1` | `.x`, `.y` |
| Type identity | Structural | Nominal | Nominal |

### Syntax

```rust
// Define
struct Point(i32, i32);
struct UserId(String);
struct Color(u8, u8, u8);

// Create
let p = Point(10, 20);
let id = UserId("abc".into());
let red = Color(255, 0, 0);

// Access
let x = p.0;
let y = p.1;

// Destructure
let Point(x, y) = p;
let UserId(value) = id;
let Color(r, g, b) = red;
```

### Destructuring in Function Parameters

```rust
struct Path<T>(T);

// Without destructuring
fn handler(path: Path<String>) {
    let value = path.0;  // Access with .0
}

// With destructuring
fn handler(Path(value): Path<String>) {
    // value is extracted directly
}
```

This is the pattern Axum uses for extractors:

```rust
async fn get_user(Path(user_id): Path<String>) -> String {
    format!("User: {}", user_id)
}
```


### When to Use Tuple Struct

#### 1. Wrapper Types (Newtype Pattern)

```rust
struct UserId(String);
struct PostId(String);

fn get_user(id: UserId) { }
fn get_post(id: PostId) { }

let user_id = UserId("abc".into());
let post_id = PostId("xyz".into());

get_user(user_id);   // OK
get_user(post_id);   // ERROR! Type safety prevents mixing
```

#### 2. Unit Conversion Safety

```rust
struct Meters(f64);
struct Feet(f64);

fn area(length: Meters, width: Meters) -> f64 {
    length.0 * width.0
}

let length = Meters(10.0);
let width = Feet(5.0);

area(length, width);  // ERROR! Can't mix units
```

#### 3. Single-Value Wrappers

```rust
// Axum extractors
struct Path<T>(pub T);
struct Json<T>(pub T);
struct Query<T>(pub T);
```

### When NOT to Use Tuple Struct

#### Many Fields (Use Named Struct)

```rust
// Bad - what is each field?
struct User(String, String, String, bool);
let user = User("123".into(), "alice".into(), "a@b.com".into(), true);

// Good - self-documenting
struct User {
    id: String,
    username: String,
    email: String,
    is_active: bool,
}
```

#### Confusable Fields (Use Named Struct)

```rust
// Bad - which is from, which is to?
struct Transfer(String, String, f64);

// Good - clear meaning
struct Transfer {
    from_account: String,
    to_account: String,
    amount: f64,
}
```

### Field Visibility

```rust
pub struct Public(pub i32, pub i32);     // Both fields public
pub struct Private(i32, i32);             // Both fields private
pub struct Mixed(pub String, i32);        // First public, second private
```

### Memory Layout

Tuple struct and named struct have identical memory layout:

```rust
struct PointTuple(i32, i32);
struct PointNamed { x: i32, y: i32 }

// Both in memory:
// ┌─────────┬─────────┐
// │  i32    │  i32    │
// │ (0/x)   │ (1/y)   │
// └─────────┴─────────┘
```

### Decision Guide

```
One field + need type safety?
  → Tuple Struct: struct Wrapper(T);

Two fields + meaning obvious?
  → Tuple Struct OK: struct Point(i32, i32);

Two fields + meaning unclear?
  → Named Struct: struct Point { x: i32, y: i32 }

Three+ fields?
  → Almost always Named Struct
```

### Summary

| Use | Example |
|-----|---------|
| Type-safe wrapper | `struct UserId(String);` |
| Unit safety | `struct Meters(f64);` |
| Extractor pattern | `struct Path<T>(pub T);` |
| Simple pair with clear meaning | `struct Point(i32, i32);` |
