# WAL (Write Ahead Log)

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

??? "Expand to show ACID visualized schema"

      ![pic1](../../assets/database/ACID)

1. Durability Guarantee:

    - Changes logged in the WAL are persistent even if the system fails before they are applied to the main data.

### How WAL Works

1. Log First:

    - When a transaction or write operation occurs, the changes are written to the WAL first.

2. Apply Changes:

    - After the changes are safely logged, they are applied to the main database or data store.

3. Checkpointing:

    - Periodically, the system flushes the accumulated changes from the WAL to the main dataset and marks those changes as committed in the WAL.

4. Truncation:

    - Older parts of the WAL that are no longer needed (because their changes are safely written to the dataset) are truncated to save space.

### Applications of WAL

1. Databases (e.g., PostgreSQL, SQLite):

    - Ensures transaction durability and helps recover the database to its last consistent state.

2. Distributed Logging Systems (e.g., Loki, Kafka):

    - Records logs or data changes sequentially to ensure recoverability and consistency.

3. File Systems (e.g., EXT4):

    - Tracks file system metadata changes to prevent corruption during sudden power loss or crashes.

### Advantages of WAL

- Faster writes due to sequential logging.
- Reliable recovery from crashes.
- Guarantees data consistency and durability.

### Disadvantages of WAL

- Additional disk space for the log.
- Slight overhead from maintaining the log.

### Example

Insert a Row into a Table

#### PostgreSQL

```sql
BEGIN;
INSERT INTO users (id, name, email) VALUES (1, 'Alice', 'alice@example.com');
COMMIT;
```

#### WAL

```yaml
WAL Record:
    LSN: 0/163B6F8
    Transaction ID: 1234
    Operation: INSERT
    Table: users
    Data: (1, 'Alice', 'alice@example.com')
```

#### Loki Log

```yaml
WAL Entry:
    Stream ID: 3f1aabc9-2bda-4e75-8bf1-2dddcdf75e8b
    Labels: { job="promtail", instance="node-1" }
    Timestamp: 2024-12-09T12:00:00Z
    Log Line: "This is a sample log message"
```
