# SQL Alchemy

The table of the primary object states in an ORM (e.g. SQLAlchemy)

| State          | Description                                                                                                                                                             |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Transient**  | A newly created instance that is not yet attached to a Session and has no corresponding row in the database.                                                            |
| **Pending**    | An instance that has been added to the Session (via `add()`) but not yet flushed—an `INSERT` is pending.                                                                |
| **Persistent** | An instance that is attached to the Session and represents a row that exists (or will be inserted) in the database; changes are tracked and flushed automatically.      |
| **Detached**   | An instance that was once persistent but has been removed from its Session; further changes are not tracked.                                                            |
| **Expired**    | A persistent instance whose state has been marked “expired” (e.g. by `expire()` or after a flush), so its attributes will be reloaded from the database on next access. |
