# Ribon-poke-api

This project is an REST API that serves pokemon data without authentication needed. The data is fetched initially from [pokeapi](https://pokeapi.co) using a rake task.

# Prerequisites

- Ruby 2.6.0
- Rails 5.2
- Postgres >= 10
- S3 AWS credentials (in case of running in production)

# How to use (locally)

1. Copy repository and enter in project folder.
```
$ git clone https://github.com/Markuus13/ribon-poke-api.git
$ cd ribon-poke-api
```
2. Run bundle to install dependencies.
```
$ bundle
```
3. Setup the database.
```
$ rails db:setup
$ rails db:migrate
```
4. Fetch data from pokeapi using custom rake task.
```
$ rails fetch_from_pokeapi:all
```
5. Everything should work fine.
```
$ rails s
```