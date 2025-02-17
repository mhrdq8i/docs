# Software Engineering

Concepts and Theories

## Bounding

### 1. CPU-bound Tasks

**Definition:** These tasks are limited by the processing power of the CPU. The performance of CPU-bound tasks is primarily determined by the speed and efficiency of the CPU.

**Characteristics:** High computational requirements.
Examples include complex calculations, data processing, and algorithms that require significant CPU cycles (e.g., video encoding, scientific simulations).

**Optimization:** To improve performance, you can use faster CPUs, optimize algorithms, or parallelize the workload across multiple cores.

### 2. Memory-bound Tasks

**Definition:** These tasks are limited by the amount of available memory (RAM) or the speed of memory access. The performance is constrained by how quickly data can be read from or written to memory.

**Characteristics:**
High memory usage or frequent memory access.
Examples include applications that require large datasets to be loaded into memory, such as databases or large-scale data processing tasks.

**Optimization:** To improve performance, you can increase the amount of RAM, optimize memory access patterns, or use data structures that minimize memory usage.

### 3. I/O-bound Tasks

**Definition:** These tasks are limited by the speed of input/output operations, such as reading from or writing to disk, or accessing files. The performance is constrained by how quickly data can be transferred to and from storage devices.

**Characteristics:** Frequent read/write operations or waiting for data from external devices.
Examples include file transfers, database queries, and applications that read or write large files.

**Optimization:** To improve performance, you can use faster storage solutions (e.g., SSDs instead of HDDs), optimize I/O operations, or implement caching strategies.

### 4. Network-bound Tasks

**Definition:** These tasks are limited by the speed and latency of network connections. The performance is constrained by how quickly data can be sent or received over a network.

**Characteristics:** High dependency on network bandwidth and latency.
Examples include web applications, cloud services, and any task that involves transferring data over the internet.

**Optimization:** To improve performance, you can increase network bandwidth, reduce latency, optimize data transfer protocols, or implement data compression.

### Summary

- **CPU-bound:** Limited by CPU processing power.
- **Memory-bound:** Limited by available memory or memory access speed.
- **I/O-bound:** Limited by input/output operations (disk, file access).
- **Network-bound:** Limited by network speed and latency.

---

## Declarative and Imperative

### Imperative

Imperative programming is about how to do something. It gives the computer step-by-step instructions. Like telling someone exactly how to make a sandwich: take bread, add butter, then jam, etc.

### Declarative

Declarative is more about what you want, not how. It's like ordering a sandwich by just saying you want a peanut butter and jelly sandwich, without specifying each step. SQL is a good example here because you just say what data you want, not how to fetch it.

### Key Characteristics

#### Imperative

- **State Changes:** Programs are sequences of statements that modify the program's state.
- **Control Flow:** Uses loops, conditionals, and explicit instructions to control execution.
- **Focus on "How":** Describes the exact steps to solve a problem.
- **Examples:** C, Java, Python (when written imperatively), and assembly language.

#### Declarative

- **No Explicit State Changes:** The program describes the desired outcome, not the steps to achieve it.
- **Focus on "What":** Specifies what needs to be done, not how.
- **Higher Abstraction:** Often uses expressions, constraints, or rules.
- **Examples:** SQL (for databases), HTML (for web page structure), functional programming languages (e.g., Haskell), and logic programming (e.g., Prolog).

### Difference

So the key difference is the level of detail in the instructions. **Imperative focuses on the process** and **declarative on the outcome**.

### Examples

Imperative examples could be languages like C, Python (with loops and conditionals), while declarative includes SQL, HTML.

Also, state management. In imperative, you manage state changes explicitly. In declarative, the system handles state based on declarations.

### Functional programming vs procedural

Functional is more declarative, right? Because you describe what to compute without mutable state.
