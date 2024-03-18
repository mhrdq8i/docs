# Memory Management Unit (MMU)

## GeeksForGeeks links

### [Memory Management in Operating System](https://www.geeksforgeeks.org/memory-management-in-operating-system/)

### [Memory Layout of C Programs](https://www.geeksforgeeks.org/memory-layout-of-c-program/)

### [Memory Segmentation in 8086 Microprocessor](https://www.geeksforgeeks.org/memory-segmentation-8086-microprocessor/)

## Other Source Links

### [C Memory Division Text (code segment), Data and BSS](https://wahyu-ehs.medium.com/c-memory-division-text-code-segment-data-and-bss-ef7d76831d8b)

### [Memory Management on C programming](https://wahyu-ehs.medium.com/memory-management-on-c-programming-ce30135cfbcb)

### [Memory Layout in C](https://www.javatpoint.com/memory-layout-in-c)

<img src="../../../../../assets/os/drsrv/gnu_linux/docs/arch/memory-layout-in-c.png" width="25%" height="25%" >

## Memory Segmentation Schema

```bash
            +------------------+
            |                  |
    ⌈       |  Code Segment    |    Binary of source code
 Static     |                  |
 Memory     +------------------+
 Layout     |                  |
    ⌊       |  Data Segment    |    Static, Global variables & Constants
            |                  |
            +------------------+
            |                  |
    ⌈       |  Heap Segment    |    Dynamic variable size allocation
 Dynamic    |                  |
 Memory     +------------------+
 Layout     |                  |
    ⌊       |  Stack Segment   |    Local variables & functions
            |                  |
            +------------------+
```

## Initialized(data), Uninitialized(bss) & Read-Only, Read-Write Section

```bash
+--------------------+
|   Code Segment     |
|                    |
|   Instructions     |
|   of the Program   |
|                    |
+--------------------+
|   Data Segment     |
|                    |
| Initialized Data   |   <-- .data section / Modifiable Data (R.W.)
| (static, globals,  |
|          e.g.)     |
| Constants          |   <-- .rodata section (or within .data)
|                    |
+ -   -   -   -   -  +
|                    |
| Uninitialized      |   <-- .bss section / Zeroed Data
|   Data (zeroed)    |
| (globals without   |
|  explicit values)  |
|                    |
+--------------------+
|                    |
|   Heap Segment     |
|                    |
|  (Dynamic Memory)  |
|                    |
+--------------------+
|   Stack Segment    |
|                    |
|   Local Variables  |
|   and Functions    |
|                    |
+--------------------+
```

## Share Memory Structure For a Thread

```bash
+--------------------+
|    ...             |
|    Code     ┑      |
|    Data  section   |
|    Heap     ┙      |
|    as same as      |
|    above           |
|    ...             |
+--------------------+
|   Stack (Thread 1) |      Share the stack segment
|                    |
|   Local Variables  |
|   and Functions    |
|                    |
+--------------------+
|   Stack (Thread 2) |
|                    |
|   Local Variables  |
|   and Functions    |
|                    |
+--------------------+
|   Stack (Thread 3) |
|                    |
|   Local Variables  |
|   and Functions    |
|                    |
+--------------------+
```
