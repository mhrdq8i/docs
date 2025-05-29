# Common Commands

## SQL

### Find Table Foreign Key

Oracle Version

```sql
SELECT uc.constraint_name,
       ucc.column_name,
       uc.r_constraint_name AS referenced_constraint,
       uc.status
FROM user_constraints uc
JOIN user_cons_columns ucc
  ON uc.constraint_name = ucc.constraint_name
WHERE uc.constraint_type = 'R'
  AND uc.table_name = 'MY_TABLE_NAME'

```
