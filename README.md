# Training Log

A training log for recording gym workouts, built as a SQL Server database with an ASP.NET Core API on top. I'm building it for my own training, and as a way to practise database design, layered architecture and testing.

**Status:** in progress (started October 2026).

## Plan

- [ ] SQL Server database: schema, sample data, a transaction, views, reports and indexes
- [ ] ASP.NET Core Web API with controllers, services and repositories, plus unit tests
- [ ] Front-end, login, deployment and an AI feature (later)

## Planned tech

SQL Server (T-SQL), C#, ASP.NET Core, Entity Framework Core, xUnit.

## Database design

Five tables:

| Table | Purpose |
|---|---|
| `muscle_groups` | Chest, back, legs and so on |
| `exercises` | Each exercise, linked to a muscle group |
| `workouts` | One row per training session |
| `workout_sets` | The sets in a workout: exercise, reps and weight |
| `body_metrics` | Body weight over time |

![Entity relationship diagram](docs/erd.png)

## Repository structure

```
training-log/
├── database/     SQL scripts, run in numerical order
├── docs/         diagrams and notes
├── TrainingLog.Api/     (planned)
├── TrainingLog.Tests/   (planned)
├── .gitignore
├── LICENSE
└── README.md
```

## Author

Built by [@pedronatanie1](https://github.com/pedronatanie1).
