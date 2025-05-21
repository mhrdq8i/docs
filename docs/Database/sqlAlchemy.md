# SQL Alchemy

## Connection Pooling

A connection pool is a standard technique used to **maintain long running connections in memory** for efficient re-use, as well as to provide management for the total number of connections an application might use simultaneously.

Particularly for server-side web applications, a connection pool is the standard way to maintain a “pool” of active database connections in memory which are reused across requests.

SQLAlchemy includes several connection pool implementations which integrate with the Engine. They can also be used directly for applications that want to add pooling to an otherwise plain DBAPI approach.

## Session & Context

Session

### 🔹 What is a `Session` in SQLAlchemy?

In SQLAlchemy, a `Session` is the **central object** used to:

- Manage persistence operations (insert, update, delete).
- Track changes to objects.
- Communicate with the database.

Think of it as a **workspace** where you:

- Load objects (via queries),
- Add or modify them,
- And finally commit or rollback those changes.

### Key Responsibilities of `Session`

- Manages the identity map (ensures one object per row in memory).
- Tracks object states: transient, pending, persistent, detached.
- Bundles changes and sends them to the database in transactions.

### Example

```python
session = Session(engine)

author = Author(name="George Orwell")
session.add(author)

session.commit()  # saves the new author to the DB
```

Context

### 🔹 What is a `Context`?

In SQLAlchemy, the term **“context”** isn't a specific class or function, but rather refers to the **environment** or **execution scope** where objects are tracked and managed.
In most cases, this **context is provided by the Session**.

So, when we say an object is “in the context,” we usually mean:

- It’s being tracked by a Session,
- Its changes will be flushed and committed through that Session,
- It’s part of the identity map.

#### Technically

- There is no separate “Context” object in SQLAlchemy.
- The `Session` **is** the context — it handles object state tracking, persistence, and database interaction.

## ✅ Summary

| Concept   | Description                                                                                              |
| --------- | -------------------------------------------------------------------------------------------------------- |
| `Session` | The main SQLAlchemy object used for querying, persisting, and managing data.                             |
| `Context` | A general term meaning the environment where object states are tracked — provided by the Session itself. |

---

### 💡 Analogy

Think of the `Session` as your **open editing workspace** (like a Photoshop project file). The `Context` is everything in that workspace — the current image layers, settings, and history. But in SQLAlchemy, both ideas live inside the `Session`.

## 🔄 SQLAlchemy Session Lifecycle

The lifecycle of a SQLAlchemy `Session` typically looks like this:

```sql
1. Create a Session
   ↓
2. Add / query objects
   ↓
3. Modify objects
   ↓
4. Commit / Rollback
   ↓
5. Close session
```

```python
# 1. Create a Session
session = Session(engine)

# 2. Add or query
user = User(name="Alice")
session.add(user)

# 3. Modify
user.name = "Alice Smith"

# 4. Commit changes
session.commit()

# 5. Close session
session.close()
```

### 📦 Object States in SQLAlchemy

Each object in SQLAlchemy has one of the following **five states**:

| State          | Description                                                                                 | Example                                                         |
| -------------- | ------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| **Transient**  | Object exists in memory but is not added to a session and has no DB identity.               | `user = User(name="Alice")` (before `session.add(user)`)        |
| **Pending**    | Object is added to the session but not yet flushed (no INSERT yet).                         | After `session.add(user)` but before `session.commit()`         |
| **Persistent** | Object is attached to the session and exists in the database.                               | After flush or commit — `user` now has a primary key            |
| **Detached**   | Object was once persistent but is no longer attached to a session.                          | After `session.expunge(user)` or `session.close()`              |
| **Expired**    | Object is persistent but its attributes will reload from the DB on next access (lazy load). | After `session.expire(user)` or `expire_on_commit=True` session |

### 🔁 State Transitions Diagram

```sql
Transient
   │
   ├─> session.add(obj)
   ↓
Pending
   │
   ├─> session.flush() or commit()
   ↓
Persistent
   │
   ├─> session.expunge(obj) or close()
   ↓
Detached
   │
   ├─> session.add(obj) — re-attaches
   ↓
Persistent again
```

### 🔍 Code Snippets for States

```python
# Transient
user = User(name="Alice")

# Pending
session.add(user)

# Persistent
session.commit()

# Detached
session.close()  # or session.expunge(user)

# Expired
session = Session(engine, expire_on_commit=True)
user = session.query(User).first()
session.commit()
user.name  # triggers a SELECT again
```

??? "view in image"

      ![session_lifecycle](../assets/database/orm/session_lifecycle.png)
