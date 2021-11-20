# README

### Local Setup

To install, first ensure that you have `docker` and `docker-compose` installed and running, then clone the repo:

```
git clone git@github.com:lvmbdv/starbase.git
cd starbase
```

Create the local `.env` file and specify any sensitive credentials or other environment variables.

```
REDIS_URL=redis://redis:6379/0
```

Build the containers.

```
docker-compose build
```

Start the containers (detached).

```
docker-compose up -d
```

Get a shell in the web container.

```
docker-compose exec web /bin/bash
```

From here, you'll want to create the database and run any migrations. Please note that you'll want to execute most of your commands from
a shell within the container.

```
bundle exec rails db:create
bundle exec rails db:migrate
```

Start the server.

```
bundle exec rails s -b 0.0.0.0
```

If you need to perform other operations from within the container while the server is running, you can simply get another shell in the web container.

```
docker-compose exec web /bin/bash
```
