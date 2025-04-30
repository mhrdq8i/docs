# PostgreSQL

## Tips and Docs

### Installation

Debian/Ubuntu

```sh
sudo apt update
sudo apt install postgresql postgresql-client postgresql-contrib
```

Start the Postgres service

```sh
sudo service postgresql start
```

### Connect to PostgreSQL via pgsql (localhost)

Create a PostgreSQL user and database

```sh
sudo -u postgres psql
```

```sql
CREATE USER your_username WITH PASSWORD 'your_password';
CREATE DATABASE database_name;
GRANT ALL PRIVILEGES ON DATABASE database_name TO your_username;
\q
```

Check your database username and connection

```sh
psql --username pg_user --host pg_hostname --port pg_port --dbname pg_dbname
```

### PG commands

```postgres
\l
get the list of databases

\d
get the list of tables

\connect DBNAME
connect to the existing DB
```

#### Change PG password

```postgres
\password postgres
OR
ALTER USER user_name PASSWORD 'new_password';
```

### Connect from the other host

1. Find the line `#listen_addresses = 'localhost'` and change it to: `listen_addresses = '*'`

    ```sh
    sudo vim /etc/postgresql/[version]/main/postgresql.conf
    ```

2. Change the interface listener for all connections

    ```sh
    sudo vim /etc/postgresql/[version]/main/pg_hba.conf
    ```

    ```txt
    host      all     all      0.0.0.0/0          md5
    ```
