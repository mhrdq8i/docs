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

#### Impr

- **State Changes:** Programs are sequences of statements that modify the program's state.
- **Control Flow:** Uses loops, conditionals, and explicit instructions to control execution.
- **Focus on "How":** Describes the exact steps to solve a problem.
- **Examples:** C, Java, Python (when written imperatively), and assembly language.

#### Dec

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

## CPU Cache Layers

### What is difference between CPU layers caches?

In modern CPUs, cache memory plays a crucial role in bridging the speed gap between the CPU and main memory (RAM). Cache memory is organized into multiple levels, typically referred to as **L1**, **L2**, and **L3** caches. Each level of cache serves a specific purpose and has distinct characteristics in terms of size, speed, and proximity to the CPU cores. Here's a breakdown of the differences between these cache layers:

### 1. **L1 Cache (Level 1 Cache)**

- **Proximity**: The L1 cache is the closest cache to the CPU core.
- **Speed**: It is the fastest cache, with access times typically in the range of 1-2 clock cycles.
- **Size**: The L1 cache is the smallest in size, usually ranging from **8 KB to 64 KB** per core.
- **Structure**: The L1 cache is often split into two parts:
  - **L1 Instruction Cache (L1-I)**: Stores instructions that the CPU needs to execute.
  - **L1 Data Cache (L1-D)**: Stores data that the CPU is working on.
- **Purpose**: The L1 cache is designed for ultra-fast access to frequently used instructions and data.

### 2. **L2 Cache (Level 2 Cache)**

- **Proximity**: The L2 cache is located further from the CPU core than the L1 cache but still relatively close.
- **Speed**: It is slower than the L1 cache but still very fast, with access times typically in the range of **3-10 clock cycles**.
- **Size**: The L2 cache is larger than the L1 cache, usually ranging from **256 KB to 8 MB** per core.
- **Structure**: Unlike the L1 cache, the L2 cache is generally unified, meaning it stores both instructions and data.
- **Purpose**: The L2 cache acts as a secondary buffer for the L1 cache. If the CPU doesn't find the required data in the L1 cache, it checks the L2 cache next. The L2 cache is larger but slightly slower than the L1 cache, so it can store more data at the cost of slightly higher latency.

### 3. **L3 Cache (Level 3 Cache)**

- **Proximity**: The L3 cache is the farthest from the CPU core compared to L1 and L2 caches. In many modern CPUs, the L3 cache is shared among all cores.
- **Speed**: It is slower than both the L1 and L2 caches, with access times typically in the range of **20-50 clock cycles**.
- **Size**: The L3 cache is much larger than the L1 and L2 caches, often ranging from **4 MB to 64 MB** or more, depending on the CPU architecture.
- **Structure**: Like the L2 cache, the L3 cache is also unified, storing both instructions and data.
- **Purpose**: The L3 cache serves as a shared resource for all cores in a multi-core processor. It acts as a last-level cache before accessing the slower main memory (RAM). If the CPU doesn't find the required data in the L1 or L2 caches, it checks the L3 cache before going to RAM.

### Key Differences Between L1, L2, and L3 Caches

| Feature               | **L1 Cache**                       | **L2 Cache**                | **L3 Cache**                  |
| --------------------- | ---------------------------------- | --------------------------- | ----------------------------- |
| **Proximity to Core** | Closest                            | Closer than L3              | Farther than L1 and L2        |
| **Speed**             | Fastest (~1-2 cycles)              | Faster (~3-10 cycles)       | Slower (~20-50 cycles)        |
| **Size**              | Smallest (8 KB - 64 KB/core)       | Medium (256 KB - 8 MB/core) | Largest (4 MB - 64 MB/shared) |
| **Structure**         | Split (L1-I & L1-D)                | Unified                     | Unified                       |
| **Purpose**           | Ultra-fast access to critical data | Secondary buffer for L1     | Shared buffer for all cores   |

### Why Multiple Levels of Cache?

The primary reason for having multiple levels of cache is to balance **speed**, **size**, and **cost**. As you move from L1 to L3:

- **Speed decreases** (slower access times).
- **Size increases** (more storage capacity).
- **Cost per byte decreases** (larger caches are cheaper to produce).

The idea is to have small, fast caches (L1) for the most frequently accessed data and instructions, while larger, slower caches (L2, L3) handle less frequently accessed data. This hierarchical structure helps improve overall system performance by reducing the number of times the CPU has to access the much slower main memory (RAM).

### Summary

- **L1 Cache**: Smallest, fastest, and closest to the CPU core. Split into instruction and data caches.
- **L2 Cache**: Larger than L1, slightly slower, and unified (stores both instructions and data).
- **L3 Cache**: Largest, slowest, and shared among all cores. Acts as a final buffer before accessing main memory.

This multi-level caching strategy ensures that the CPU can quickly access frequently used data and instructions, minimizing delays caused by accessing slower main memory.
