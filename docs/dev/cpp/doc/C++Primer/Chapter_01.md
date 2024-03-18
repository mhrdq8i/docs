# Getting Started with C++

**C++:**

- C++ blends the C language with support for `object-oriented programming` and `generic programming`.

- `encapsulation`, `data hiding`, `polymorphism` and `inheritance`; these are the key concepts of `OOP`.

- C++ joins three separate programming categories: the `procedural language`, represented by `C`; the `object-oriented language`, represented by the `class enhancements C++` adds to `C`;and `generic programming`, supported by `C++ templates`.

- If you don’t know C, you have to master the `C components`, the `OOP components`,and the `generic components` to learn C++.

- Special programs called `compilers` translate a high-level language to the internal language of a particular computer.

**C Programming Philosophy:**

- computer languages deal with two concepts `data` and `algorithms`.
  - The `data` constitutes the information a program uses and processes.
  - The `algorithms` are the methods the program uses.

**C Programming Philosophy:**

- C is a `procedural language`.That means it `emphasizes the algorithm side of programming`.
  - `data` + `algorithm` = `program` [watch this photo](../../assets/data-algorithm=program.png)
  - With C, the idea is to `break a large program into smaller`, more manageable tasks.
  - C’s design facilitates this approach, encouraging you to develop program units called `functions` to `represent individual task modules`.

**The C++ Shift Object-Oriented Programming:**

- Although the principles of structured programming improved the `clarity`, `reliability`,and `ease of maintenance of programs`, large-scale programming still remains a challenge. `OOP` brings a new approach to that challenge.
- Unlike procedural programming, which _emphasizes `algorithms`_, _OOP emphasizes the `data`_.
- The idea is to `design data forms that correspond to the essential features of a problem`.
- In C++,a `class` is a specification describing such a new data form,and an `object` is a particular data structure constructed according to that plan.
- In general,a `class` defines what data is used to represent an `object` and the operations that can be performed on that data.
- The process of going from a `lower level` of organization, such as `classes`, to a `higher level`, such as `program design`, is called _`bottom-up`_ programming.

- **OOP facilitates:**

  - `Information hiding`(encapsulation) safeguards data from improper access
  - `Polymorphism` lets you create multiple definitions for `operators` and `functions`,with the programming context determining which definition is used.
  - `Inheritance` lets you derive new classes from old ones.

- **C++ and Generic Programming:**

  - whereas OOP emphasizes the `data aspect of programming`, generic programming emphasizes `independence from a particular data type`.

  - `OOP` is a tool for `managing large projects`, whereas `generic programming` provides tools for `performing common tasks`, such as sorting data or merging lists.

  - The term generic refers to code that is `type independent`.

- **Portability and Standards:**

  - If you can `recompile` the program `without making changes` and it runs without a hitch, we say the program is `portable`.

  - Linking combines `your object code` with `object code for the functions you use` and with `some standard startup code` to pro-duce a runtime version of your program.The file containing this final product is called the [`executable` code](../../assets/programmin-steps.png).

- **Compilation and Linking:**

  - Originally, Stroustrup implemented C++ with a `C++-to-C compiler` program instead of developing a direct `C++-to-object` code compiler.This program, called `cfront` (for C front end), translated C++ source code to C source code, which could then be compiled by a standard C compile.
  - As C++ has developed and grown in popularity, more and more implementers have turned to creating C++ compilers that generate `object code directly from C++ source code`.

- **Linux Compiling and Linking:**
  - Linux systems most commonly use g++, the `GNU C++ compiler` from the Free Software Foundation.
    - g++ spiffy.cxx
  - Some versions might require that you link in the C++ library:
    - g++ spiffy.cxx -lg++
  - To compile multiple source files, you just list them all in the command line:
    - g++ my.cxx precious.cxx
  - compile with custom object file name:
    - g++ my.cxx precious.o
