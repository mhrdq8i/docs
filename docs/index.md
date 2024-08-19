# [DocStack](index.md)

Welcome to my _Documentation_ Platform

- [Code](Programming/index.md)
- [Database](Database/index.md)
- [DevOps](Operation/index.md)
- [Operation System](OS/index.md)
- [Memory Management](MMU/index.md)
- [LPIC Syllabus](LPIC/index.md)
- [Networking](Network/index.md)

=== "Regular font"

    ``` css
    :root {
      --md-text-font: "<font>"; /* (1)! */
    }
    ```

    1.  Always define fonts through CSS variables and not `font-family`, as
        this would disable the system font fallback.

=== "Monospaced font"

    ``` css
    :root {
      --md-code-font: "<font>";
    }
    ```
