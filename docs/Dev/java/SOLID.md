# SOLID Principles

## The SOLID Principles of Object-Oriented Design

In software engineering, **SOLID** is a mnemonic acronym for five design principles intended to make software designs more understandable, flexible, and maintainable. These principles, introduced by Robert C. Martin (also known as "Uncle Bob"), guide developers in writing clean and scalable code. They are:

## 1. 🎯 Single Responsibility Principle (SRP)

This principle states that **a class should have only one responsibility and only one reason to change.** In simpler terms, every class should do just one specific job well.

- **Why it's important:** When a class takes on multiple tasks, a change in one of those tasks increases the risk of introducing bugs into the others. Separating responsibilities makes the code more focused, easier to understand, and more testable.

- **Simple Example:** Consider a class that both holds an employee's data and is responsible for saving that data to a database. According to the SRP, this is incorrect. There should be two separate classes: an `Employee` class to hold the data, and an `EmployeeRepository` class to manage database operations (like saving, editing, and deleting).

## 2. 👐 Open-Closed Principle (OCP)

This is the principle you originally asked about. It states that **software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.**

This definition might seem contradictory at first, but its core concept is to design a system where new functionality can be added without changing existing, tested code. This approach significantly enhances the software's stability, maintainability, and flexibility.

- **Why it's important:** Modifying existing, working code always carries risk. By adding new code instead of changing old code, this risk is minimized. It leads to more maintainable code, better scalability, and promotes loose coupling between components.

- **Simple Example:** Imagine a `SalaryCalculator` class that calculates salaries for different employee types like "FullTime" and "PartTime" using `if-else` statements. If a new employee type, like "Contractor," is needed, you would have to modify the `SalaryCalculator` class. This violates the OCP.

  **The correct approach** is to use an `Employee` interface with a `calculateSalary()` method. Each employee type (`FullTimeEmployee`, `PartTimeEmployee`) would implement this interface. The `SalaryCalculator` would simply call the `calculateSalary()` method on any object that is of type `Employee`. Now, to add a new "Contractor" type, you just create a new `ContractorEmployee` class that implements the `Employee` interface. The `SalaryCalculator` class remains **closed** for modification, but the system is **open** to extension with new employee types.

## 3. ↔️ Liskov Substitution Principle (LSP)

Introduced by Barbara Liskov, this principle states that **objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program.** This means a subclass must not violate the behaviors and rules of its parent class.

- **Why it's important:** This principle ensures that inheritance is used correctly. If a child class cannot be substituted for its parent class, it implies that your inheritance hierarchy is not logical, which can lead to unexpected behavior and bugs.

- **Simple Example:** Imagine you have a `Bird` class with a `fly()` method. Now, you create a `Penguin` class that inherits from `Bird`. Since penguins cannot fly, implementing the `fly()` method in the `Penguin` class doesn't make sense. This is a clear violation of the LSP. A better solution would be to create a more specific interface, like `FlyingBird`, for birds that can fly.

## 4. 🧩 Interface Segregation Principle (ISP)

This principle emphasizes that **clients should not be forced to depend on interfaces they do not use.** Instead of creating large, all-in-one "fat" interfaces, you should break them down into smaller, more specific ones.

- **Why it's important:** Large interfaces force classes to implement methods they don't need. This leads to empty or unnecessary code and creates unwanted dependencies within the system.

- **Simple Example:** Consider an interface called `IWorker` with `work()` and `eat()` methods. Now, imagine you have a `RobotWorker` that works but doesn't eat. Forcing the `RobotWorker` class to implement the `eat()` method violates the ISP. The correct solution is to split `IWorker` into two separate interfaces: `IWorkable` and `IEatable`. This way, a `HumanWorker` class can implement both, while the `RobotWorker` class only implements `IWorkable`.

## 5. 🔄 Dependency Inversion Principle (DIP)

This principle states two things:
A. **High-level modules should not depend on low-level modules. Both should depend on abstractions.**
B. **Abstractions should not depend on details. Details should depend on abstractions.**

- **Why it's important:** This principle makes the system highly flexible and scalable by reducing direct dependencies between components. By depending on interfaces (abstractions) instead of concrete classes (details), different implementations can be swapped without changing the high-level code. This principle is the foundation of well-known patterns like **Dependency Injection**.

- **Simple Example:** Imagine a `PasswordReminder` class that directly uses a `MySQLConnection` class to connect to a database. This design makes the `PasswordReminder` (high-level module) dependent on `MySQLConnection` (low-level module). If you want to change the database, you must modify the `PasswordReminder`'s code. According to DIP, you should create a `DBConnectionInterface`. The `MySQLConnection` class would then implement this interface, and the `PasswordReminder` class would depend on the interface, not the concrete class. This way, you can easily substitute any other database connection (e.g., `PostgreSQLConnection`) without any changes to the reminder logic.
