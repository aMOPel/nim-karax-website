[creationTime]:- "Jun 20. 2023"
[lastWriteTime]:- "Jun 20. 2023"

# Full Stack Project

<a hidden href="https://github.com/aMOPel/nim-karax-website/tree/amopels_content">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

A Full Stack Application, I have not open sourced yet. 
It uses [NestJS](https://nestjs.com/) in the backend and
[Angular](https://angular.io/) in the frontend.

## Context

I had no prior experience with either framework, so this project has been an
exciting but challenging learning experience for me.

I started with building the Backend, which is now mostly working as expected
and moved on to the frontend, which has been more challenging for me.
The proper design of User Interfaces had been explored by me before and turned
out to be a very time consuming task.

## Backend

A stateless CRUD backend.

### Technologies

* `TypeScript`
* `NodeJS`
* `NestJS` (full featured Javascript backend framework similar to Spring Boot)
* `PostgreSQL` as the DB (in a Docker Container)
* `TypeORM` to interface with Postgres
* `Jest` as the test framework and runner
* `supertest` to simulate http requests in E2E tests
* `class-validator`/`joi` for validation

### Features

* **14 Entities** with various relations to each other
* **HTTP CRUD API** for all entities (`GET`, `GET :id`, `PUT`, `PATCH :id`, `DELETE :id`)
* **Full validation** of request body for each entity
* **Error handling** with HTTP error codes for
    * ID not found: `404 Not found`
    * Resending the same request (API is idempotent): `409 Conflict/404 Not Found `
    * Sending invalid body: `400 Bad Request`
* **`.env` file** for DB configuration + `docker-compose` to run it
    * `.env` file schema is also validated
* **E2E tests** for all endpoints, using
    * Data fixtures in `json` files
    * Four parallel Postgres containers
        * One for each of `GET`, `PUT`, `PATCH`, `DELETE`
        * To improve test speed and make tests independent
        * `.env` file + `docker-compose` to run them

## Frontend

UI to match CRUD backend.

### Technologies

* `TypeScript`
* `Angular`
* [`primeng`](https://primeng.org/) Angular UI Components
* [`tailwindcss`](https://tailwindcss.com/) CSS Framework

### Features

* **Responsive Design** UI choices to accommodate both Mobile and Desktop
* **UI to CRUD the backend** some entities need specialized UI
