This process converts a local `mysql.sql` MySQL 5.1 dump file into an equivalent `postgres.sql` PostgreSQL 9.6 dump file.

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
$ dropdb cfgov
$ createdb cfgov
$ createuser cfgov
$ gunzip < postgres.sql.gz | psql cfgov
```

### Using a local MySQL volume

It is possible to configure the MySQL container to use an external volume for its data storage by defining the `MYSQL_VOLUME` environment variable and using an alternate Compose file:

```sh
$ MYSQL_VOLUME=./data/ docker-compose -f docker-compose.mysql-volume.yml up --build -d
```

This configuration will store all MySQL data files to whatever local path you've specified in the `MYSQL_VOLUME` environment variable, in this example `./data/`.

This approach does a little bit of trickery to make sure that local volume files are created as the right user/group; see the custom `build/Dockerfile-localuser` and related files for more details. This approach doesn't seem to work well with Docker Machine on Mac due to the intermediate layer between the local system and the Docker container.
