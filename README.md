# cfgov-mysql-to-postgres

Migrating the [consumerfinance.gov](https://www.consumerfinance.gov) website from MySQL to PostgreSQL.

## How to use this repository

This repository consists of a [Docker Compose](https://docs.docker.com/compose/) setup that runs the [pgloader](https://pgloader.io/) tool to convert data from a MySQL 5.1 dump file to PostgreSQL 10.3 dump file.

If using docker-machine, create a Docker machine with suitable memory:

```sh
$ docker-machine create default --driver virtualbox --virtualbox-cpu-count "2" --virtualbox-memory "8192"
$ eval $(docker-machine env)
```

Start the containers in background mode:

```sh
$ docker-compose up -d
```

Run the conversion shell script. This loads a local `mysql.sql.gz` dump into MySQL, runs conversion into Postgres, and dumps it back out as `postgres.sql.gz`:

```sh
$ ./convert.sh
```

To load the dumped data back into a local Postgres:

```sh
$ dropdb --if-exists cfgov && dropuser --if-exists cfpb
$ createuser cfpb && createdb -O cfpb cfgov
$ gunzip < postgres.sql.gz | psql postgres://cfpb@localhost/cfgov
```

The generated Postgres dump will include a `CREATE SCHEMA cfpb` command and so the database user must have permission to execute this command. If the database is created with `createdb -O cfpb`, the `cfpb` user will be an owner and will have sufficient permission to do so.

### Using a local MySQL volume

It is possible to configure the MySQL container to use an external volume for its data storage by defining the `MYSQL_VOLUME` environment variable and using an alternate Compose file:

```sh
$ MYSQL_VOLUME=./data/ docker-compose -f docker-compose.mysql-volume.yml up --build -d
```

This configuration will store all MySQL data files to whatever local path you've specified in the `MYSQL_VOLUME` environment variable, in this example `./data/`.

This approach does a little bit of trickery to make sure that local volume files are created as the right user/group; see the custom `build/Dockerfile-localuser` and related files for more details. This approach doesn't seem to work well with Docker Machine on Mac due to the intermediate layer between the local system and the Docker container.

## Getting help

Use the [issue tracker](https://github.com/cfpb/cfgov-mysql-to-postgres/issues) to follow the
development conversation.
If you find a bug not listed in the issue tracker,
please [file a bug report](https://github.com/cfpb/cfgov-mysql-to-postgres/issues/new).

## Getting involved

We welcome your feedback and contributions.
See the [contribution guidelines](CONTRIBUTING.md) for more details.

## Open source licensing info
1. [TERMS](TERMS.md)
2. [LICENSE](LICENSE)
3. [CFPB Source Code Policy](https://github.com/cfpb/source-code-policy/)
