# Column-Oriented Databases

## Definition

Traditional row-oriented databases (like MySQL) store data by rows - imagine a spreadsheet where each row contains all information about one entity. For example:

```sql
UserID | Name  | Age | City
1      | Alice | 25  | Paris
2      | Bob   | 30  | London
```

Column-oriented databases store the same data differently - they group all values from each column together:

```sql
UserID: [1, 2]
Name: [Alice, Bob]
Age: [25, 30]
City: [Paris, London]
```

## UseCase

1. Better Analytics Performance - When you're doing analysis like "what's the average age of users?" or "how many users are in each city?", you only need to read the specific columns involved, not all the data. This makes analytical queries much faster.

2. Better Compression - Since similar data is stored together (all ages together, all cities together), it can be compressed much more efficiently. For example, if you have 1 million users and only 100 different cities, storing those cities together allows for much better compression.

3. Parallel Processing - It's easier to process different columns in parallel since they're stored separately.

## Common column-oriented databases

- Apache Cassandra
- ClickHouse
- Amazon Redshift
- Google BigQuery
