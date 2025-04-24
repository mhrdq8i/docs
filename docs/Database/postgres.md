# PostgreSQL

## Tips and Docs

### Installation

Debian/Ubuntu

```sh
sudo apt update
sudo apt install postgresql postgresql-client postgresql-contrib
```

Start Postgres service

```sh
sudo service postgresql start
```

### Connect to postgresql via pgsql (localhost)

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

Check your database

```bash
psql -U pg_user -p pg_port(5432) -d pg_db_name
```

### Connect from the other host

1. Find the line `#listen_addresses = 'localhost'` and change it to: `listen_addresses = '*'`

    ```sh
    sudo vim /etc/postgresql/[version]/main/postgresql.conf
    ```

2. change interface listener for all connections

    ```sh
    sudo vim /etc/postgresql/[version]/main/pg_hba.conf
    ```

    ```txt
    host      all     all      0.0.0.0/0          md5
    ```
