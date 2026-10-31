# Training Log

A training log for recording gym workouts, built as a SQL Server database with an ASP.NET Core API on top. I'm building it for my own training, and as a way to practise database design, layered architecture and testing.

**Status:** in progress (started October 2026). The database is complete. The API is in progress: exercises and workout logging work end to end; body metrics, reports and unit tests are next.

## Plan

- [x] SQL Server database: schema, sample data, a transaction, views, reports and indexes
- [ ] ASP.NET Core Web API with controllers, services and repositories, plus unit tests
  - [x] Layered structure, EF Core, DTOs and global error handling
  - [x] Exercises and muscle groups endpoints
  - [x] Workout logging with validation and a transactional save
  - [ ] Body metrics and reports endpoints
  - [ ] Unit tests (xUnit, fake repositories)
- [ ] Front-end, login, deployment and an AI feature (later)

## Tech

SQL Server (T-SQL) for the database. The API uses C#, ASP.NET Core (.NET 10) and Entity Framework Core 10. Planned: xUnit for unit tests.

## How to run

Requirements: SQL Server LocalDB (installed with Visual Studio) or any SQL Server instance, plus SQL Server Management Studio or Visual Studio's SQL Server Object Explorer.

1. Connect to `(localdb)\MSSQLLocalDB`.
2. Open the scripts in `database/` and execute them in order:

| Script | What it does |
|---|---|
| `01_schema.sql` | Drops and recreates the `TrainingLog` database, then creates the five tables with their constraints |
| `02_seed.sql` | Inserts 9 muscle groups, 43 exercises, 15 workouts over three weeks (306 sets) and weekly body weight |
| `03_log_workout_transaction.sql` | Demonstrates an all-or-nothing transaction (fails on purpose, see below) |
| `04_views.sql` | Creates the workout history and weekly volume views |
| `05_reports.sql` | Personal records, progress over time and summary reports |
| `06_indexes.sql` | Adds indexes on the most-used foreign keys and filter columns |

`01_schema.sql` starts with a reset block, so running 01 to 06 again always gives a clean database. Script 03 stops with an error by design; the other scripts don't depend on it.

### Running the API

Requirements: the .NET 10 SDK, and the database created with the scripts above.

1. Check the connection string `TrainingLog` in `TrainingLog.Api/appsettings.json` points to your server (by default `(localdb)\MSSQLLocalDB`, database `TrainingLog`).
2. Open `TrainingLog.slnx` in Visual Studio and run the `http` profile, or run `dotnet run --project TrainingLog.Api` from the repo root.
3. The API listens on `http://localhost:5097`. `TrainingLog.Api/TrainingLog.Api.http` has a ready-made request for every endpoint, including the validation checks.

## Database design

Five tables:

| Table | Purpose |
|---|---|
| `muscle_groups` | Chest, back, legs and so on |
| `exercises` | Each exercise, linked to a muscle group |
| `workouts` | One row per training session |
| `workout_sets` | The sets in a workout: exercise, weight, and reps, a duration or a distance |
| `body_metrics` | Body weight over time, one entry per day |

![Entity relationship diagram](docs/erd.png)

The diagram's source is `docs/erd.dbml` (open it in [dbdiagram.io](https://dbdiagram.io) to edit).

### Design decisions

- **A separate `workout_sets` table.** A workout has a variable number of sets. Columns like `set1`, `set2`, `set3` would break first normal form, so each set is its own row linked to its workout.
- **A separate `muscle_groups` table.** The muscle group is a fact about the exercise, not about each set, so it's stored once per exercise instead of being repeated on every row.
- **`DECIMAL` for weights and distances, never `FLOAT`.** `DECIMAL(6,2)` stores 62.5 kg exactly. `FLOAT` stores approximations, which can break comparisons like "is this a personal record?".
- **CHECK constraints in the database.** Reps, set numbers, durations and distances must be positive, weight can't be negative, and body weight must be between 20 and 400 kg. The API will validate the same rules for friendly error messages, but the database guarantees correctness even if something else writes to it.
- **Optional measures with a "has a measure" rule.** Not every set is counted in reps: Battle Ropes is timed, Farmer Carry is a distance. `reps`, `duration_seconds` and `distance_metres` are all nullable, and `ck_sets_has_measure` requires at least one of them, so a set can never be saved with nothing recorded.
- **Restricted and cascading deletes.** Deleting a workout deletes its sets (`ON DELETE CASCADE`). Deleting an exercise that has logged sets is blocked, to protect the training history.
- **A transaction for logging a workout.** A workout and its sets are saved together or not at all (see the next section).

## Transaction: all or nothing

A workout and its sets must be saved together. Without a transaction, a failure halfway through would leave a workout with only some of its sets. `database/03_log_workout_transaction.sql` inserts a workout and three sets inside `BEGIN TRY` / `BEGIN TRANSACTION`, with `SET XACT_ABORT ON` and a `ROLLBACK` in the `CATCH` block.

The script is committed in its failing form on purpose: the third set has `-5` reps, which the `ck_sets_reps` CHECK constraint rejects. To reproduce the proof:

1. **Run the script as it is.** It fails with a CHECK constraint error on `ck_sets_reps`.
2. **Check nothing was saved:** `SELECT * FROM dbo.workouts WHERE notes = 'Transaction test';` returns no rows. The workout was inserted before the failure, but the rollback undid it along with the first two sets.
3. **Change `-5` to `5` and run it again.** This time the workout and all three sets are saved.
4. **Clean up:** `DELETE FROM dbo.workouts WHERE notes = 'Transaction test';` removes the test workout, and `ON DELETE CASCADE` removes its sets.

This proves the database never keeps a partial workout. The API will rely on the same idea, because Entity Framework's `SaveChanges` wraps the workout and its sets in one transaction.

## The API (in progress)

An ASP.NET Core Web API on top of the database, built in layers so each part has one job:

```
Controller  →  Service  →  Repository  →  EF Core  →  SQL Server
(HTTP only)    (rules)     (queries)
```

- **Controllers** read the request, call one service method and choose the status code. No business rules or queries.
- **Services** hold the validation and mapping, and throw `BadRequestException` or `NotFoundException` when something is wrong. They depend on repository interfaces, not on EF Core, so they can be unit tested with fakes.
- **Repositories** contain every EF Core query.
- **DTOs** (C# records) define the JSON the API accepts and returns, so entities never leave the API.
- **A global exception handler** (`IExceptionHandler`) turns those exceptions into `400` and `404` responses in the standard `ProblemDetails` format. Unexpected errors return `500` without internal details and are logged with the stack trace.

### Endpoints so far

| Method | Route | Purpose | Success |
|---|---|---|---|
| GET | `/api/muscle-groups` | All muscle groups | 200 |
| GET | `/api/exercises` | All exercises with their muscle group | 200 |
| POST | `/api/exercises` | Add an exercise (name required, unique, valid muscle group) | 201 |
| GET | `/api/workouts?count=10` | Most recent workouts with their sets | 200 |
| GET | `/api/workouts/{id}` | One workout with its sets and exercise names | 200 / 404 |
| POST | `/api/workouts` | Log a workout and all its sets in one request | 201 |
| DELETE | `/api/workouts/{id}` | Delete a workout (its sets are deleted by cascade) | 204 / 404 |

Logging a workout is validated before anything touches the database: a date that isn't in the future, notes up to 500 characters, at least one set, positive set numbers, each set has reps, a duration or a distance, positive values, weights within the column's range, no repeated set number for the same exercise, and every exercise must exist. Timed and distance sets simply leave `reps` out:

```json
{
  "date": "2026-10-30",
  "notes": "Push day",
  "sets": [
    { "exerciseId": 1, "setNumber": 1, "reps": 8, "weightKg": 35 },
    { "exerciseId": 43, "setNumber": 1, "weightKg": 0, "durationSeconds": 20 }
  ]
}
```

### Transaction proof through the API

The SQL script above proves the database never keeps a partial workout. I repeated the proof through the API: with the API's "reps must be greater than 0" check temporarily disabled, I sent a workout whose third set had `reps = -5`. The database's `ck_sets_reps` constraint rejected the insert and the API returned 500. The number of rows in `workouts` and `workout_sets` was the same before and after, so the workout and its first two valid sets were rolled back too. EF Core's `SaveChanges` wraps the workout and all its sets in one transaction. The check was then restored, so normally the API returns a clear 400 before the database is reached.

## Views

`database/04_views.sql` creates two views for reports I run often:

| View | One row per | Shows |
|---|---|---|
| `vw_workout_history` | workout | date, notes, total sets, exercises done, total volume (kg), total duration (s), total distance (m) |
| `vw_weekly_volume` | ISO week and muscle group | volume (kg) for each muscle group each week |

**Volume** is reps × weight, summed. Timed and distance sets have no reps, so they add nothing to volume; `ISNULL(..., 0)` shows 0 instead of NULL when a group has only those sets. Duration and distance get their own totals in `vw_workout_history`.

```sql
SELECT * FROM dbo.vw_weekly_volume
WHERE week_number = 39
ORDER BY muscle_group;
```

| year_number | week_number | muscle_group | total_volume_kg |
|---|---|---|---|
| 2026 | 39 | Arms | 850.00 |
| 2026 | 39 | Back | 4460.00 |
| 2026 | 39 | Calves | 8320.00 |
| 2026 | 39 | Chest | 3129.00 |
| 2026 | 39 | Core | 0.00 |
| 2026 | 39 | Forearms | 0.00 |
| 2026 | 39 | Legs | 4130.00 |
| 2026 | 39 | Shoulders | 1810.00 |
| 2026 | 39 | Traps | 480.00 |

Core and Forearms show 0 because that week's core work was bodyweight or timed (hanging leg raise, plank) and the forearm work was a distance (farmer carry).

**Checked by hand:** Chest in week 39 is Bench Press 5 × 100 + 5 × 105 + 5 × 110 = 1,575, Incline Dumbbell Press 22 × (10 + 10 + 9 + 8) = 814, and Dips 20 × (10 + 10 + 9 + 8) = 740, for a total of 3,129 kg, which matches the view.

## Reports

`database/05_reports.sql` uses CTEs and window functions:

- **Personal record per exercise:** `ROW_NUMBER()` partitioned by exercise picks the heaviest set (ties go to more reps, then the earliest date). Only rep-based sets count.
- **Progress over time:** the best weight per day, with `LAG()` showing the change since the previous session, for Bench Press and for any exercise via a `@exercise` variable.
- **Total body weight change:** the latest entry minus the earliest.
- **Sessions per ISO week.**
- **Best timed and distance sets:** the longest Farmer Carry, Plank and Battle Ropes efforts, using the duration and distance columns.

Sample output of the personal records query (first rows):

| exercise | workout_date | reps | weight_kg |
|---|---|---|---|
| Bench Press | 2026-10-05 | 5 | 115.00 |
| Box Jump | 2026-09-22 | 3 | 0.00 |
| Bulgarian Split Squat | 2026-10-08 | 10 | 20.00 |
| Chest-Supported Row | 2026-10-07 | 10 | 24.00 |
| Chin-Up | 2026-09-25 | 10 | 0.00 |
| Dips | 2026-10-09 | 10 | 25.00 |

For bodyweight exercises (weight 0) the tie-breakers pick the best rep count, then the first date it was reached, which is why Chin-Up shows the first week.

## Indexes

`database/06_indexes.sql` adds three indexes on columns used often in joins and filters. SQL Server indexes primary keys and UNIQUE columns automatically, but not foreign keys.

| Index | Column | Helps with |
|---|---|---|
| `ix_sets_exercise` | `workout_sets.exercise_id` | all sets of one exercise (personal records, progress) |
| `ix_workouts_date` | `workouts.workout_date` | date filters and ordering (history, weekly volume) |
| `ix_exercises_muscle_group` | `exercises.muscle_group_id` | joining exercises to muscle groups |

There is no separate index on `workout_sets.workout_id`: the `uq_set` unique constraint `(workout_id, exercise_id, set_number)` already created one that starts with it, and a second one would only slow down writes.

**Measuring it.** `docs/index_check.sql` runs two queries with `SET STATISTICS IO ON` and the actual execution plan, before and after creating the indexes:

| Query | Before | After |
|---|---|---|
| Sets for one exercise (9 rows) | Index Scan on `uq_set`, 2 logical reads | Index Seek on `ix_sets_exercise`, 2 logical reads |
| Workouts in a date range (5 rows) | Clustered Index Scan, 3 logical reads | Index Seek on `ix_workouts_date`, 2 logical reads |

Before the new index, SQL Server answered the first query by scanning the whole `uq_set` index: it contains `exercise_id` (plus the primary key), but as its second column, so it can't seek on it. With `ix_sets_exercise` it seeks straight to the matching rows.

With only a few hundred rows the difference in reads is small (0 and 1 page), because each table fits in a handful of pages. The change that matters is from scan to seek: a scan grows with the table, a seek doesn't. Indexes pay off at scale, and this check shows how to confirm one is actually used.

## Known limitations

- **ISO weeks around New Year.** `vw_weekly_volume` takes the week from `DATEPART(ISO_WEEK, ...)` but the year from `DATEPART(YEAR, ...)`. ISO week 52 or 53 can belong to the previous year, so for a few days around 1 January the year and week can look mismatched (for example, 1 January 2027 shows as week 53 of 2027 instead of 2026). The sample data (September to October) isn't affected.
- **Volume counts only rep-based sets.** Timed and distance sets are tracked separately.
- **Weighted bodyweight exercises** (weighted pull-ups, dips) store only the added weight, so their volume is lower than the true load.
- **One body weight entry per day**, enforced by a UNIQUE constraint.
- **Sample data.** The workouts follow my real weekly routine, but the dates, weights and body weight entries are sample values, not a real training log.
- **Duplicate exercise names return 400.** A 409 Conflict would be more precise; 400 keeps the error handling simple for now.
- **No authentication yet.** Anyone who can reach the API can read and change data.
- **Security pin.** `System.Security.Cryptography.Pkcs` is referenced directly to override a vulnerable version pulled in by the SQL Server driver.

## Repository structure

```
training-log/
├── database/              SQL scripts, run in numerical order (01 to 06)
├── docs/
│   ├── erd.png            entity relationship diagram
│   ├── erd.dbml           diagram source for dbdiagram.io
│   └── index_check.sql    before/after index measurement
├── TrainingLog.Api/       ASP.NET Core Web API (in progress)
│   ├── Controllers/       HTTP endpoints
│   ├── Services/          validation and business rules
│   ├── Repositories/      EF Core queries, behind interfaces
│   ├── Entities/          classes mapped to the tables
│   ├── Dtos/              request and response records
│   ├── Exceptions/        custom exceptions and the global handler
│   ├── Data/              TrainingLogContext
│   └── TrainingLog.Api.http   example requests for every endpoint
├── TrainingLog.Tests/     (next: unit tests)
├── TrainingLog.slnx
├── .gitignore
├── LICENSE
└── README.md
```

## Next

Finish the API: body metrics, reports (personal records, progress, weekly volume) and xUnit tests for the services using fake repositories. Then a React front-end, login and deployment.

## Author

Built by [@pedronatanie1](https://github.com/pedronatanie1).
