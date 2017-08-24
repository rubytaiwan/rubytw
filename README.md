Ruby Taiwan Official Site
===

## Requirements

- Ruby 2.4.1+
- PostgreSQL 9.6
- Node.js 8.0+
- Yarn

## Development

Install dependencies
```
$ bundle install
```

If you didn't create database, please run below command
```
$ rake db:create
```

Create tables
```
$ rake db:migrate
```

Install Front-end scripts
```
$ yarn
```

Prepare FAE
```
$ rake fae:db_seed
```

Starting Rails
```
$ rails server
```

> `./bin/webpack-dev-server` didn't necessary now
