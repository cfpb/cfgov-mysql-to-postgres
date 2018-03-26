This process converts a local `mysql.sql` MySQL 5.1 dump file into an equivalent `postgres.sql` PostgreSQL 9.6 dump file.

If using docker-machine, create a Docker machine with suitable memory:

```sh
$ docker-machine create default --driver virtualbox --virtualbox-cpu-count "2" --virtualbox-memory "8192"
```

Start the containers in background mode:

```sh
$ docker-compose up -d
```

Run the conversion shell script. This loads a local `mysql.sql` dump into MySQL, runs conversion into Postgres, and dumps it back out as `postgres.sql`:

```sh
$ ./convert.sh
```

To load the dumped data back into a local Postgres:

```sh
$ dropdb cfgov
$ createdb cfgov
$ createuser cfgov
$ psql cfgov -f postgres.sql
```
