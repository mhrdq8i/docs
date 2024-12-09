
# Data Base

All configuration and documentation about `SQL` and `NoSQL` Databases.

## WAL (Write Ahead Log)

The Write Ahead Log (WAL) is a data logging mechanism used in databases, storage systems, and other applications to ensure durability and consistency in the event of a system crash or failure. It works by recording changes to a log before applying those changes to the main dataset. This guarantees that all modifications can be recovered and reapplied after a crash.

### Key Characteristics of WAL

1. Sequential Logging:

    - Changes are written to the log sequentially, which is faster than random writes to the main dataset.
    - The WAL is typically stored on disk to ensure persistence.

2. Crash Recovery:

    - After a crash, the WAL can be replayed to restore the system to its last consistent state.
    - It prevents data loss by ensuring that uncommitted changes are logged before being applied.

3. Atomicity and Consistency:

    - The WAL ensures that operations are atomic (all or nothing) and consistent, adhering to ACID principles.

4. Durability Guarantee:

    - Changes logged in the WAL are persistent even if the system fails before they are applied to the main data.
