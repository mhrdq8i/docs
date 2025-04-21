
# Common Features

## Database Normalization

Database Normalization is a process of organizing database tables to minimize data redundancy and improve data integrity. Let me explain the key concepts and normal forms:

### First Normal Form (1NF)

- Each table cell should contain a single value (atomic)
- Each record needs to be unique
- Each column should have a single type of data

### Second Normal Form (2NF)

- Must satisfy 1NF
- All non-key attributes must fully depend on the primary key
- No partial dependencies allowed

### Third Normal Form (3NF)

- Must satisfy 2NF
- No transitive dependencies between non-key attributes
- Every non-key attribute should depend only on the primary key

### Examples

#### Before normalization

```sql
Customer_Orders
ID | Customer_Name | Customer_Address | Order_Date | Product | Category | Price
```

#### After normalization

```sql
Customers
Customer_ID | Name | Address

Products
Product_ID | Name | Category | Price

Orders
Order_ID | Customer_ID | Product_ID | Order_Date
```

### Benefits of normalization

- Reduces data redundancy - information is stored only once
- Ensures data consistency - updates affect only one record
- Makes the database more flexible for future changes
- Improves query performance in many cases

### However, there are times when denormalization might be preferred

- When read performance is more critical than write performance
- In data warehousing scenarios
- When the data structure is relatively stable and won't change often

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
  Labels: {job="promtail", instance="node-1"}
  Timestamp: 2024-12-09T12:00:00Z
  Log Line: "This is a sample log message"
```

## Database Scaling

Sequences

### 1. Query Optimization (First Priority)

```sql
-- Before optimization
SELECT * FROM users WHERE age > 25;

-- After optimization
SELECT id, name FROM users
WHERE age > 25
LIMIT 100;
```

### 2. Database Indexing

```sql
-- Add indexes for frequently queried columns
CREATE INDEX idx_user_age ON users(age);
CREATE INDEX idx_user_email ON users(email);

-- Composite index for multiple columns
CREATE INDEX idx_user_age_city ON users(age, city);
```

### 3. Caching Implementation

```python
# Example using Redis cache
def get_user(user_id):
    # Try cache first
    cached_user = redis_cache.get(f"user:{user_id}")
    if cached_user:
        return cached_user

    # If not in cache, get from DB and cache it
    user = database.query(f"SELECT * FROM users WHERE id = {user_id}")
    redis_cache.set(f"user:{user_id}", user, expire=3600)
    return user
```

### 4. Vertical Scaling (Scale Up)

- Increase CPU
- Add more RAM
- Upgrade to faster storage (SSD/NVMe)

```bash
Initial: 2 CPU, 4GB RAM, HDD
↓
Upgrade: 4 CPU, 8GB RAM, SSD
↓
Further: 8 CPU, 16GB RAM, NVMe
```

### 5. Database Partitioning

```sql
-- Example of date-based partitioning
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL
) PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025)
);
```

### 6. Read Replicas

```sql
Primary DB (Writes)
     ↓
   ↙  ↓  ↘
Replica1 Replica2 Replicas3 (Reads)
```

### 7. Horizontal Scaling (Sharding)

```sql
Shard 1: Users A-F
Shard 2: Users G-M
Shard 3: Users N-S
Shard 4: Users T-Z
```

### 8. Database Type Optimization

Right choice DB based on demand

```sql
Transactions → PostgreSQL/MySQL
Analytics → ClickHouse/Redshift
Caching → Redis
Document Storage → MongoDB
Graph Data → Neo4j
```

### 9. Microservices Split

```sql
Monolithic DB
     ↓
User DB | Order DB | Product DB
```

### 10. Geographic Distribution

```sql
US Region:
- Primary DB
- Read Replicas

EU Region:
- Primary DB
- Read Replicas

Asia Region:
- Primary DB
- Read Replicas
```

## Partitioning

### 1.Types of Partitioning

#### A. Range Partitioning

```sql
-- Partition by date range
CREATE TABLE sales (
    id INT,
    sale_date DATE,
    amount DECIMAL
) PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Partition by amount range
CREATE TABLE orders (
    order_id INT,
    amount DECIMAL
) PARTITION BY RANGE (amount) (
    PARTITION p_small VALUES LESS THAN (100),
    PARTITION p_medium VALUES LESS THAN (1000),
    PARTITION p_large VALUES LESS THAN (10000),
    PARTITION p_huge VALUES LESS THAN MAXVALUE
);
```

> ASCII Visualize

```sql
ALL SALES DATA
┌───────────────────┐
│     Database      │
└─────────┬─────────┘
          │
    ┌─────┴─────┬────────────┬────────────┐
    │           │            │            │
┌───▼───┐   ┌───▼───┐   ┌───▼───┐   ┌───▼───┐
│ 2022  │   │ 2023  │   │ 2024  │   │Future │
│ Sales │   │ Sales │   │ Sales │   │ Sales │
└───────┘   └───────┘   └───────┘   └───────┘
```

#### B. List Partitioning

```sql
-- Partition by region
CREATE TABLE customers (
    id INT,
    name VARCHAR(100),
    country VARCHAR(50)
) PARTITION BY LIST (country) (
    PARTITION p_europe VALUES IN ('France', 'Germany', 'Spain'),
    PARTITION p_asia VALUES IN ('China', 'Japan', 'India'),
    PARTITION p_americas VALUES IN ('USA', 'Canada', 'Brazil')
);
```

> ASCII Visualize

```sql
CUSTOMER DATA
     ┌──────────────────┐
     │    Database      │
     └────────┬─────────┘
              │
    ┌─────────┼─────────┐
    │         │         │
┌───▼───┐ ┌───▼───┐ ┌───▼───┐
│EUROPE │ │ ASIA  │ │ USA   │
│France │ │ China │ │ Texas │
│Spain  │ │ Japan │ │ NYC   │
│Italy  │ │ India │ │ LA    │
└───────┘ └───────┘ └───────┘
```

#### C. Hash Partitioning

```sql
-- Automatically distribute data across 4 partitions
CREATE TABLE users (
    id INT,
    email VARCHAR(100)
) PARTITION BY HASH(id) PARTITIONS 4;
```

> ASCII Visualize

```sql
USER DATA (Hash by ID)
┌─────────────────────────┐
│       Database          │
└────────────┬────────────┘
             │
     ┌───────┴──────┐
     │  Hash(ID)    │
     └───────┬──────┘
   ┌─────────┼─────────┐
   │         │         │
┌──▼───┐  ┌──▼───┐  ┌──▼───┐
│ P0   │  │ P1   │  │ P2   │
│ID%3=0│  │ID%3=1│  │ID%3=2│
└──────┘  └──────┘  └──────┘
```

### 2. Composite Partitioning (Combining Multiple Types)

```sql
-- Partition by year and then by month
CREATE TABLE transactions (
    id INT,
    trans_date DATE,
    amount DECIMAL
) PARTITION BY RANGE (YEAR(trans_date))
  SUBPARTITION BY HASH(MONTH(trans_date))
  SUBPARTITIONS 12 (
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025)
);
```

> ASCII Visualize

```sql

SALES DATABASE
        ┌──────────────────────────┐
        │         2023             │
        └───────────┬──────────────┘
                    │
    ┌───────────────┼───────────────┐
    │               │               │
┌───▼───┐       ┌───▼───┐       ┌───▼───┐
│ Q1    │       │ Q2    │       │ Q3    │
└──┬────┘       └──┬────┘       └──┬────┘
   │               │               │
   ├─Jan           ├─Apr           ├─Jul
   ├─Feb           ├─May           ├─Aug
   └─Mar           └─Jun           └─Sep
```

### 3. Partition Management

#### A. Adding New Partitions

```sql
-- Add new partition for next year
ALTER TABLE sales ADD PARTITION (
    PARTITION p_2025 VALUES LESS THAN (2026)
);
```

#### B. Removing Partitions

```sql
-- Remove old data partition
ALTER TABLE sales DROP PARTITION p_2022;
```

#### C. Reorganizing Partitions

```sql
-- Optimize/defragment a partition
ALTER TABLE sales REORGANIZE PARTITION p_2023;
```

### 4. Querying Partitioned Tables

#### A. Partition Pruning (Automatic)

```sql
-- Database will only scan relevant partitions
SELECT * FROM sales
WHERE sale_date BETWEEN '2023-01-01' AND '2023-12-31';
```

#### B. Partition Selection

```sql
-- Explicitly select partition
SELECT * FROM sales PARTITION (p_2023)
WHERE amount > 1000;
```

### 5. Best Practices

#### A. Sizing Guidelines

```sql
-- Keep partitions similarly sized
CREATE TABLE logs (
    id INT,
    log_date DATE,
    message TEXT
) PARTITION BY RANGE (UNIX_TIMESTAMP(log_date)) (
    PARTITION p1 VALUES LESS THAN (UNIX_TIMESTAMP('2023-04-01')),
    PARTITION p2 VALUES LESS THAN (UNIX_TIMESTAMP('2023-07-01')),
    PARTITION p3 VALUES LESS THAN (UNIX_TIMESTAMP('2023-10-01'))
);
```

### 6. Common Use Cases

#### A. Time-Based Data Management

```sql
-- Archiving old data
CREATE TABLE archive_sales
SELECT * FROM sales PARTITION (p_2022);
ALTER TABLE sales DROP PARTITION p_2022;
```

#### B. Geographic Data Distribution

```sql
-- Regional data access
CREATE TABLE user_data (
    id INT,
    region VARCHAR(50),
    data TEXT
) PARTITION BY LIST (region) (
    PARTITION p_us VALUES IN ('us-east', 'us-west'),
    PARTITION p_eu VALUES IN ('eu-central', 'eu-west'),
    PARTITION p_asia VALUES IN ('asia-east', 'asia-south')
);
```

> ASCII Visualize

```sql
Before Partitioning          After Partitioning
┌──────────────────┐    ┌─────────┐ ┌─────────┐
│ ░░░░░░░░░░░░░░░░ │    │ ░░░░░░░ │ │ ░░░░░░░ │
│ ░░░░░░░░░░░░░░░░ │    │ ░░░░░░░ │ │ ░░░░░░░ │
│ ░░░░░░░░░░░░░░░░ │ => │ ░░░░░░░ │ │ ░░░░░░░ │
│ ░░░░░░░░░░░░░░░░ │    └─────────┘ └─────────┘
└──────────────────┘    ┌─────────┐ ┌─────────┐
                        │ ░░░░░░░ │ │ ░░░░░░░ │
      Single Table      │ ░░░░░░░ │ │ ░░░░░░░ │
                        └─────────┘ └─────────┘
                         Partitioned Tables
```

### 7. Monitoring Partitions

```sql
-- View partition information
SELECT
    PARTITION_NAME,
    TABLE_ROWS,
    DATA_LENGTH,
    INDEX_LENGTH
FROM
    INFORMATION_SCHEMA.PARTITIONS
WHERE
    TABLE_NAME = 'sales';
```

> Query Flow in Partitioned Table:

```sql
Query: SELECT * FROM sales WHERE date = '2023-06-15'

┌─────────────┐
│   Query     │
└─────┬───────┘
      │
      ▼
┌─────────────┐    ┌───────────┐
│  Partition  │───→│ 2022 Data │ (Skip)
│  Manager    │    └───────────┘
└─────┬───────┘    ┌───────────┐
      │───────────→│ 2023 Data │ (Search)
      │            └───────────┘
      │            ┌───────────┐
      └───────────→│ 2024 Data │ (Skip)
                   └───────────┘
```

### Key Benefits

- Improved query performance
- Easier maintenance
- Better data lifecycle management
- Improved backup/recovery options
- Parallel query execution potential

### Common Pitfalls to Avoid

- Over-partitioning
- Wrong partition key selection
- Not planning for growth
- Ignoring maintenance overhead
- Not considering query patterns

## Horizontal Scaling (Scaling Out)

### Definitions

- The process of adding more machines to your existing system to handle increased load and distribute it across multiple servers
- Instead of upgrading existing hardware (vertical scaling / scale up), you add more instances of servers
- Distributes load across multiple servers while keeping data synchronized

### Key Components

#### A. Load Balancer

- A device/software that distributes incoming network traffic across multiple servers
- Ensures no single server bears too much load
- Provides failover if one server goes down

#### B. Replication (Read Path)

- Process of copying data from one database server (master) to others (replicas)
- Improves read performance and provides redundancy
- Helps distribute database load across multiple servers

#### C. Sharding (Write Path)

- Technique of splitting database into smaller parts (shards)
- Each shard contains unique portions of data
- Improves write performance and handles large datasets

### Examples

#### Social Media Platform

```sql
Before Scaling:
Single Server
- 1 million users
- Slow photo uploads
- Delayed notifications
- Frequent crashes

After Horizontal Scaling:
└── Load Balancer
    ├── Server 1: User Authentication
    ├── Server 2: Photo Processing
    ├── Server 3: Notification System
    └── Database Layer
        ├── Shard 1: Users A-M
        └── Shard 2: Users N-Z
```

#### E-commerce Website

```sql
Before: Single server handling:
- Product catalog
- User accounts
- Orders
- Payment processing

After Horizontal Scaling:
└── Load Balancer
    ├── Web Servers (3 instances)
    │   └── Product Browsing
    ├── Application Servers
    │   ├── Server 1: User Management
    │   ├── Server 2: Order Processing
    │   └── Server 3: Payment Handling
    └── Database Layer
        ├── Products DB (Master + 2 replicas)
        ├── Orders DB (Sharded by date)
        └── Users DB (Sharded by region)
```

#### Video Streaming Service

```sql
Original Setup:
- Single server
- Limited concurrent streams
- Buffering issues
- Regional delays

Horizontally Scaled:
└── Global Load Balancer
    ├── US Region
    │   ├── Content Servers (5)
    │   └── User Database Shard
    ├── EU Region
    │   ├── Content Servers (4)
    │   └── User Database Shard
    └── Asia Region
        ├── Content Servers (6)
        └── User Database Shard
```

#### Banking Application

```sql
Traditional Setup:
- Single core banking server
- Limited transaction processing
- Slow during peak hours

Scaled Architecture:
└── Load Balancer
    ├── Transaction Servers
    │   ├── Server 1: Deposits
    │   ├── Server 2: Withdrawals
    │   └── Server 3: Transfers
    └── Database Layer
        ├── Account DB
        │   ├── Shard 1 (A-M)
        │   └── Shard 2 (N-Z)
        └── Transaction DB
            ├── Current Month (Master)
            └── Historical (Replicas)
```
