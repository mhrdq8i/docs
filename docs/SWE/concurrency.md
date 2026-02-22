# Concurrency 

**Concurrency** vs **Async** vs **Parallelism**

Overview

This document explains the conceptual and practical differences between:

- **Concurrency**
- **Asynchronous programming (Async)**
- **Parallelism**


These terms are often confused, but they describe different aspects of how programs execute tasks.


## 1. Concurrency

**Definition**

Concurrency is a system property.

It means:

> The ability of a system to manage multiple tasks during overlapping time periods.

Concurrency does not require tasks to execute at the exact same moment.

Instead, it means:

- Multiple tasks can make progress.
- The system can switch between tasks.
- No task blocks overall progress unnecessarily.

---

**Important Clarification**

Concurrency is a concept, not an implementation technique.

It can be implemented using:

- Multi-threading
- Multi-processing
- Async/event loops
- Actor model
- Green threads
- Coroutines
- Runtime schedulers

---

**Example (Single-Core CPU)**

Even on a single-core CPU:

```bash
Task A → executes a bit
Task B → executes a bit
Task C → executes a bit
Switch back to Task A
```

Tasks appear to run simultaneously, but the CPU is switching between them.

This is concurrency without parallelism.

## 2. Asynchronous Programming (Async)

**Definition**

Async is an implementation strategy for concurrency.

Its main principle:

> Do not block a thread while waiting for I/O.

Examples of I/O operations:

- Network requests
- File reads/writes
- Database queries
- External API calls

---

**Blocking vs Async**

=== "Blocking Model"

    ```bash
    Task A → waits for network
    Thread is blocked
    CPU may sit idle
    ```

=== "Async Model"

    ```bash
    Task A → awaits network
    Thread becomes free
    Task B executes
    ```

Async avoids wasting thread time during I/O waits.

---

**Key Idea**

Async focuses on:
- Non-blocking behavior
- Efficient handling of I/O-bound workloads
- Event-driven scheduling

---

**Important Clarification**

Async does NOT necessarily mean:

- Single-threaded
- Parallel
- Faster for CPU-heavy work


It only means:

> Non-blocking task coordination.

## 3. Parallelism

**Definition**

Parallelism means executing multiple tasks at the exact same time.

This requires:

- Multiple CPU cores
- Or multiple processors


Example:

```bash
Core 1 → Task A
Core 2 → Task B
Core 3 → Task C
```

Tasks are physically executing simultaneously.


## 4. Core Differences

| Concept	| What It Is	| Focus	| Requires Multiple Cores? |
| - | - | - | - |
| Concurrency	| System capability	| Managing multiple tasks	| No |
| Async	| Implementation strategy	| Non-blocking execution	| No |
| Parallelism	| Execution model	| Simultaneous execution	| Yes |


## 5. Relationship Between Them

=== "Concurrency"

    ```bash
     Concurrency
      ├── Async (non-blocking, event-driven)
      ├── Multi-threaded concurrency
      └── Multi-process concurrency
    ```

=== "Parallelism"

    ```bash
      Parallelism
        └── True simultaneous execution on multiple cores
    ```


## 6. Deep Conceptual Differences

**Concurrency is about structure**

It answers:

> Can multiple tasks make progress?

It is about program organization and system capability.

---

**Async is about scheduling behavior**

It answers:

> What happens when a task must wait?

Async says:

- Don’t block.
- Yield control.
- Let something else run.

---

**Parallelism is about hardware execution**

It answers:

> Are tasks literally running at the same time?


## 7. Critical Distinction

A system can be:

**Concurrent but NOT Async**

Multi-threaded blocking example:

```bash
Thread 1 → Task A (blocked on I/O)
Thread 2 → Task B
Thread 3 → Task C
```

This is concurrent. But Thread 1 is still blocked.

---

**Async but NOT Parallel**

Single-threaded event loop:

```bash
Thread 1
  ↳ Task A (await)
  ↳ Task B
  ↳ Task C
```

This is concurrent and async. But not parallel.

---

Concurrent AND Parallel

Multi-core system:

```bash
Core 1 → Task A
Core 2 → Task B
Core 3 → Task C
```

Tasks run simultaneously and independently.


## 8. CPU-Bound vs I/O-Bound

**Async is ideal for:**

- I/O-bound workloads
- High-latency network operations
- Servers handling many connections

**Parallelism is ideal for:**

- CPU-bound workloads
 Heavy computation
- Hashing
- Compression
- Cryptography
- Data processing

Async does not speed up CPU-heavy code.

Parallelism does.


## 9. Precise Engineering Definitions

```bash
Concurrency = the ability to make progress on multiple tasks.
Async = non-blocking coordination of tasks.
Parallelism = simultaneous execution on multiple processors.
```


## 10. Common Misconceptions

❌ Async means "running at the same time"
✔ No — it means "not blocking."

❌ Concurrency requires multiple cores
✔ No — it can work on a single core.

❌ Async is always faster
✔ Only for I/O-bound workloads.

❌ Parallelism and concurrency are the same
✔ Parallelism is a subset of concurrency.


## 11. Final Mental Model

Think of it this way:

Concurrency → Dealing with many things.

Async → Don’t wait idly.

Parallelism → Doing many things at the same time.


## 12. Practical Guidance

When designing a system:

- Use async to handle many I/O operations efficiently.
- Use parallelism for heavy CPU computation.
- Use concurrency as the architectural principle that allows both.
